//
//  PGWanderingValue.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-29.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGWanderingValue.h"
#import "PGUtil.h"

@interface PGWanderingValue ()
@property (readwrite, nonatomic) double value;
@property (readwrite, nonatomic) double maxValue;
@property (readwrite, nonatomic) double minValue;
@property (readwrite, nonatomic) double midDelta;
@property (readwrite, nonatomic) double magnitudeDelta;
@end


@implementation PGWanderingValue

- (BOOL)isIncreasing {
    return arc4random() % 2;
}

- (double)value {
    double delta = [PGUtil applyNoise:self.midDelta magnitude:self.magnitudeDelta];
    if (self.isIncreasing) {
        delta = -delta;
    }
    double value = _value + delta;
    if (value > self.maxValue || value < self.minValue) {
        value = _value - delta;
    }
    _value = value;
    return _value;
}

- (instancetype)initWithMax:(double)max min:(double)min minDelta:(double)minDelta maxDelta:(double)maxDelta {
    if (self = [super init]) {
        self.maxValue = max;
        self.minValue = min;
        self.midDelta = (maxDelta + minDelta) / 2;
        self.magnitudeDelta = fabs(maxDelta - self.midDelta);

        double midValue = (max + min) / 2;
        self.value = [PGUtil applyNoise:midValue magnitude:(max - midValue)];
    }
    return self;
}

@end
