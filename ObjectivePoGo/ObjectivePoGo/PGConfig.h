//
//  PGConfig.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-20.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>

// The most recent app version used by DownloadRemoteConfigVersionRequest
FOUNDATION_EXPORT const uint32_t PGCongfigAppVersion;

// The query interval before the server begins to rate limit requests
FOUNDATION_EXPORT const uint32_t PGConfigQueryInterval;

// The base value travel rate is randomized around in m/s
FOUNDATION_EXPORT const float PGConfigBaseTravelRate;

// The base altitude above sea level that altitude is randomized around
FOUNDATION_EXPORT const float PGConfigBaseAltitude;
