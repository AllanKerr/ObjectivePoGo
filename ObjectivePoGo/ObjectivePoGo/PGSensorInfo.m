//
//  PGSensorInfo.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGSensorInfo.h"

#define ARC4RANDOM_MAX 0x100000000

@interface PGSensorInfo ()
@property (readwrite, nonatomic) double magnetometerX;
@property (readwrite, nonatomic) double magnetometerY;
@property (readwrite, nonatomic) double magnetometerZ;
@property (readwrite, nonatomic) double angleNormalizedX;
@property (readwrite, nonatomic) double angleNormalizedY;
@property (readwrite, nonatomic) double angleNormalizedZ;
@property (readwrite, nonatomic) double accelRawX;
@property (readwrite, nonatomic) double accelRawY;
@property (readwrite, nonatomic) double accelRawZ;
@property (readwrite, nonatomic) double gyroscopeRawX;
@property (readwrite, nonatomic) double gyroscopeRawY;
@property (readwrite, nonatomic) double gyroscopeRawZ;
@end

@implementation PGSensorInfo
@dynamic accelNormalizedX;
@dynamic accelNormalizedY;
@dynamic accelNormalizedZ;

- (double)accelNormalizedX {
    return self.accelRawX * -9.8;
}

- (double)accelNormalizedY {
    return self.accelRawY * -9.8;
}

- (double)accelNormalizedZ {
    return self.accelRawZ * -9.8;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:@"sensor_info {\n"];
    [description appendFormat:@"\tmagnetometer_x: %f\n", self.magnetometerX];
    [description appendFormat:@"\tmagnetometer_y: %f\n", self.magnetometerY];
    [description appendFormat:@"\tmagnetometer_z: %f\n", self.magnetometerZ];
    [description appendFormat:@"\tangle_normalized_x: %f\n", self.angleNormalizedX];
    [description appendFormat:@"\tangle_normalized_y: %f\n", self.angleNormalizedY];
    [description appendFormat:@"\tangle_normalized_z: %f\n", self.angleNormalizedZ];
    [description appendFormat:@"\taccel_raw_x: %f\n", self.accelRawX];
    [description appendFormat:@"\taccel_raw_y: %f\n", self.accelRawY];
    [description appendFormat:@"\taccel_raw_z: %f\n", self.accelRawZ];
    [description appendFormat:@"\tgyroscope_raw_x: %f\n", self.gyroscopeRawX];
    [description appendFormat:@"\tgyroscope_raw_y: %f\n", self.gyroscopeRawY];
    [description appendFormat:@"\tgyroscope_raw_z: %f\n", self.gyroscopeRawZ];
    [description appendFormat:@"\taccel_normalized_x: %f\n", self.accelNormalizedX];
    [description appendFormat:@"\taccel_normalized_y: %f\n", self.accelNormalizedY];
    [description appendFormat:@"\taccel_normalized_z: %f\n", self.accelNormalizedZ];
    [description appendString:@"}"];
    return description;
}


- (instancetype)initWithHeading:(CLHeading *)heading magneticField:(CMMagneticField)magneticField acceleration:(CMAcceleration)acceleration rotationRate:(CMRotationRate)rotationRate {
    if (self = [super init]) {
        self.magnetometerX = magneticField.x / 128;
        self.magnetometerY = magneticField.y / 128;
        self.magnetometerZ = magneticField.z / 128;
        
        self.angleNormalizedX = round((heading.x * 4.0))/4.0;
        self.angleNormalizedY = round((heading.y * 4.0))/4.0;
        self.angleNormalizedZ = round((heading.z * 4.0))/4.0;

        self.accelRawX = acceleration.x;
        self.accelRawY = acceleration.y;
        self.accelRawZ = acceleration.z;
        
        self.gyroscopeRawX = rotationRate.x;
        self.gyroscopeRawY = rotationRate.y;
        self.gyroscopeRawZ = rotationRate.z;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.magnetometerX forKey:@"magnetometerX"];
    [aCoder encodeDouble:self.magnetometerY forKey:@"magnetometerY"];
    [aCoder encodeDouble:self.magnetometerZ forKey:@"magnetometerZ"];

    [aCoder encodeDouble:self.angleNormalizedX forKey:@"angleNormalizedX"];
    [aCoder encodeDouble:self.angleNormalizedY forKey:@"angleNormalizedY"];
    [aCoder encodeDouble:self.angleNormalizedZ forKey:@"angleNormalizedZ"];
    
    [aCoder encodeDouble:self.accelRawX forKey:@"accelRawX"];
    [aCoder encodeDouble:self.accelRawY forKey:@"accelRawY"];
    [aCoder encodeDouble:self.accelRawZ forKey:@"accelRawZ"];
    
    [aCoder encodeDouble:self.gyroscopeRawX forKey:@"gyroscopeRawX"];
    [aCoder encodeDouble:self.gyroscopeRawY forKey:@"gyroscopeRawY"];
    [aCoder encodeDouble:self.gyroscopeRawZ forKey:@"gyroscopeRawZ"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.magnetometerX = [aDecoder decodeDoubleForKey:@"magnetometerX"];
        self.magnetometerY = [aDecoder decodeDoubleForKey:@"magnetometerY"];
        self.magnetometerZ = [aDecoder decodeDoubleForKey:@"magnetometerZ"];

        self.angleNormalizedX = [aDecoder decodeDoubleForKey:@"angleNormalizedX"];
        self.angleNormalizedY = [aDecoder decodeDoubleForKey:@"angleNormalizedY"];
        self.angleNormalizedZ = [aDecoder decodeDoubleForKey:@"angleNormalizedZ"];
        
        self.accelRawX = [aDecoder decodeDoubleForKey:@"accelRawX"];
        self.accelRawY = [aDecoder decodeDoubleForKey:@"accelRawY"];
        self.accelRawZ = [aDecoder decodeDoubleForKey:@"accelRawZ"];
        
        self.gyroscopeRawX = [aDecoder decodeDoubleForKey:@"gyroscopeRawX"];
        self.gyroscopeRawY = [aDecoder decodeDoubleForKey:@"gyroscopeRawY"];
        self.gyroscopeRawZ = [aDecoder decodeDoubleForKey:@"gyroscopeRawZ"];
    }
    return self;
}

- (void)averageWithSensorData:(PGSensorInfo *)sensorInfo weight:(double)weight {
    double myWeight = 1 - weight;
    self.magnetometerX = [self applyNoise:(myWeight * self.magnetometerX) + (weight * sensorInfo.magnetometerX) magnitude:0.25];
    self.magnetometerY = [self applyNoise:(myWeight * self.magnetometerY) + (weight * sensorInfo.magnetometerY) magnitude:0.25];
    self.magnetometerZ = [self applyNoise:(myWeight * self.magnetometerZ) + (weight * sensorInfo.magnetometerZ) magnitude:0.25];
    
    self.angleNormalizedX = round([self applyNoise:(myWeight * self.angleNormalizedX) + (weight * sensorInfo.angleNormalizedX) magnitude:1.25] * 4.0) / 4.0;
    self.angleNormalizedY = round([self applyNoise:(myWeight * self.angleNormalizedY) + (weight * sensorInfo.angleNormalizedY) magnitude:1.25] * 4.0) / 4.0;
    self.angleNormalizedZ = round([self applyNoise:(myWeight * self.angleNormalizedZ) + (weight * sensorInfo.angleNormalizedZ) magnitude:1.25] * 4.0) / 4.0;
    
    self.accelRawX = [self applyNoise:(myWeight * self.accelRawX) + (weight * sensorInfo.accelRawX) magnitude:0.1];
    self.accelRawY = [self applyNoise:(myWeight * self.accelRawY) + (weight * sensorInfo.accelRawY) magnitude:0.1];
    self.accelRawZ = [self applyNoise:(myWeight * self.accelRawZ) + (weight * sensorInfo.accelRawZ) magnitude:0.1];
    
    self.gyroscopeRawX = [self applyNoise:(myWeight * self.gyroscopeRawX) + (weight * sensorInfo.gyroscopeRawX) magnitude:0.25];
    self.gyroscopeRawY = [self applyNoise:(myWeight * self.gyroscopeRawY) + (weight * sensorInfo.gyroscopeRawY) magnitude:0.25];
    self.gyroscopeRawZ = [self applyNoise:(myWeight * self.gyroscopeRawZ) + (weight * sensorInfo.gyroscopeRawZ) magnitude:0.25];
}

- (double)applyNoise:(double)value magnitude:(double)magnitude {
    return value + ((CLLocationDegrees)arc4random() / ARC4RANDOM_MAX) * (2 * magnitude) - magnitude;
}

@end
