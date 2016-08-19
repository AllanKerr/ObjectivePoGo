//
//  PKRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGRequestGroup.h"
#import "RequestEnvelope.pbobjc.h"
#import "ResponseEnvelope.pbobjc.h"
#import "AuthTicket.pbobjc.h"
#import "Request.pbobjc.h"
#import "Signature.pbobjc.h"
#import "Unknown6.pbobjc.h"
#import "xxhash.h"
#import "encrypt.h"
#import "PGSensorSpoofer.h"
#import "PGResponseBuilder.h"
#import "PGConstants.h"

@interface PGRequestGroup ()
@property (nonatomic, strong) id <PGRequestInfoProvider>infoProvider;
@property (nonatomic, strong) PKRequestCompletion completion;
@property (nonatomic, strong) RequestEnvelope *requestEnvelope;
@property (nonatomic, strong) PGResponseBuilder *responseBuilder;
@end

@implementation PGRequestGroup

- (id)initWithInfoProvider:(id <PGRequestInfoProvider>)infoProvider completion:(PKRequestCompletion)completion {
    if (self = [super init]) {
        self.responseBuilder = [[PGResponseBuilder alloc] init];
        self.infoProvider = infoProvider;
        self.completion = completion;
        [self _buildRequestEnvelope];
    }
    return self;
}

- (void)_buildRequestEnvelope {
    self.requestEnvelope = [RequestEnvelope message];
    self.requestEnvelope.statusCode = 2;
    self.requestEnvelope.requestId = [[NSDate date] timeIntervalSince1970] * 1000;
    
    CLLocation *location = self.infoProvider.location;
    if (location != nil) {
        self.requestEnvelope.latitude = location.coordinate.latitude;
        self.requestEnvelope.longitude = location.coordinate.longitude;
        self.requestEnvelope.altitude = location.altitude;
    }
    if (![self _addAuthTicket]) {
        [self _addAuthInfo];
    }
    self.requestEnvelope.unknown12 = 989;
}

- (BOOL)_addAuthTicket {
    AuthTicket *lastTicket = self.infoProvider.ticket;
    int64_t currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    if (lastTicket != nil && ((int64_t)lastTicket.expireTimestampMs - currentTime) >= 0) {
        AuthTicket *authTicket = [AuthTicket message];
        authTicket.start = lastTicket.start;
        authTicket.expireTimestampMs = lastTicket.expireTimestampMs;
        authTicket.end = lastTicket.end;
        self.requestEnvelope.authTicket = authTicket;
        return YES;
    }
    return NO;
}

- (void)_addAuthInfo {
    RequestEnvelope_AuthInfo *authInfo = [RequestEnvelope_AuthInfo message];
    authInfo.provider = PGPokemonApiService;
    authInfo.token.contents = self.infoProvider.accessToken;
    authInfo.token.unknown2 = 59;
    self.requestEnvelope.authInfo = authInfo;
}

- (void)_addUnknown6 {
    if (self.requestEnvelope.hasAuthTicket) {
        Unknown6 *unknown6 = [Unknown6 new];
        unknown6.requestType = 6;
        
        Unknown6_Unknown2 *unknown6Unknown2 = [Unknown6_Unknown2 new];
        Signature *signature = [self buildSignature:self.requestEnvelope.authTicket];
        unknown6Unknown2.encryptedSignature = [self generateSignatureData:signature];
        unknown6.unknown2 = unknown6Unknown2;
        
        [self.requestEnvelope.unknown6Array addObject:unknown6];
    }
}

- (Signature *)buildSignature:(AuthTicket *)ticket {
    CLLocation *location = self.infoProvider.location;
    double latitude = location.coordinate.latitude;
    double longitude = location.coordinate.longitude;
    double altitude = location.altitude;
    
    Signature *signature = [Signature new];
    signature.locationHash1 = [self generateLocation1:ticket latitude:latitude longitude:longitude altitude:altitude];
    signature.locationHash2 = [self generateLocation2:latitude longitude:longitude altitude:altitude];
    
    if (self.infoProvider.locationFixes != nil) {
        [signature.locationFixArray addObjectsFromArray:self.infoProvider.locationFixes];
    }
    uint64_t currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    uint64_t timeSinceStart = currentTime - self.infoProvider.startTime;
    PGSensorInfo *sensorInfo = self.infoProvider.sensorInfo;
    Signature_SensorInfo *sigSensorInfo = [Signature_SensorInfo message];
    sigSensorInfo.timestampSnapshot = timeSinceStart;
    sigSensorInfo.magnetometerX = sensorInfo.magnetometerX;
    sigSensorInfo.magnetometerY = sensorInfo.magnetometerY;
    sigSensorInfo.magnetometerZ = sensorInfo.magnetometerZ;
    sigSensorInfo.angleNormalizedX = sensorInfo.angleNormalizedX;
    sigSensorInfo.angleNormalizedY = sensorInfo.angleNormalizedY;
    sigSensorInfo.angleNormalizedZ = sensorInfo.angleNormalizedZ;
    sigSensorInfo.accelRawX = sensorInfo.accelRawX;
    sigSensorInfo.accelRawY = sensorInfo.accelRawY;
    sigSensorInfo.accelRawZ = sensorInfo.accelRawZ;
    sigSensorInfo.gyroscopeRawX = sensorInfo.gyroscopeRawX;
    sigSensorInfo.gyroscopeRawY = sensorInfo.gyroscopeRawY;
    sigSensorInfo.gyroscopeRawZ = sensorInfo.gyroscopeRawZ;
    sigSensorInfo.accelNormalizedX = sensorInfo.accelNormalizedX;
    sigSensorInfo.accelNormalizedY = sensorInfo.accelNormalizedY;
    sigSensorInfo.accelNormalizedZ = sensorInfo.accelNormalizedZ;
    sigSensorInfo.accelerometerAxes = 3;
    signature.sensorInfo = sigSensorInfo;
    
    PGDeviceInfo *deviceInfo = self.infoProvider.deviceInfo;
    Signature_DeviceInfo *sigDeviceInfo = [Signature_DeviceInfo message];
    sigDeviceInfo.deviceId = deviceInfo.deviceId;
    sigDeviceInfo.deviceBrand = deviceInfo.deviceBrand;
    sigDeviceInfo.deviceModel = deviceInfo.deviceModel;
    sigDeviceInfo.deviceModelBoot = deviceInfo.deviceModelBoot;
    sigDeviceInfo.hardwareManufacturer = deviceInfo.hardwareManufacturer;
    sigDeviceInfo.hardwareModel = deviceInfo.hardwareModel;
    sigDeviceInfo.firmwareBrand = deviceInfo.firmwareBrand;
    sigDeviceInfo.firmwareType = deviceInfo.firmwareType;
    signature.deviceInfo = sigDeviceInfo;
    
    signature.activityStatus = [Signature_ActivityStatus message];
    
    for (Request *request in self.requestEnvelope.requestsArray) {
        uint64_t hash = [self generateRequestHash:request authTicket:ticket];
        [signature.requestHashArray addValue:hash];
    }
    signature.unk22 = [self uRandom:32];
    signature.timestamp = currentTime;
    signature.timestampSinceStart = timeSinceStart;    
    return signature;
}

- (uint32_t)generateLocation1:(AuthTicket *)authTicket latitude:(double)latitude longitude:(double)longitude altitude:(double)altitude {
    // need to serialize authentication ticket for calculating location hash 1
    uint32_t firstHash = XXH32(authTicket.data.bytes, authTicket.data.length, PGHashSeed);
    
    NSData *latitudeHexData = [self doubleToHexData:latitude];
    NSData *longitudeHexData = [self doubleToHexData:longitude];
    NSData *altitudeHexData = [self doubleToHexData:altitude];
    
    NSMutableData *locationBytesData = [NSMutableData data];
    [locationBytesData appendData:latitudeHexData];
    [locationBytesData appendData:longitudeHexData];
    [locationBytesData appendData:altitudeHexData];
    
    return XXH32(locationBytesData.bytes, locationBytesData.length, firstHash);
}

- (uint32_t)generateLocation2:(double)latitude longitude:(double)longitude altitude:(double)altitude {
    NSData *latitudeHexData = [self doubleToHexData:latitude];
    NSData *longitudeHexData = [self doubleToHexData:longitude];
    NSData *altitudeHexData = [self doubleToHexData:altitude];
    
    NSMutableData *locationBytesData = [NSMutableData data];
    [locationBytesData appendData:latitudeHexData];
    [locationBytesData appendData:longitudeHexData];
    [locationBytesData appendData:altitudeHexData];
    
    return XXH32(locationBytesData.bytes, locationBytesData.length, PGHashSeed);
}

- (uint64_t)generateRequestHash:(Request *)request authTicket:(AuthTicket *)authTicket {
    NSData *authTicketData = authTicket.data;
    NSData *requestData = request.data;
    uint64_t firstHash = XXH64(authTicketData.bytes, authTicketData.length, PGHashSeed);
    return XXH64(requestData.bytes, requestData.length, firstHash);
}

- (NSData *)generateSignatureData:(Signature *)signature {
    NSData *signatureData = signature.data;
    NSData *ivData = [self uRandom:32];
    
    // get output size
    size_t outputSize;
    int result = encrypt6(signatureData.bytes, signatureData.length, ivData.bytes, ivData.length, NULL, &outputSize);
    // create output buffer
    unsigned char output[outputSize];
    memset(output, 0, outputSize);
    
    result = encrypt6(signatureData.bytes, signatureData.length, ivData.bytes, ivData.length, output, &outputSize);
    return [NSData dataWithBytes:output length:outputSize];
}

- (NSData *)uRandom:(NSInteger)bytes {
    int error = 0;
    NSMutableData* data = [NSMutableData dataWithLength:bytes];
    error = SecRandomCopyBytes(kSecRandomDefault, bytes, [data mutableBytes]);
    if (error) {
        NSLog(@"Generate random bytes failed");
        return nil;
    }
    return data;
}

- (NSData *)doubleToHexData:(double)value {
    uint64_t valueBits;
    memcpy(&valueBits, &value, sizeof(valueBits));
    unsigned char bytes[] = {
        (unsigned char) (valueBits >> 56),
        (unsigned char) (valueBits >> 48),
        (unsigned char) (valueBits >> 40),
        (unsigned char) (valueBits >> 32),
        (unsigned char) (valueBits >> 24),
        (unsigned char) (valueBits >> 16),
        (unsigned char) (valueBits >> 8),
        (unsigned char) valueBits
    };
    return [NSData dataWithBytes:bytes length:sizeof(bytes)];
}

- (void)addRequest:(PGRequest *)request {
    [self.requestEnvelope.requestsArray addObject:request.rawRequest];
    [self.responseBuilder addRequestType:request.type];
}

- (void)start {
    [self _addUnknown6];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.infoProvider.apiURL]];
    [request setValue:PGPokemonApiRequestUserAgent forHTTPHeaderField:@"User-Agent"];
    request.HTTPBody = self.requestEnvelope.data;
    request.HTTPMethod = @"POST";
    
    NSThread *currentThread = [NSThread currentThread];
    NSURLSession *session = [self.infoProvider.sessionManager session];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        if (error != nil || res.statusCode != 200) {
            [self performSelector:@selector(_failedWithError:) onThread:currentThread withObject:error waitUntilDone:NO];
        } else {
            NSError *parseError;
            ResponseEnvelope *responseEnvelope = [ResponseEnvelope parseFromData:data error:&parseError];
            if (error == nil) {
                [self performSelector:@selector(_recievedResponse:) onThread:currentThread withObject:responseEnvelope waitUntilDone:NO];
            } else {
                [self performSelector:@selector(_failedWithError:) onThread:currentThread withObject:parseError waitUntilDone:NO];
            }
        }
    }];
    [task resume];
}

- (void)_recievedResponse:(ResponseEnvelope *)responseEnvelope {
    if (responseEnvelope.apiURL.length > 0) {
        NSString *apiURL = [NSString stringWithFormat:@"https://%@/rpc", responseEnvelope.apiURL];
        [self.infoProvider updateApiURL:apiURL];
    }
    if (responseEnvelope.hasAuthTicket) {
        [self.infoProvider updateTicket:responseEnvelope.authTicket];
        NSMutableArray *requestsArray = self.requestEnvelope.requestsArray;
        [self _buildRequestEnvelope];
        [self.requestEnvelope.requestsArray addObjectsFromArray:requestsArray];
        [self start];
    } else if (responseEnvelope.statusCode == 102) {
        self.completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeExpiredAuthTicket userInfo:nil]);
    } else if (responseEnvelope.statusCode == 1 || responseEnvelope.statusCode == 2) {
        NSArray *responses = [self.responseBuilder buildFromEnvelope:responseEnvelope];
        self.completion(responses, nil);
    } else {
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"status code:%i", responseEnvelope.statusCode]};
        self.completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeRequestFailed userInfo:userInfo]);
    }
}

- (void)_failedWithError:(NSError *)error {
    self.completion(nil, error);
}

@end
