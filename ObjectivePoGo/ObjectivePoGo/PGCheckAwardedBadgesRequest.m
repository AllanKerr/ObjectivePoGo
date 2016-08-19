//
//  PGCheckAwardedBadgesRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-18.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGCheckAwardedBadgesRequest.h"
#import "CheckAwardedBadgesMessage.pbobjc.h"

@implementation PGCheckAwardedBadgesRequest

- (instancetype)init {
    if (self = [super initWithType:RequestType_CheckAwardedBadges]) {
        CheckAwardedBadgesMessage *message = [CheckAwardedBadgesMessage message];
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
