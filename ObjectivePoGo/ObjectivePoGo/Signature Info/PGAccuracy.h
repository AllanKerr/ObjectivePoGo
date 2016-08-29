//
//  PGAccuracy.h
//  Pokemap
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-28.
//  Copyright © 2016 ruffneck. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface PGAccuracy : NSObject
@property (readonly, nonatomic) CLLocationAccuracy accuracy;
+ (PGAccuracy *)horizontalAccuracy;
+ (PGAccuracy *)verticalAccuracy;
- (void)narrow;
@end
