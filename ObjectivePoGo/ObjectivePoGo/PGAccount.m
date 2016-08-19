//
//  PKAccount.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGAccount.h"
#import "PGRequestGroup.h"
#import "PGGetPlayerRequest.h"
#import "PGGetMapObjectsRequest.h"
#import "PGAcceptTermsOfServiceRequest.h"
#import "PGDownloadSettingsRequest.h"
#import "PGGetInventoryRequest.h"
#import "PGGetHatchedEggsRequest.h"
#import "PGCheckAwardedBadgesRequest.h"
#import "PGDownloadRemoteConfigVersionRequest.h"
#import "PGResponse.h"
#import <DDURLParser.h>

#import "GetPlayerResponse.pbobjc.h"
#import "GetMapObjectsResponse.pbobjc.h"
#import "MarkTutorialCompleteResponse.pbobjc.h"
#import "Signature.pbobjc.h"
#import "PGSensorSpoofer.h"
#import "InventoryDelta.pbobjc.h"

#define ARC4RANDOM_MAX 0x100000000

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
#define RADIANS_TO_DEGREES(radians)((180 * radians)/M_PI)

typedef void(^PGPrepareLoginCompletion)(NSString *lt, NSString *execution, NSError *error);
typedef void(^PGGetTicketCompletion)(NSString *ticket, NSError *error);
typedef void(^PGAsyncCompletion)(NSError *error);

@interface PGAccount ()
@property (readonly, nonatomic) NSTimeInterval timeSinceQuery;
@property (readwrite, nonatomic) BOOL isFetching;
@property (readwrite, nonatomic) NSTimeInterval lastQueryTime;
@property (readwrite, nonatomic) NSTimeInterval minUpdateInterval;
@property (readwrite, nonatomic) CLLocationDistance baseAltitude;
@property (readwrite, nonatomic) double baseTravelRate;
@property (readwrite, nonatomic) int64_t inventoryTimeStamp;
@property (readwrite, nonatomic, strong) NSString *downloadSettingsHash;
@property (readwrite, nonatomic ,strong) PGAccountInfo *accountInfo;

// PGRequestInfoProvider Properties
@property (readwrite, nonatomic) uint64_t startTime;
@property (readwrite, nonatomic) uint64_t requestID;
@property (readwrite, nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (readwrite, nonatomic, strong) NSString *apiURL;
@property (readwrite, nonatomic, strong) AuthTicket *ticket;
@property (readwrite, nonatomic, strong) NSString *accessToken;
@property (readwrite, nonatomic, strong) CLLocation *location;
@property (readwrite, nonatomic, strong) CLLocation *lastLocation;
@property (readwrite, nonatomic, strong) NSArray *locationFixes;
@property (readwrite, nonatomic) NSInteger maxLocationFixCount;
@property (readwrite, nonatomic, strong) PGSensorInfo *sensorInfo;
@property (readwrite, nonatomic, strong) PGDeviceInfo *deviceInfo;
@end

@implementation PGAccount
@dynamic isReadyForQuery;
@dynamic timeSinceQuery;

- (BOOL)isReadyForQuery {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    return !self.isFetching && currentTime >= self.lastQueryTime + self.minUpdateInterval;
}

- (NSTimeInterval)timeSinceQuery {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    return currentTime - self.lastQueryTime;
}

- (uint64_t)requestID {
    return _requestID++;
}

+ (void)loginWithAccountInfo:(PGAccountInfo *)accountInfo deviceInfo:(PGDeviceInfo *)deviceInfo completion:(PGAccountCompletion)completion {
    PGAccount *account = [[PGAccount alloc] initWithAccountInfo:accountInfo deviceInfo:deviceInfo];
    [account prepareLoginPtcWithCompletion:^(NSString *lt, NSString *execution, NSError *error){
        if (error == nil) {
            [account getTicketWithUsername:accountInfo.username password:accountInfo.password lt:lt execution:execution completion:^(NSString *ticket, NSError *error){
                if (error == nil) {
                    [account getAccessTokenWithTicket:ticket completion:^(NSError *error){
                        if (error == nil) {
                            [account getProfileWithCompletion:^(GetPlayerResponse *response, NSError *error){
                                // Not entirely happy with this solution, without the delayed dispatch the
                                // requests are occasionally rate limited causing the login flow to fail
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    [account getPlayerDataWithCompletion:^(NSError *error){
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                            completion(account, error);
                                        });
                                    }];
                                });
                            }];
                        } else {
                            completion(nil, error);
                        }
                    }];
                } else {
                    completion(nil, error);
                }
            }];
        } else {
            completion(nil, error);
        }
    }];
}

- (instancetype)initWithAccountInfo:(PGAccountInfo *)accountInfo deviceInfo:(PGDeviceInfo *)deviceInfo {
    if (self = [super init]) {
        self.accountInfo = accountInfo;
        self.minUpdateInterval = 10;
        self.baseAltitude = 93;
        self.baseTravelRate = 16.6667; // m/s
        
        self.startTime = [[NSDate date] timeIntervalSince1970] * 1000;
        self.requestID = PGRequestIdBase + (arc4random() % PGRequestIdRange);
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"User-Agent":PGPokemonApiRequestUserAgent};
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.apiURL = PGPokemonApiUrl;
        self.maxLocationFixCount = 5;
        self.deviceInfo = deviceInfo;
    }
    return self;
}

- (void)prepareLoginPtcWithCompletion:(PGPrepareLoginCompletion)completion {
    [self.sessionManager GET:PGPokemonApiLoginUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if (error == nil) {
            NSString *lt = jsonDict[@"lt"];
            NSString *execution = jsonDict[@"execution"];
            completion(lt, execution, nil);
        } else {
            completion(nil, nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeInvalidJSON userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodePrepareLoginFailed userInfo:nil]);
    }];
}

- (void)getTicketWithUsername:(NSString *)username password:(NSString *)password lt:(NSString *)lt execution:(NSString *)execution completion:(PGGetTicketCompletion)completion {
    NSDictionary *parameters = @{@"lt" : lt,
                                 @"execution" : execution,
                                 @"_eventId" : @"submit",
                                 @"username" : username,
                                 @"password" : password};
    [self.sessionManager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest *(NSURLSession *session, NSURLSessionTask *task, NSURLResponse *response, NSURLRequest *request) {
        return nil;
    }];
    [self.sessionManager POST:PGPokemonApiLoginUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if (error == nil) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey : jsonDict[@"errors"][0]};
            completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeGetTicketFailed userInfo:userInfo]);
        } else {
            completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeInvalidJSON userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)[task response];
        if (response.statusCode == 302) { //redirected
            NSString *locationHeader = response.allHeaderFields[@"Location"];
            DDURLParser *parser = [[DDURLParser alloc] initWithURLString:locationHeader];
            NSString *ticket = [parser valueForVariable:@"ticket"];
            if (ticket.length > 0) {
                completion(ticket, nil);
            } else {
                completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeGetTicketFailed userInfo:nil]);
            }
        } else {
            completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeGetTicketFailed userInfo:nil]);
        }
    }];
}

- (void)getAccessTokenWithTicket:(NSString *)ticket completion:(PGAsyncCompletion)completion {
    NSDictionary *parameters = @{@"client_id" : @"mobile-app_pokemon-go",
                                 @"redirect_uri" : @"https://www.nianticlabs.com/pokemongo/error",
                                 @"client_secret" : PGPokemonApiClientSecret,
                                 @"grant_type" : @"refresh_token",
                                 @"code" : ticket};
    [self.sessionManager POST:PGPokemonApiLoginOauth parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (responseString.length > 0 && [responseString rangeOfString:@"access_token"].location != NSNotFound) {
            //hack
            NSString *urlStr = [NSString stringWithFormat:@"http://q.ru/?%@", responseString];
            DDURLParser *parser = [[DDURLParser alloc] initWithURLString:urlStr];
            NSString *accessToken = [parser valueForVariable:@"access_token"];
            if (accessToken.length > 0) {
                self.accessToken = accessToken;
                completion(nil);
            } else {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Invalid token"};
                completion([NSError errorWithDomain:PGErrorDomain code:PGErrorCodeGetAccessTokenFailed userInfo:userInfo]);
            }
        } else {
            completion([NSError errorWithDomain:PGErrorDomain code:PGErrorCodeGetAccessTokenFailed userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion([NSError errorWithDomain:PGErrorDomain code:PGErrorCodeGetAccessTokenFailed userInfo:nil]);
    }];
}

- (void)getPlayerDataWithCompletion:(PGAsyncCompletion)completion {
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        if (error == nil) {
            PGResponse *remoteConfigResponse = [responses objectAtIndex:0];
            PGResponse *hatchedEggsResponse = [responses objectAtIndex:1];
            PGResponse *inventoryResponse = [responses objectAtIndex:2];
            PGResponse *awardedBadgesResponse = [responses objectAtIndex:3];
            PGResponse *downloadSettingsResponse = [responses objectAtIndex:4];
            [self receivedResponse:remoteConfigResponse];
            [self receivedResponse:hatchedEggsResponse];
            [self receivedInventoryResponse:inventoryResponse];
            [self receivedResponse:awardedBadgesResponse];
            [self receivedDownloadSettingsResponse:downloadSettingsResponse];
            completion(nil);
        } else {
            completion(error);
        }
    }];
    PGDownloadRemoteConfigVersionRequest *remoteConfigRequest = [[PGDownloadRemoteConfigVersionRequest alloc] init];
    [group addRequest:remoteConfigRequest];
    [self addPlayerDataRequestsToGroup:group];
    [group start];
}

- (double)applyNoise:(double)value magnitude:(double)magnitude {
    return value + ((CLLocationDegrees)arc4random() / ARC4RANDOM_MAX) * (2 * magnitude) - magnitude;
}

- (void)getMapObjectsForCoordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion {
    [self _updateLocationWithCoordinate:coordinate];
    [self _updateSensorData];
    self.isFetching = YES;
    
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        self.lastQueryTime = [[NSDate date] timeIntervalSince1970];
        self.isFetching = NO;
        if (error == nil) {
            PGResponse *response = [responses objectAtIndex:0];
            PGResponse *hatchedEggsResponse = [responses objectAtIndex:1];
            PGResponse *inventoryResponse = [responses objectAtIndex:2];
            PGResponse *awardedBadgesResponse = [responses objectAtIndex:3];
            PGResponse *downloadSettingsResponse = [responses objectAtIndex:4];
            [self receivedResponse:hatchedEggsResponse];
            [self receivedInventoryResponse:inventoryResponse];
            [self receivedResponse:awardedBadgesResponse];
            [self receivedDownloadSettingsResponse:downloadSettingsResponse];
            completion(self.accountInfo.username, (GetMapObjectsResponse *)response.message, response.error);
        } else {
            completion(self.accountInfo.username, nil, error);
        }
    }];
    PGGetMapObjectsRequest *request = [[PGGetMapObjectsRequest alloc] initWithCoordinate:self.location.coordinate];
    [group addRequest:request];
    [self addPlayerDataRequestsToGroup:group];
    [group start];
}

- (void)getMapObjectsForCellId:(uint64_t)cellId coordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion {
    [self _updateLocationWithCoordinate:coordinate];
    [self _updateSensorData];
    self.isFetching = YES;
    
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        self.lastQueryTime = [[NSDate date] timeIntervalSince1970];
        self.isFetching = NO;
        if (error == nil) {
            PGResponse *response = [responses objectAtIndex:0];
            PGResponse *hatchedEggsResponse = [responses objectAtIndex:1];
            PGResponse *inventoryResponse = [responses objectAtIndex:2];
            PGResponse *awardedBadgesResponse = [responses objectAtIndex:3];
            PGResponse *downloadSettingsResponse = [responses objectAtIndex:4];
            [self receivedResponse:hatchedEggsResponse];
            [self receivedInventoryResponse:inventoryResponse];
            [self receivedResponse:awardedBadgesResponse];
            [self receivedDownloadSettingsResponse:downloadSettingsResponse];
            completion(self.accountInfo.username, (GetMapObjectsResponse *)response.message, response.error);
        } else {
            completion(self.accountInfo.username, nil, error);
        }
    }];
    PGGetMapObjectsRequest *mapObjectsRequest = [[PGGetMapObjectsRequest alloc] initWithCoordinate:coordinate cellId:cellId];
    [group addRequest:mapObjectsRequest];
    [self addPlayerDataRequestsToGroup:group];
    [group start];
}

- (void)getProfileWithCompletion:(PGGetProfileCompletion)completion {
    self.isFetching = YES;
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        self.isFetching = NO;
        if (error == nil) {
            PGResponse *response = [responses firstObject];
            completion((GetPlayerResponse *)response.message, response.error);
        } else {
            completion(nil, error);
        }
    }];
    PGGetPlayerRequest *request = [[PGGetPlayerRequest alloc] init];
    [group addRequest:request];
    [group start];
}

- (void)acceptTermsOfServiceWithCompletion:(PGAcceptTermsOfServiceCompletion)completion {
    self.isFetching = YES;
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        self.lastQueryTime = [[NSDate date] timeIntervalSince1970];
        self.isFetching = NO;
        if (error == nil) {
            PGResponse *response = [responses firstObject];
            completion(response.error);
        } else {
            completion(error);
        }
    }];
    PGAcceptTermsOfServiceRequest *request = [[PGAcceptTermsOfServiceRequest alloc] init];
    [group addRequest:request];
    [group start];
}

- (void)addPlayerDataRequestsToGroup:(PGRequestGroup *)group {
    PGGetHatchedEggsRequest *hatchedEggsRequest = [[PGGetHatchedEggsRequest alloc] init];
    PGGetInventoryRequest *inventoryRequest = [[PGGetInventoryRequest alloc] initWithTimeStamp:self.inventoryTimeStamp];
    PGCheckAwardedBadgesRequest *awardedBadgesRequest = [[PGCheckAwardedBadgesRequest alloc] init];
    PGDownloadSettingsRequest *downloadSettingsRequest = [[PGDownloadSettingsRequest alloc] initWithHash:self.downloadSettingsHash];
    [group addRequest:hatchedEggsRequest];
    [group addRequest:inventoryRequest];
    [group addRequest:awardedBadgesRequest];
    [group addRequest:downloadSettingsRequest];
}

- (void)receivedInventoryResponse:(PGResponse *)response {
    if (response.error == nil) {
        GetInventoryResponse *message = (GetInventoryResponse *)response.message;
        if (message.hasInventoryDelta) {
            self.inventoryTimeStamp = message.inventoryDelta.newTimestampMs;
        }
    } else {
        NSLog(@"%@ failed: %@", [response class], response.error);
    }
}

- (void)receivedDownloadSettingsResponse:(PGResponse *)response {
    if (response.error == nil) {
        DownloadSettingsResponse *message = (DownloadSettingsResponse *)response.message;
        self.downloadSettingsHash = message.hash_p;
    } else {
        NSLog(@"%@ failed: %@", [response class], response.error);
    }
}

- (void)receivedResponse:(PGResponse *)response {
    if (response.error != nil) {
        NSLog(@"%@ failed: %@", [response class], response.error);
    }
}

- (void)updateTicket:(AuthTicket *)ticket {
    self.ticket = ticket;
}

- (void)updateApiURL:(NSString *)apiURL {
    self.apiURL = apiURL;
}

- (void)_updateLocationWithCoordinate:(CLLocationCoordinate2D)coordinate {
    CGFloat altitude = [self applyNoise:self.baseAltitude magnitude:0.05];
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:coordinate altitude:altitude horizontalAccuracy:10 verticalAccuracy:12 timestamp:[NSDate date]];
    self.lastLocation = self.location;
    self.location = location;
    
    if (self.lastLocation != nil) {
        [self _updateLocationFixes];
    }
}

- (void)_updateLocationFixes {
    if (self.lastLocation != nil) {
        
        CLLocationCoordinate2D lastCoordinate = self.lastLocation.coordinate;
        CLLocationCoordinate2D currentCoordinate = self.location.coordinate;
        CLLocationDistance maxDistance = [self.location distanceFromLocation:self.lastLocation];

        NSTimeInterval timeOffset = [self applyNoise:2.5 magnitude:0.35];
        uint64_t timeSinceStart = ([[NSDate date] timeIntervalSince1970] * 1000 - self.startTime) - (timeOffset * 1000);
        uint64_t lastTimeSinceStart = self.lastQueryTime * 1000 - self.startTime;
        
        NSMutableArray *locationFixes = [NSMutableArray arrayWithCapacity:self.maxLocationFixCount];
        for (int i = 0; i < self.maxLocationFixCount && timeSinceStart > lastTimeSinceStart; i++) {
            double travelRate = [self applyNoise:self.baseTravelRate magnitude:1.5];
            CLLocationDistance distance = (timeOffset * travelRate) / 1000;
            CLLocationDirection heading = [self applyNoise:[self _getHeadingBetweenCoordinate:lastCoordinate coordinate:currentCoordinate] magnitude:2.5];
            CLLocationCoordinate2D coordinate = [self _getCoordinateWithDistance:distance direction:heading fromCoordinate:currentCoordinate];
            timeSinceStart -= timeOffset;
            
            CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
            CLLocationDistance currentDistance = [currentLocation distanceFromLocation:self.location];
            if (currentDistance >= maxDistance) {
                break;
            }
            Signature_LocationFix *locationFix = [Signature_LocationFix message];
            locationFix.provider = @"gps";
            locationFix.timestampSinceStart = timeSinceStart;
            locationFix.latitude = coordinate.latitude;
            locationFix.longitude = coordinate.longitude;
            locationFix.altitude = [self applyNoise:self.baseAltitude magnitude:0.05];
            locationFix.providerStatus = 3;
            locationFix.locationType = 1;
            [locationFixes addObject:locationFix];
      
            currentCoordinate = coordinate;
            timeOffset = [self applyNoise:2.5 magnitude:0.35];
            timeSinceStart -= timeOffset * 1000;
        }
        self.locationFixes = locationFixes;
    }
}

- (void)_updateSensorData {
    if (self.lastLocation != nil) {
        CLLocationCoordinate2D coordinate1 = self.location.coordinate;
        CLLocationCoordinate2D coordinate2 = self.lastLocation.coordinate;
        double heading = [self _getHeadingBetweenCoordinate:coordinate1 coordinate:coordinate2];
        self.sensorInfo = [[PGSensorSpoofer sharedInstance] sensorInfoForHeading:heading];
    } else {
        self.sensorInfo = [[PGSensorSpoofer sharedInstance] sensorInfo];
    }
}

- (CLLocationCoordinate2D)_getCoordinateWithDistance:(CLLocationDistance)distance direction:(CLLocationDirection)direction fromCoordinate:(CLLocationCoordinate2D)coordinate {
    
    double radius = 6378.137;
    double angle = DEGREES_TO_RADIANS(direction);

    CLLocationDegrees lat1 = DEGREES_TO_RADIANS(coordinate.latitude);
    CLLocationDegrees lon1 = DEGREES_TO_RADIANS(coordinate.longitude);
    
    CLLocationDegrees lat2 = asin(sin(lat1)*cos(distance/radius) + cos(lat1)*sin(distance/radius)*cos(angle));
    CLLocationDegrees lon2 = lon1 + atan2(sin(angle)*sin(distance/radius)*cos(lat1), cos(distance/radius)-sin(lat1)*sin(lat2));
    return CLLocationCoordinate2DMake(RADIANS_TO_DEGREES(lat2), RADIANS_TO_DEGREES(lon2));
}

- (CLLocationDirection)_getHeadingBetweenCoordinate:(CLLocationCoordinate2D)coordinate1 coordinate:(CLLocationCoordinate2D)coordinate2 {
    CLLocationDegrees lat1 = DEGREES_TO_RADIANS(coordinate1.latitude);
    CLLocationDegrees lon1 = DEGREES_TO_RADIANS(coordinate1.longitude);
    CLLocationDegrees lat2 = DEGREES_TO_RADIANS(coordinate2.latitude);
    CLLocationDegrees lon2 = DEGREES_TO_RADIANS(coordinate2.longitude);
    
    double delta = lon2 - lon1;
    double y = sin(delta) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(delta);
    return RADIANS_TO_DEGREES(atan2(y, x)) + 180;
}

- (CLLocationDistance)distanceFromCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self.lastQueryTime == 0) {
        return 0;
    } else {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        return fmax([self.location distanceFromLocation:location] - (self.baseTravelRate * self.timeSinceQuery), 0);
    }
}

@end
