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
#import "PGCompleteTutorialStateRequest.h"
#import "PGDownloadSettingsRequest.h"
#import "PGGetInventoryRequest.h"
#import "PGGetHatchedEggsRequest.h"
#import "PGCheckAwardedBadgesRequest.h"
#import "PGDownloadRemoteConfigVersionRequest.h"
#import "PGResponse.h"
#import <DDURLParser.h>
#import "PGConfig.h"
#import "PGCheckChallengeRequest.h"
#import "PGSetAvatarRequest.h"
#import "PGEncounterTutorialCompleteRequest.h"
#import "PGClaimCodenameRequest.h"
#import "PGUtil.h"
#import "PGAccuracy.h"
#import "PGWanderingValue.h"

#import "GetPlayerResponse.pbobjc.h"
#import "GetMapObjectsResponse.pbobjc.h"
#import "MarkTutorialCompleteResponse.pbobjc.h"
#import "Signature.pbobjc.h"
#import "PGSensorSpoofer.h"
#import "InventoryDelta.pbobjc.h"
#import "GlobalSettings.pbobjc.h"
#import "MapSettings.pbobjc.h"
#import "PlayerData.pbobjc.h"
#import "TutorialState.pbobjc.h"

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
#define RADIANS_TO_DEGREES(radians)((180 * radians)/M_PI)

typedef void(^PGPrepareLoginCompletion)(NSString *lt, NSString *execution, NSError *error);
typedef void(^PGGetTicketCompletion)(NSString *ticket, NSError *error);
typedef void(^PGBooleanCompletion)(BOOL success, NSError *error);
typedef void(^PGRequestCompletion)(PGResponse *response, NSError *error);
typedef void(^PGAsyncCompletion)(NSError *error);

@interface PGAccount ()
@property (readonly, nonatomic) NSTimeInterval timeSinceQuery;
@property (readwrite, nonatomic) BOOL isFetching;
@property (readwrite, nonatomic) NSTimeInterval lastQueryTime;
@property (readwrite, nonatomic) NSTimeInterval minUpdateInterval;
@property (readwrite, nonatomic) int64_t inventoryTimeStamp;
@property (readwrite, nonatomic, strong) NSString *downloadSettingsHash;
@property (readwrite, nonatomic ,strong) PGAccountInfo *accountInfo;
@property (readwrite, nonatomic, strong) PGAccuracy *horizontalAccuracy;
@property (readwrite, nonatomic, strong) PGAccuracy *verticalAccuracy;
@property (readwrite, nonatomic, strong) PGWanderingValue *altitude;
@property (readwrite, nonatomic, strong) PGWanderingValue *speed;
@property (readwrite, nonatomic) uint64_t requestCount;

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
@property (readwrite, nonatomic, strong) PGSensorInfo *sensorInfo;
@property (readwrite, nonatomic, strong) PGDeviceInfo *deviceInfo;
@property (readwrite, nonatomic, strong) NSData *sessionHash;
@property (readwrite, nonatomic, strong) PlayerData *playerData;
@end

@implementation PGAccount
@dynamic isReadyForQuery;
@dynamic timeSinceQuery;
@dynamic username;

- (BOOL)isReadyForQuery {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    return !self.isFetching && currentTime >= self.lastQueryTime + self.minUpdateInterval;
}

- (NSTimeInterval)timeSinceQuery {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    return currentTime - self.lastQueryTime;
}

- (uint64_t)requestID {
    if (self.requestCount == 0) {
        self.requestCount++;
        return _requestID;
    } else {
        srand((unsigned int)time(NULL));
        return rand() | self.requestCount;
    }
}

- (NSString *)username {
    return self.accountInfo.username;
}

+ (void)loginWithAccountInfo:(PGAccountInfo *)accountInfo deviceInfo:(PGDeviceInfo *)deviceInfo completion:(PGAccountCompletion)completion {
    [self loginWithAccountInfo:accountInfo deviceInfo:deviceInfo atCoordinate:kCLLocationCoordinate2DInvalid completion:completion];
}

+ (void)loginWithAccountInfo:(PGAccountInfo *)accountInfo deviceInfo:(PGDeviceInfo *)deviceInfo atCoordinate:(CLLocationCoordinate2D)coordinate completion:(PGAccountCompletion)completion {
    PGAccount *account = [[PGAccount alloc] initWithAccountInfo:accountInfo deviceInfo:deviceInfo coordinate:coordinate];
    [account prepareLoginPtcWithCompletion:^(NSString *lt, NSString *execution, NSError *error){
        if (error == nil) {
            [account getTicketWithUsername:accountInfo.username password:accountInfo.password lt:lt execution:execution completion:^(NSString *ticket, NSError *error){
                if (error == nil) {
                    [account getAccessTokenWithTicket:ticket completion:^(NSError *error){
                        if (error == nil) {
                            [account getProfileWithCompletion:^(GetPlayerResponse *response, NSError *error){
                                if (error == nil) {
                                    [account completeTutorialWithCompletion:^(NSError *error){
                                        if (error == nil) {
                                            [account getRemoteConfig:^(NSError *error){
                                                completion(account, error);
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
                } else {
                    completion(nil, error);
                }
            }];
        } else {
            completion(nil, error);
        }
    }];
}

- (instancetype)initWithAccountInfo:(PGAccountInfo *)accountInfo deviceInfo:(PGDeviceInfo *)deviceInfo coordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [super init]) {
        self.accountInfo = accountInfo;
        self.minUpdateInterval = PGConfigQueryInterval;
        self.horizontalAccuracy = [PGAccuracy horizontalAccuracy];
        self.verticalAccuracy = [PGAccuracy verticalAccuracy];
        self.altitude = [[PGWanderingValue alloc] initWithMax:PGConfigMaxAltitude min:PGConfigMinAltitude minDelta:PGConfigMinAltitudeDelta maxDelta:PGConfigMaxAltitudeDelta];
        self.speed = [[PGWanderingValue alloc] initWithMax:PGConfigMaxSpeed min:PGConfigMinSpeed minDelta:PGConfigMinSpeedDelta maxDelta:PGConfigMaxSpeedDelta];
        
        self.requestID = PGRequestID;
        self.startTime = [[NSDate date] timeIntervalSince1970] * 1000;
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"User-Agent":PGPokemonApiRequestUserAgent};
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.apiURL = PGPokemonApiUrl;
        self.deviceInfo = deviceInfo;
        
        if (CLLocationCoordinate2DIsValid(coordinate)) {
            [self _updateLocationWithCoordinate:coordinate];
        }
        [self _updateSensorData];
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
            if (lt.length > 0 && execution.length > 0) {
                completion(lt, execution, nil);
            } else {
                completion(nil, nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodePrepareLoginFailed userInfo:nil]);
            }
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

- (void)getProfileWithCompletion:(PGGetProfileCompletion)completion {
    self.isFetching = YES;
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        self.isFetching = NO;
        if (error == nil) {
            PGResponse *response = [responses objectAtIndex:0];
            PGResponse *challengeResponse = [responses objectAtIndex:1];
            NSError *challengeError = [self checkChallengeResponse:challengeResponse];
            if (challengeError != nil) {
                completion(nil, challengeError);
            } else if (response.error == nil) {
                GetPlayerResponse *message = (GetPlayerResponse *)response.message;
                self.playerData = message.playerData;
                completion(message, nil);
            } else {
                completion(nil, response.error);
            }
        } else {
            completion(nil, error);
        }
    }];
    PGGetPlayerRequest *playerRequest = [[PGGetPlayerRequest alloc] init];
    PGCheckChallengeRequest *checkChallengeRequest = [[PGCheckChallengeRequest alloc] init];
    [group addRequest:playerRequest];
    [group addRequest:checkChallengeRequest];
    [group start];
}

- (void)completeTutorialWithCompletion:(PGAsyncCompletion)completion {
    __block BOOL passedLegalScreen = NO;
    __block BOOL passedAvatarSelection = NO;
    __block BOOL passedPokemonCapture = NO;
    __block BOOL passedNameSelection = NO;
    __block BOOL passedFirstTimeExperience = NO;
    [self.playerData.tutorialStateArray enumerateValuesWithBlock:^(int32_t value, NSUInteger idx, BOOL *stop){
        switch (value) {
            case TutorialState_LegalScreen:
                passedLegalScreen = YES;
                break;
            case TutorialState_AvatarSelection:
                passedAvatarSelection = YES;
                break;
            case TutorialState_PokemonCapture:
                passedPokemonCapture = YES;
                break;
            case TutorialState_NameSelection:
                passedNameSelection = YES;
                break;
            case TutorialState_FirstTimeExperienceComplete:
                passedFirstTimeExperience = YES;
                break;
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        __block TutorialState state;
        PGBooleanCompletion tutorialCompletionBlock = ^(BOOL success, NSError *error) {
            if (success) {
                [self.playerData.tutorialStateArray addValue:state];
                [self completeTutorialWithCompletion:completion];
            } else {
                completion(error);
            }
        };
        if (!passedLegalScreen) {
            state = TutorialState_LegalScreen;
            NSLog(@"%@ accepting terms of service...", self.username);
            [self markTutorialCompleteWithState:TutorialState_LegalScreen completion:tutorialCompletionBlock];
        } else if (!passedAvatarSelection) {
            state = TutorialState_AvatarSelection;
            NSLog(@"%@ setting avatar...", self.username);
            [self setAvatarWithCompletion:tutorialCompletionBlock];
        } else if (!passedPokemonCapture) {
            NSLog(@"%@ capturing tutorial pokemon...", self.username);
            state = TutorialState_PokemonCapture;
            [self completeTutorialEncounterWithCompletion:tutorialCompletionBlock];
        } else if (!passedNameSelection) {
            NSLog(@"%@ claiming codename...", self.username);
            state = TutorialState_NameSelection;
            [self claimCodenameWithCompletion:tutorialCompletionBlock];
        } else if (!passedFirstTimeExperience) {
            NSLog(@"%@ completed tutorial...", self.username);
            state = TutorialState_FirstTimeExperienceComplete;
            [self markTutorialCompleteWithState:TutorialState_FirstTimeExperienceComplete completion:tutorialCompletionBlock];
        } else {
            completion(nil);
        }
    });
}

- (void)markTutorialCompleteWithState:(TutorialState)state completion:(PGBooleanCompletion)completion {
    NSLog(@"Updating tutorial state:%i", state);
    PGCompleteTutorialStateRequest *request = [[PGCompleteTutorialStateRequest alloc] initWithState:state];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        if (error == nil) {
            MarkTutorialCompleteResponse *message = (MarkTutorialCompleteResponse *)response.message;
            completion(message.success, response.error);
        } else {
            completion(NO, error);
        }
    }];
}

- (void)setAvatarWithCompletion:(PGBooleanCompletion)completion {
    PGSetAvatarRequest *request = [[PGSetAvatarRequest alloc] init];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        if (error == nil) {
            SetAvatarResponse *message = (SetAvatarResponse *)response.message;
            if (message.status == SetAvatarResponse_Status_Success) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self markTutorialCompleteWithState:TutorialState_AvatarSelection completion:completion];
                });
            } else {
                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"Claim codename received unexpected status:%i", message.status]};
                NSError *error = [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeRequestFailed userInfo:userInfo];
                completion(NO, error);
            }
        } else {
            completion(NO, error);
        }
    }];
}

- (void)completeTutorialEncounterWithCompletion:(PGBooleanCompletion)completion {
    PGEncounterTutorialCompleteRequest *request = [[PGEncounterTutorialCompleteRequest alloc] init];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        if (error == nil) {
            EncounterTutorialCompleteResponse *message = (EncounterTutorialCompleteResponse *)response.message;
            completion(message.result == EncounterTutorialCompleteResponse_Result_Success, response.error);
        } else {
            completion(NO, error);
        }
    }];
}

- (void)claimCodenameWithCompletion:(PGBooleanCompletion)completion {
    PGClaimCodenameRequest *request = [[PGClaimCodenameRequest alloc] init];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        if (error == nil) {
            ClaimCodenameResponse *message = (ClaimCodenameResponse *)response.message;
            if (message.status == ClaimCodenameResponse_Status_CodenameNotAvailable ||
                message.status == ClaimCodenameResponse_Status_CodenameNotValid) {
                NSLog(@"%@ in use or invalid... Trying again...", message.codename);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self claimCodenameWithCompletion:completion];
                });
            } else if (message.status == ClaimCodenameResponse_Status_Success) {
                NSLog(@"%@ claimed codename:%@", self.username, message.codename);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self markTutorialCompleteWithState:TutorialState_NameSelection completion:completion];
                });
            } else {
                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"Claim codename received unexpected status:%i", message.status]};
                NSError *error = [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeRequestFailed userInfo:userInfo];
                completion(NO, error);
            }
        } else {
            completion(NO, error);
        }
    }];
}

- (void)getRemoteConfig:(PGAsyncCompletion)completion {
    PGDownloadRemoteConfigVersionRequest *request = [[PGDownloadRemoteConfigVersionRequest alloc] init];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        if (error == nil) {
            [self receivedResponse:response];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                completion(nil);
            });
        } else {
            completion(error);
        }
    }];
}

- (void)getMapObjectsForCoordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion {
    [self _updateLocationWithCoordinate:coordinate];
    [self _updateSensorData];
    self.isFetching = YES;
    
    PGGetMapObjectsRequest *request = [[PGGetMapObjectsRequest alloc] initWithCoordinate:coordinate];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        self.lastQueryTime = [[NSDate date] timeIntervalSince1970];
        self.isFetching = NO;
        
        if (error == nil) {
            completion(self.username, (GetMapObjectsResponse *)response.message, response.error);
        } else {
            completion(self.username, nil, error);
        }
    }];
}

- (void)getMapObjectsForCellId:(uint64_t)cellId coordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion {
    [self _updateLocationWithCoordinate:coordinate];
    [self _updateSensorData];
    self.isFetching = YES;
    
    PGGetMapObjectsRequest *request = [[PGGetMapObjectsRequest alloc] initWithCoordinate:self.location.coordinate cellId:cellId];
    [self performRequest:request withCompletion:^(PGResponse *response, NSError *error){
        self.lastQueryTime = [[NSDate date] timeIntervalSince1970];
        self.isFetching = NO;
        
        if (error == nil) {
            completion(self.username, (GetMapObjectsResponse *)response.message, response.error);
        } else {
            completion(self.username, nil, error);
        }
    }];
}

- (void)performRequest:(PGRequest *)request withCompletion:(PGRequestCompletion)completion {
    PGRequestGroup *group = [[PGRequestGroup alloc] initWithInfoProvider:self completion:^(NSArray *responses, NSError *error){
        if (error == nil) {
            PGResponse *response = [responses objectAtIndex:0];
            PGResponse *challengeResponse = [responses objectAtIndex:1];
            PGResponse *hatchedEggsResponse = [responses objectAtIndex:2];
            PGResponse *inventoryResponse = [responses objectAtIndex:3];
            PGResponse *awardedBadgesResponse = [responses objectAtIndex:4];
            PGResponse *downloadSettingsResponse = [responses objectAtIndex:5];
            NSError *challengeError = [self checkChallengeResponse:challengeResponse];
            if (challengeError != nil) {
                completion(nil, challengeError);
            } else {
                [self receivedResponse:hatchedEggsResponse];
                [self receivedInventoryResponse:inventoryResponse];
                [self receivedResponse:awardedBadgesResponse];
                [self receivedDownloadSettingsResponse:downloadSettingsResponse];
                completion(response, nil);
            }
        } else {
            completion(nil, error);
        }
    }];
    [group addRequest:request];
    [self addPlayerDataRequestsToGroup:group];
    [group start];
}

- (void)addPlayerDataRequestsToGroup:(PGRequestGroup *)group {
    PGCheckChallengeRequest *checkChallengeRequest = [[PGCheckChallengeRequest alloc] init];
    PGGetHatchedEggsRequest *hatchedEggsRequest = [[PGGetHatchedEggsRequest alloc] init];
    PGGetInventoryRequest *inventoryRequest = [[PGGetInventoryRequest alloc] initWithTimeStamp:self.inventoryTimeStamp];
    PGCheckAwardedBadgesRequest *awardedBadgesRequest = [[PGCheckAwardedBadgesRequest alloc] init];
    PGDownloadSettingsRequest *downloadSettingsRequest = [[PGDownloadSettingsRequest alloc] initWithHash:self.downloadSettingsHash];
    [group addRequest:checkChallengeRequest];
    [group addRequest:hatchedEggsRequest];
    [group addRequest:inventoryRequest];
    [group addRequest:awardedBadgesRequest];
    [group addRequest:downloadSettingsRequest];
}

- (NSError *)checkChallengeResponse:(PGResponse *)response {
    if (response.error != nil) {
        return response.error;
    }
    CheckChallengeResponse *message = (CheckChallengeResponse *)response.message;
    if (message.showChallenge) {
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"showChallenge:%i challengeURL:%@", message.showChallenge, message.challengeURL]};
        return [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeReceivedChallenge userInfo:userInfo];
    } if (message.challengeURL.length > 1) {
        NSLog(@"Received challenge URL:%@", message.challengeURL);
        return nil;
    } else {
        return nil;
    }
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
        if (message.hasSettings && message.settings.hasMapSettings && message.settings.mapSettings.getMapObjectsMinRefreshSeconds > 0) {
            if (message.settings.mapSettings.getMapObjectsMinRefreshSeconds != PGConfigQueryInterval) {
                NSLog(@"The minimum query interval has been changed to %f", message.settings.mapSettings.getMapObjectsMinRefreshSeconds);
            }
            self.minUpdateInterval = message.settings.mapSettings.getMapObjectsMinRefreshSeconds;
        }
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

- (void)updateSessionHash:(NSData *)sessionHash {
    self.sessionHash = sessionHash;
}

- (void)_updateLocationWithCoordinate:(CLLocationCoordinate2D)coordinate {
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:coordinate altitude:self.altitude.value
                                               horizontalAccuracy:self.horizontalAccuracy.accuracy
                                                 verticalAccuracy:self.verticalAccuracy.accuracy
                                                        timestamp:[NSDate date]];
    self.lastLocation = self.location;
    self.location = location;
    
    [self _updateLocationFixes];
    [self.horizontalAccuracy narrow];
    [self.verticalAccuracy narrow];
}

- (void)_updateLocationFixes {
    NSArray *locationFixes = [self _createMovingLocationFixes];
    if (locationFixes.count == 0) {
        locationFixes = [self _createStationaryLocationFixes];
    }
    self.locationFixes = locationFixes;
    NSLog(@"%@", self.locationFixes);
}

- (NSArray *)_createMovingLocationFixes {
    NSMutableArray *locationFixes = [NSMutableArray arrayWithCapacity:PGConfigMaxLocationFixCount];
    if (self.lastLocation != nil) {
        CLLocationCoordinate2D lastCoordinate = self.lastLocation.coordinate;
        CLLocationCoordinate2D currentCoordinate = self.location.coordinate;
        CLLocationDistance maxDistance = [self.location distanceFromLocation:self.lastLocation];
        
        NSTimeInterval timeOffset = [PGUtil applyNoise:1.002 magnitude:0.175];
        int64_t lastTimeSinceStart = fmax(self.lastQueryTime * 1000 - self.startTime, 0);
        int64_t timeSinceStart = ([[NSDate date] timeIntervalSince1970] * 1000 - self.startTime) - (timeOffset * 1000);
        
        int emptyCoordinateCount = 0;
        for (int i = 0; i < PGConfigMaxLocationFixCount && timeSinceStart > lastTimeSinceStart; i++) {
            double travelRate = self.speed.value;
            CLLocationDistance distance = (timeOffset * travelRate) / 1000;
            CLLocationDirection heading = [PGUtil applyNoise:[self _getHeadingBetweenCoordinate:lastCoordinate coordinate:currentCoordinate] magnitude:2.5];
            CLLocationCoordinate2D coordinate = [self _getCoordinateWithDistance:distance direction:heading fromCoordinate:currentCoordinate];
            
            CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
            CLLocationDistance currentDistance = [currentLocation distanceFromLocation:self.location];
            if (currentDistance >= maxDistance || timeSinceStart <= 0) {
                break;
            }
            Signature_LocationFix *locationFix = [Signature_LocationFix message];
            locationFix.provider = @"gps";
            locationFix.timestampSnapshot = timeSinceStart;
            if (emptyCoordinateCount == 0) {
                locationFix.latitude = coordinate.latitude;
                locationFix.longitude = coordinate.longitude;
                emptyCoordinateCount = (arc4random() % 4) + 1;
            } else {
                locationFix.latitude = 360;
                locationFix.longitude = -360;
                emptyCoordinateCount--;
            }
            locationFix.altitude = self.altitude.value;
            locationFix.horizontalAccuracy = self.horizontalAccuracy.accuracy;
            locationFix.verticalAccuracy = self.verticalAccuracy.accuracy;
            locationFix.speed = travelRate;
            locationFix.course = heading;
            locationFix.providerStatus = 3;
            locationFix.locationType = 1;
            [locationFixes insertObject:locationFix atIndex:0];
            
            currentCoordinate = coordinate;
            timeOffset = [PGUtil applyNoise:1.002 magnitude:0.175];
            timeSinceStart -= timeOffset * 1000;
        }
    }
    return locationFixes;
}

- (NSArray *)_createStationaryLocationFixes {
    NSMutableArray *locationFixes = [NSMutableArray arrayWithCapacity:PGConfigMaxLocationFixCount];
    if (self.location != nil) {
        int emptyCoordinateCount = 0;
        CLLocationCoordinate2D coordinate = self.location.coordinate;
        NSTimeInterval timeOffset = [PGUtil applyNoise:0.2 magnitude:0.175];
        int64_t timeSinceStart = ([[NSDate date] timeIntervalSince1970] * 1000 - self.startTime) - (timeOffset * 1000);
        for (int i = 0; i < PGConfigMaxLocationFixCount && timeSinceStart > 0; i++) {
            Signature_LocationFix *locationFix = [Signature_LocationFix message];
            locationFix.provider = @"gps";
            locationFix.timestampSnapshot = timeSinceStart;
            if (emptyCoordinateCount == 0) {
                locationFix.latitude = [PGUtil applyNoise:coordinate.latitude magnitude:0.00000763];
                locationFix.longitude = [PGUtil applyNoise:coordinate.longitude magnitude:0.00000763];
                emptyCoordinateCount = (arc4random() % 2);
            } else {
                locationFix.latitude = 360;
                locationFix.longitude = -360;
                emptyCoordinateCount--;
            }
            locationFix.altitude = self.altitude.value;
            locationFix.horizontalAccuracy = self.horizontalAccuracy.accuracy;
            locationFix.verticalAccuracy = self.verticalAccuracy.accuracy;
            locationFix.speed = -1;
            locationFix.course = -1;
            locationFix.providerStatus = 3;
            locationFix.locationType = 1;
            [locationFixes insertObject:locationFix atIndex:0];
            
            timeOffset = [PGUtil applyNoise:1.002 magnitude:0.175];
            timeSinceStart -= timeOffset * 1000;
        }
    }
    return locationFixes;
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
        double averageSpeed = (PGConfigMaxSpeed + PGConfigMinSpeed) / 2;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        return fmax([self.location distanceFromLocation:location] - (averageSpeed * self.timeSinceQuery), 0);
    }
}

@end
