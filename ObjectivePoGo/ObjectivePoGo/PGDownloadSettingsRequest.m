//
//  PGDownloadSettingsRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-18.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGDownloadSettingsRequest.h"
#import "DownloadSettingsMessage.pbobjc.h"

@implementation PGDownloadSettingsRequest

- (instancetype)initWithHash:(NSString *)hash {
    if (self = [super initWithType:RequestType_DownloadSettings]) {
        DownloadSettingsMessage *message = [DownloadSettingsMessage message];
        if (hash != nil) {
            message.hash_p = hash;
        }
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

- (instancetype)init {
    if (self = [super initWithType:RequestType_DownloadSettings]) {
        DownloadSettingsMessage *message = [DownloadSettingsMessage message];
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
