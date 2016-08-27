//
//  PGNameGenerator.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-26.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGNameGenerator.h"

@interface PGNameGenerator ()
@property (nonatomic, strong) NSArray *prefixes;
@property (nonatomic, strong) NSArray *suffixes;
@property (nonatomic, strong) NSArray *vowels;
@end

@implementation PGNameGenerator

- (instancetype)init {
    if (self = [super init]) {
        self.prefixes = @[@"b", @"c", @"d", @"f",
                          @"g", @"h", @"j", @"k",
                          @"l", @"m", @"n", @"p",
                          @"q", @"r", @"s", @"t",
                          @"v", @"w", @"x", @"y",
                          @"z", @"bl", @"br", @"cl",
                          @"cr", @"dr", @"fl", @"fr",
                          @"gl", @"gr", @"pl", @"pr",
                          @"sk", @"sl", @"sm", @"sn",
                          @"sp", @"st", @"str", @"sw",
                          @"tr", @"ch", @"sh"];
        
        self.suffixes = @[@"b", @"c", @"d", @"f",
                          @"g", @"h", @"j", @"k",
                          @"l", @"m", @"n", @"p",
                          @"q", @"r", @"s", @"t",
                          @"v", @"w", @"x", @"y",
                          @"z", @"ct", @"ft", @"mp",
                          @"nd", @"ng", @"nk", @"nt",
                          @"pt", @"sk", @"sp", @"ss",
                          @"st", @"ch", @"sh"];
        
        self.vowels = @[@"a", @"e", @"i", @"o", @"u"];
    }
    return self;
}

- (NSString *)randomWord {
    NSString *prefix = [self.prefixes objectAtIndex:(arc4random() % self.prefixes.count)];
    NSString *suffix = [self.suffixes objectAtIndex:(arc4random() % self.suffixes.count)];
    NSString *vowel = [self.vowels objectAtIndex:(arc4random() % self.vowels.count)];
    return [NSString stringWithFormat:@"%@%@%@", prefix, vowel, suffix];
}

- (NSString *)randomName {
    return [NSString stringWithFormat:@"%@%@%@", [self randomWord], [self randomWord], [self randomWord]];
}

@end
