//
//  PGClaimCodenameRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-26.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGClaimCodenameRequest.h"
#import "ClaimCodenameMessage.pbobjc.h"
#import "PGNameGenerator.h"

@implementation PGClaimCodenameRequest

- (instancetype)initWithCodename:(NSString *)codename {
    if (self = [super initWithType:RequestType_ClaimCodename]) {
        ClaimCodenameMessage *message = [ClaimCodenameMessage message];
        message.codename = codename;
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}
- (instancetype)init {
    PGNameGenerator *nameGenerator = [[PGNameGenerator alloc] init];
    NSString *name = [nameGenerator randomName];
    return (self = [self initWithCodename:name]);
}

@end
