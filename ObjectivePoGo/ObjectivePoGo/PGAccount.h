//
//  PKAccount.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AFNetworking.h>
#import "AuthTicket.pbobjc.h"
#import "GetMapObjectsResponse.pbobjc.h"
#import "GetPlayerResponse.pbobjc.h"
#import "PGConstants.h"
#import "MapCell.pbobjc.h"
#import "MapPokemon.pbobjc.h"
#import "WildPokemon.pbobjc.h"
#import "NearbyPokemon.pbobjc.h"
#import "PokemonData.pbobjc.h"
#import "PGDeviceInfo.h"
#import "PGAccountInfo.h"
#import "PGRequestInfoProvider.h"

@class PGAccount;
typedef void(^PGAccountCompletion)(PGAccount *account, NSError *error);

typedef void(^PGMapObjectsCompletion)(NSString *username, GetMapObjectsResponse *mapObjects, NSError *error);
typedef void(^PGGetProfileCompletion)(GetPlayerResponse *playerProfile, NSError *error);
typedef void(^PGAcceptTermsOfServiceCompletion)(NSError *error);

@interface PGAccount : NSObject <PGRequestInfoProvider>
@property (readonly, nonatomic) BOOL isReadyForQuery;
@property (readonly, nonatomic) NSTimeInterval lastQueryTime;
@property (readonly, nonatomic ,strong) PGAccountInfo *accountInfo;

// PGRequestInfoProvider Properties
@property (readonly, nonatomic) uint64_t startTime;
@property (readonly, nonatomic) uint64_t requestID;
@property (readonly, nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (readonly, nonatomic, strong) NSString *apiURL;
@property (readonly, nonatomic, strong) AuthTicket *ticket;
@property (readonly, nonatomic, strong) NSString *accessToken;
@property (readonly, nonatomic, strong) CLLocation *location;
@property (readonly, nonatomic, strong) NSArray *locationFixes;
@property (readonly, nonatomic, strong) PGSensorInfo *sensorInfo;
@property (readonly, nonatomic, strong) PGDeviceInfo *deviceInfo;
+ (void)loginWithAccountInfo:(PGAccountInfo *)accountInfo deviceInfo:(PGDeviceInfo *)deviceInfo completion:(PGAccountCompletion)completion;
- (void)getMapObjectsForCoordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion;
- (void)getMapObjectsForCellId:(uint64_t)cellId coordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion;
- (void)getProfileWithCompletion:(PGGetProfileCompletion)completion;
- (void)acceptTermsOfServiceWithCompletion:(PGAcceptTermsOfServiceCompletion)completion;
- (CLLocationDistance)distanceFromCoordinate:(CLLocationCoordinate2D)coordinate;
@end
