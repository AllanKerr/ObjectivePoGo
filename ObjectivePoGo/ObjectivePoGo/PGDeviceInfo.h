//
//  PGDeviceInfo.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGDeviceInfo : NSObject <NSCoding>
@property (readonly, nonatomic, strong) NSString *deviceId;
@property (readonly, nonatomic, strong) NSString *deviceBrand;
@property (readonly, nonatomic, strong) NSString *deviceModel;
@property (readonly, nonatomic, strong) NSString *deviceModelBoot;
@property (readonly, nonatomic, strong) NSString *hardwareManufacturer;
@property (readonly, nonatomic, strong) NSString *hardwareModel;
@property (readonly, nonatomic, strong) NSString *firmwareBrand;
@property (readonly, nonatomic, strong) NSString *firmwareType;
- (instancetype)init;
@end
