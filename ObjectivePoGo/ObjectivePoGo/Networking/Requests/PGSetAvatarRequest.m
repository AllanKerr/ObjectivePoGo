//
//  PGSetAvatarRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-26.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGSetAvatarRequest.h"
#import "SetAvatarMessage.pbobjc.h"
#import "PlayerAvatar.pbobjc.h"
#import "Gender.pbobjc.h"

@implementation PGSetAvatarRequest

- (instancetype)init {
    if (self = [super initWithType:RequestType_SetAvatar]) {
        SetAvatarMessage *message = [SetAvatarMessage message];
        PlayerAvatar *avatar = [PlayerAvatar message];
        BOOL isMale = arc4random() % 2;
        if (isMale) {
            avatar.gender = Gender_Male;
        } else {
            avatar.gender = Gender_Female;
        }
        avatar.skin = 1;
        avatar.shirt = 1;
        message.playerAvatar = avatar;
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
