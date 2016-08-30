//
//  PGConfig.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-20.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

// The most recent app version used by DownloadRemoteConfigVersionRequest
FOUNDATION_EXPORT const uint32_t PGConfigAppVersion;

// The query interval before the server begins to rate limit requests
FOUNDATION_EXPORT const uint32_t PGConfigQueryInterval;

FOUNDATION_EXPORT NSString *const PGConfigLanguage;
FOUNDATION_EXPORT NSString *const PGConfigCountry;

FOUNDATION_EXPORT const CLLocationDistance PGConfigMaxAltitude;
FOUNDATION_EXPORT const CLLocationDistance PGConfigMinAltitude;
FOUNDATION_EXPORT const CLLocationDistance PGConfigMaxAltitudeDelta;
FOUNDATION_EXPORT const CLLocationDistance PGConfigMinAltitudeDelta;

FOUNDATION_EXPORT const CLLocationSpeed PGConfigMaxSpeed;
FOUNDATION_EXPORT const CLLocationSpeed PGConfigMinSpeed;
FOUNDATION_EXPORT const CLLocationSpeed PGConfigMaxSpeedDelta;
FOUNDATION_EXPORT const CLLocationSpeed PGConfigMinSpeedDelta;

FOUNDATION_EXPORT const NSInteger PGConfigMaxLocationFixCount;
