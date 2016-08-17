//
//  PGSensorSpoofer.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGSensorSpoofer.h"

@interface PGSensorSpoofer ()
@property (nonatomic, strong) NSDictionary *sensorData;
@end

@implementation PGSensorSpoofer

+ (PGSensorSpoofer *)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"SensorData" ofType:@"plist"];
        self.sensorData = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    }
    return self;
}

- (PGSensorInfo *)sensorInfoForHeading:(CLLocationDirection)heading {
    CLLocationDirection min = floor(heading);
    CLLocationDirection max = ceil(heading);
    
    NSNumber *minKey = [NSNumber numberWithInteger:min];
    NSNumber *maxKey = [NSNumber numberWithInteger:max];

    double weight = max - heading;
    PGSensorInfo *sensorInfo = [self.sensorData objectForKey:minKey];
    PGSensorInfo *other = [self.sensorData objectForKey:maxKey];
    [sensorInfo averageWithSensorData:other weight:weight];
    return sensorInfo;
}

- (PGSensorInfo *)sensorInfo {
    return [self sensorInfoForHeading:arc4random() % 360];
}

@end
