//
//  PGDeviceInfo.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGDeviceInfo.h"

@interface PGDeviceInfo ()
@property (readwrite, nonatomic, strong) NSString *deviceId;
@end

@implementation PGDeviceInfo
@dynamic deviceBrand;
@dynamic deviceModel;
@dynamic deviceModelBoot;
@dynamic hardwareManufacturer;
@dynamic hardwareModel;
@dynamic firmwareBrand;
@dynamic firmwareType;

- (NSString *)deviceBrand {
    return @"Apple";
}

- (NSString *)deviceModel {
    return @"iPhone";
}

- (NSString *)deviceModelBoot {
    return [NSString stringWithUTF8String:"iPhone6,1"];
}

- (NSString *)hardwareManufacturer {
    return @"Apple";
}

- (NSString *)hardwareModel {
    return [NSString stringWithUTF8String:"N51AP"];
}

- (NSString *)firmwareBrand {
    return @"iPhone OS";
}

- (NSString *)firmwareType {
    return @"9.3.4";
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:@"device_info {\n"];
    [description appendFormat:@"\tdeviceId: %@\n", self.deviceId];
    [description appendFormat:@"\tdeviceBrand: %@\n", self.deviceBrand];
    [description appendFormat:@"\tdeviceModel: %@\n", self.deviceModel];
    [description appendFormat:@"\tdeviceModelBoot: %@\n", self.deviceModelBoot];
    [description appendFormat:@"\thardwareManufacturer: %@\n", self.hardwareManufacturer];
    [description appendFormat:@"\thardwareModel: %@\n", self.hardwareModel];
    [description appendFormat:@"\tfirmwareBrand: %@\n", self.firmwareBrand];
    [description appendFormat:@"\tfirmwareType: %@\n", self.firmwareType];
    [description appendString:@"}"];
    return description;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *rawDeviceId = [[NSUUID UUID] UUIDString];
        NSString *uppercaseDeviceId = [rawDeviceId stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.deviceId = [uppercaseDeviceId lowercaseString];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.deviceId forKey:@"deviceId"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.deviceId = [aDecoder decodeObjectForKey:@"deviceId"];
    }
    return self;
}

@end
