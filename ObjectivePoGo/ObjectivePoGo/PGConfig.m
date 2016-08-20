//
//  PGConfig.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-20.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGConfig.h"

// The most recent app version used by DownloadRemoteConfigVersionRequest
const uint32_t PGCongfigAppVersion = 3300;

// The query interval before the server begins to rate limit requests
const uint32_t PGConfigQueryInterval = 10;

// The base value travel rate is randomized around in m/s
const float PGConfigBaseTravelRate = 16.6667;

// The base altitude above sea level that altitude is randomized around
const float PGConfigBaseAltitude = 93;
