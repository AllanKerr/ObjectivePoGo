//
//  PKRequest.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseEnvelope.pbobjc.h"
#import "PGAccount.h"
#import "PGRequest.h"
#import "PGResponse.h"
#import "PGRequestInfoProvider.h"

typedef void(^PKRequestCompletion)(NSArray <PGResponse *>*responses, NSError *error);

@interface PGRequestGroup : NSObject
- (id)initWithInfoProvider:(id <PGRequestInfoProvider>)infoProvider completion:(PKRequestCompletion)completion;
- (void)addRequest:(PGRequest *)request;
- (void)start;
@end
