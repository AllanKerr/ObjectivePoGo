;//
//  PGAccuracy.m
//  Pokemap
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-28.
//  Copyright © 2016 ruffneck. All rights reserved.
//

#import "PGAccuracy.h"

@interface PGAccuracy ()
@property (nonatomic) BOOL isNarrowed;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSArray *accuracies;
@property (readonly, nonatomic) BOOL hasInaccuracy;
@property (readonly, nonatomic) BOOL shouldNarrow;
@property (readwrite, nonatomic) CLLocationAccuracy accuracy;
@property (readwrite, nonatomic) CLLocationAccuracy lastAccuracy;
@end

@implementation PGAccuracy
@dynamic hasInaccuracy;

- (BOOL)hasInaccuracy {
    return (arc4random() % 10) == 0;
}

- (BOOL)shouldNarrow {
    return (arc4random() % 2) == 0;
}

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (CLLocationAccuracy)accuracy {
    if (self.isNarrowed && self.hasInaccuracy) {
        return self.lastAccuracy;
    } else {
        return _accuracy;
    }
}

+ (NSArray *)horizontalAccuracies {
    static dispatch_once_t once;
    static NSArray *accuracies;
    dispatch_once(&once, ^{
        accuracies = @[@65, @30, @10, @5];
    });
    return accuracies;
}

+ (NSArray *)verticalAccuracies {
    static dispatch_once_t once;
    static NSArray *accuracies;
    dispatch_once(&once, ^{
        accuracies = @[@24, @12, @10, @8, @6];
    });
    return accuracies;
}

+ (PGAccuracy *)horizontalAccuracy {
    return [[PGAccuracy alloc] initWithAccuracies:[self horizontalAccuracies]];
}

+ (PGAccuracy *)verticalAccuracy {
    return [[PGAccuracy alloc] initWithAccuracies:[self verticalAccuracies]];
}

- (instancetype)initWithAccuracies:(NSArray <NSNumber *>*)accuracies {
    if (self = [super init]) {
        self.accuracy = [[accuracies firstObject] doubleValue];
        self.accuracies = accuracies;
    }
    return self;
}

- (void)narrow {
    if (!self.isNarrowed && self.shouldNarrow) {
        self.lastAccuracy = self.accuracy;
        self.accuracy = [[self.accuracies objectAtIndex:++self.index] doubleValue];
        self.isNarrowed = self.index == (self.accuracies.count - 1);
    }
}

@end
