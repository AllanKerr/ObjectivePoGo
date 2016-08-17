//
//  PMAccountManager.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGAccountManager.h"
#import "PGAccountInfo.h"
#import "PGDeviceInfo.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

typedef void(^PMFetchAccountCompletion)(PGAccount *, NSError *);

NSString *const PGAccountsFilename = @"Accounts.plist";
NSString *const PGDeviceInfosFilename = @"DeviceInfo.plist";

@interface PGAccountManager ()
@property (nonatomic) BOOL isPerformingLogin;
@property (nonatomic) NSInteger minAccountBuffer;
@property (nonatomic) NSInteger maxAccountBuffer;
@property (nonatomic, strong) NSMutableArray *bufferAccounts;
@property (nonatomic, strong) NSMutableArray *inactiveAccounts;
@property (nonatomic, strong) NSMutableArray *activeAccounts;
@property (nonatomic, strong) NSMutableDictionary *activeAccountsDict;
@property (nonatomic, strong) NSMutableDictionary *deviceInfos;
@property (readonly, nonatomic) NSString *deviceInfosPath;
@end

@implementation PGAccountManager
@dynamic activeAccountsCount;
@dynamic deviceInfosPath;

- (NSUInteger)activeAccountsCount {
    return self.activeAccounts.count;
}

- (NSString *)deviceInfosPath {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentsPath stringByAppendingPathComponent:PGDeviceInfosFilename];
}

- (void)setMinAccountBuffer:(NSInteger)minAccountBuffer {
    _minAccountBuffer = minAccountBuffer;
    self.maxAccountBuffer = 2 * minAccountBuffer;
    self.bufferAccounts = [NSMutableArray arrayWithCapacity:self.maxAccountBuffer];
}

+ (PGAccountManager *)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *accountsPath = [[NSBundle mainBundle] pathForResource:PGAccountsFilename ofType:nil];
        NSMutableArray *accountInfos = [NSMutableArray arrayWithContentsOfFile:accountsPath];
        self.inactiveAccounts = [NSMutableArray arrayWithCapacity:accountInfos.count];
        for (NSDictionary *info in accountInfos) {
            PGAccountInfo *accountInfo = [[PGAccountInfo alloc] initWithInfo:info];
            [self.inactiveAccounts addObject:accountInfo];
        }
        self.activeAccounts = [NSMutableArray arrayWithCapacity:self.inactiveAccounts.count];
        self.activeAccountsDict = [NSMutableDictionary dictionaryWithCapacity:self.inactiveAccounts.count];
        self.minAccountBuffer = roundf(self.inactiveAccounts.count * 0.078125);
        self.isPerformingLogin = NO;
        
        [self _loadDeviceInfo];
    }
    return self;
}

- (PGDeviceInfo *)_fetchDeviceInfoForUsername:(NSString *)username {
    PGDeviceInfo *deviceInfo = [self.deviceInfos valueForKey:username];
    if (deviceInfo == nil) {
        deviceInfo = [[PGDeviceInfo alloc] init];
        [self.deviceInfos setValue:deviceInfo forKey:username];
        [self _saveDeviceInfo];
    }
    return deviceInfo;
}

- (void)_loadDeviceInfo {
    self.deviceInfos = [[NSKeyedUnarchiver unarchiveObjectWithFile:self.deviceInfosPath] mutableCopy];
    if (self.deviceInfos == nil) {
        self.deviceInfos = [NSMutableDictionary dictionary];
    }
}

- (void)_saveDeviceInfo {
    if (![NSKeyedArchiver archiveRootObject:self.deviceInfos toFile:self.deviceInfosPath]) {
        NSLog(@"Failed to save device info");
    }
}

- (void)loginWithAccountInfo:(PGAccountInfo *)accountInfo completion:(PGAccountCompletion)completion {
    PGAccount *account = [self.activeAccountsDict objectForKey:accountInfo];
    if (account != nil) {
        return completion(account, nil);
    }
    self.isPerformingLogin = YES;
    [self.inactiveAccounts removeObject:accountInfo];
    
    PGDeviceInfo *deviceInfo = [self _fetchDeviceInfoForUsername:accountInfo.username];
    NSLog(@"%@ signing in...", accountInfo.username);
    [PGAccount loginWithAccountInfo:accountInfo deviceInfo:deviceInfo completion:^(PGAccount *account, NSError *error){
        if (error == nil) {
            NSLog(@"Sign in succeeded: %@", accountInfo.username);
            [self.activeAccountsDict setObject:account forKey:accountInfo];
            [self.activeAccounts addObject:account];
        } else {
            NSLog(@"Sign in failed: %@", accountInfo.username);
            [self.inactiveAccounts addObject:accountInfo];
        }
        self.isPerformingLogin = NO;
        completion(account, error);
    }];
}

- (void)_fetchOptimalAccountForCoordinate:(CLLocationCoordinate2D)coordinate completion:(PMFetchAccountCompletion)completion {
    PGAccount *optimalAccount = nil;
    NSInteger currentAccountBuffer = 0;
    CLLocationDistance distance = CLLocationDistanceMax;
    [self.bufferAccounts removeAllObjects];

    for (NSInteger i = self.activeAccounts.count - 1; i >= 0; i--) {
        PGAccount *account = [self.activeAccounts objectAtIndex:i];
        if (account.isReadyForQuery) {
            CLLocationDistance dist = [account distanceFromCoordinate:coordinate];
            if (distance > dist) {
                if (optimalAccount != nil) {
                    [self.bufferAccounts addObject:optimalAccount];
                }
                optimalAccount = account;
                distance = dist;
            }
            currentAccountBuffer++;
        }
    }
    if (optimalAccount != nil) {
        completion(optimalAccount, nil);
        if (currentAccountBuffer < self.minAccountBuffer) {
            [self _performLoginForNextAccount:^(PGAccount *account, NSError *error){}];
        } else {
            for (NSInteger j = self.bufferAccounts.count - 1; self.bufferAccounts.count > self.maxAccountBuffer && j >= 0; j--) {
                PGAccount *account = [self.bufferAccounts objectAtIndex:j];
                [self.bufferAccounts removeObjectAtIndex:j];
                [self _deactivateAccount:account];
            }
        }
    } else  {
        [self _performLoginForNextAccount:completion];
    }
}

- (void)_performLoginForNextAccount:(PGAccountCompletion)completion {
    if (self.isPerformingLogin) {
        completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeSigningIn userInfo:nil]);
        return;
    }
    PGAccountInfo *accountInfo = [self.inactiveAccounts firstObject];
    if (accountInfo != nil) {
        [self loginWithAccountInfo:accountInfo completion:completion];
    } else {
        completion(nil, [NSError errorWithDomain:PGErrorDomain code:PGErrorCodeNoInactiveAccounts userInfo:nil]);
    }
}

- (void)_deactivateAccount:(PGAccount *)account {
    [self.activeAccounts removeObject:account];
    [self.activeAccountsDict removeObjectForKey:account.accountInfo];
    [self.inactiveAccounts addObject:account.accountInfo];
}

- (void)queryMapWithCoordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion {
    [self _fetchOptimalAccountForCoordinate:coordinate completion:^(PGAccount *account, NSError *error){
        if (error == nil) {
            [account getMapObjectsForCoordinate:coordinate completion:^(NSString *username, GetMapObjectsResponse *mapObjects, NSError *error){
                if (error.code == PGErrorCodeExpiredAuthTicket) {
                    [self _deactivateAccount:account];
                }
                completion(username, mapObjects, error);
            }];
        } else {
            if (error.code != PGErrorCodeSigningIn) {
                NSLog(@"Failed to find optimal account:%@", error);
            }
            completion(account.accountInfo.username, nil, error);
        }
    }];
}

- (void)queryMapWithCellId:(uint64_t)cellId coordinate:(CLLocationCoordinate2D)coordinate completion:(PGMapObjectsCompletion)completion {
    [self _fetchOptimalAccountForCoordinate:coordinate completion:^(PGAccount *account, NSError *error){
        if (error == nil) {
            [account getMapObjectsForCellId:cellId coordinate:coordinate completion:^(NSString *username, GetMapObjectsResponse *mapObjects, NSError *error){
                if (error.code == PGErrorCodeExpiredAuthTicket) {
                    [self _deactivateAccount:account];
                }
                completion(username, mapObjects, error);
            }];
        } else {
            if (error.code != PGErrorCodeSigningIn) {
                NSLog(@"Failed to find optimal account:%@", error);
            }
            completion(account.accountInfo.username, nil, error);
        }
    }];
}

@end
