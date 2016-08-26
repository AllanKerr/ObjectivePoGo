//
//  PGGetPlayerRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-18.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGGetPlayerRequest.h"
#import "PGConstants.h"
#import "PGConfig.h"
#import "GetPlayerMessage.pbobjc.h"

@implementation PGGetPlayerRequest

- (instancetype)init {
    if (self = [super initWithType:RequestType_GetPlayer]) {
        GetPlayerMessage *message = [GetPlayerMessage message];
        GetPlayerMessage_PlayerLocale *locale = [GetPlayerMessage_PlayerLocale message];
        locale.language = PGConfigLanguage;
        locale.country = PGConfigCountry;
        message.playerLocale = locale;
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
