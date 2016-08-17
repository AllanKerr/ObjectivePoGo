//
//  PGRequestInfoProvider.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AuthTicket.pbobjc.h"
#import "PGSensorInfo.h"
#import "PGDeviceInfo.h"

@protocol PGRequestInfoProvider <NSObject>
@property (readonly, nonatomic) uint64_t startTime;
@property (readonly, nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (readonly, nonatomic, strong) NSString *apiURL;
@property (readonly, nonatomic, strong) AuthTicket *ticket;
@property (readonly, nonatomic, strong) NSString *accessToken;
@property (readonly, nonatomic, strong) CLLocation *location;
@property (readonly, nonatomic, strong) NSArray *locationFixes;
@property (readonly, nonatomic, strong) PGSensorInfo *sensorInfo;
@property (readonly, nonatomic, strong) PGDeviceInfo *deviceInfo;
- (void)updateTicket:(AuthTicket *)ticket;
- (void)updateApiURL:(NSString *)apiURL;
@end
