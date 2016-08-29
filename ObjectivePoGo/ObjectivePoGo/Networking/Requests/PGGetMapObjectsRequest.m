//
//  PKGetMapObjectsRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGGetMapObjectsRequest.h"
#import "GetMapObjectsMessage.pbobjc.h"
#import "s2geometry.h"

@implementation PGGetMapObjectsRequest

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [super initWithType:RequestType_GetMapObjects]) {
        GetMapObjectsMessage *message = [GetMapObjectsMessage message];
        NSArray *cells = [s2geometry cellsForCoordinate:coordinate];
        for (NSString *cell in cells) {
            unsigned long long result = 0;
            NSScanner *scanner = [NSScanner scannerWithString:cell];
            [scanner scanHexLongLong:&result];
            [message.cellIdArray addValue:result];
            [message.sinceTimestampMsArray addValue:0];
        }
        message.latitude = coordinate.latitude;
        message.longitude = coordinate.longitude;
        
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate cellId:(uint64_t)cellId {
    if (self = [super initWithType:RequestType_GetMapObjects]) {
        GetMapObjectsMessage *message = [GetMapObjectsMessage message];
        [message.cellIdArray addValue:cellId];
        [message.sinceTimestampMsArray addValue:0];
        message.latitude = coordinate.latitude;
        message.longitude = coordinate.longitude;
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
