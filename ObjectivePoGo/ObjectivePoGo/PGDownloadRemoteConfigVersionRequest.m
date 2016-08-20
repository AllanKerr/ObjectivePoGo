//
//  PGDownloadRemoteConfigVersionRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-18.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGDownloadRemoteConfigVersionRequest.h"
#import "DownloadRemoteConfigVersionMessage.pbobjc.h"
#import "Platform.pbobjc.h"
#import "PGConfig.h"

@implementation PGDownloadRemoteConfigVersionRequest

- (instancetype)init {
    if (self = [super initWithType:RequestType_DownloadRemoteConfigVersion]) {
        DownloadRemoteConfigVersionMessage *message = [DownloadRemoteConfigVersionMessage message];
        message.platform = Platform_Ios;
        message.appVersion = PGCongfigAppVersion;
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
