//
//  PGSensorInfo.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface PGSensorInfo : NSObject <NSCoding>
@property (readonly, nonatomic) double magnetometerX;
@property (readonly, nonatomic) double magnetometerY;
@property (readonly, nonatomic) double magnetometerZ;
@property (readonly, nonatomic) double angleNormalizedX;
@property (readonly, nonatomic) double angleNormalizedY;
@property (readonly, nonatomic) double angleNormalizedZ;
@property (readonly, nonatomic) double accelRawX;
@property (readonly, nonatomic) double accelRawY;
@property (readonly, nonatomic) double accelRawZ;
@property (readonly, nonatomic) double gyroscopeRawX;
@property (readonly, nonatomic) double gyroscopeRawY;
@property (readonly, nonatomic) double gyroscopeRawZ;
@property (readonly, nonatomic) double accelNormalizedX;
@property (readonly, nonatomic) double accelNormalizedY;
@property (readonly, nonatomic) double accelNormalizedZ;
- (instancetype)initWithHeading:(CLHeading *)heading magneticField:(CMMagneticField)magneticField acceleration:(CMAcceleration)acceleration rotationRate:(CMRotationRate)rotationRate;
- (void)averageWithSensorData:(PGSensorInfo *)sensorInfo weight:(double)weight;
@end
