//
//  PMAccountManager.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGAccount.h"
#import "PGAccountInfo.h"

@interface PGAccountManager : NSObject
@property (readonly, nonatomic) NSUInteger activeAccountsCount;
+ (PGAccountManager *)sharedInstance;
- (void)loginWithAccountInfo:(PGAccountInfo *)accountInfo completion:(PGAccountCompletion)completion;
- (void)queryMapWithCoordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion;
- (void)queryMapWithCellId:(uint64_t)cellId coordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion;
@end
