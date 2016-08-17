//
//  PGAccountInfo.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGAccountInfo.h"

@interface PGAccountInfo ()
@property (readwrite, nonatomic, strong) NSString *username;
@property (readwrite, nonatomic, strong) NSString *password;
@end

@implementation PGAccountInfo

- (instancetype)initWithInfo:(NSDictionary *)info {
    if (self = [super init]) {
        self.username = [info valueForKey:@"username"];
        self.password = [info valueForKey:@"password"];
    }
    return self;
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password {
    if (self = [super init]) {
        self.username = username;
        self.password = password;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[PGAccountInfo alloc] initWithUsername:self.username password:self.password];
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([self class] != [other class]) {
        return NO;
    }
    PGAccountInfo *info = (PGAccountInfo *)other;
    return [self.username isEqualToString:info.username];
}

- (NSUInteger)hash {
    return self.username.hash;
}


@end
