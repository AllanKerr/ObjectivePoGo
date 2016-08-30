//
//  ViewController.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "ViewController.h"
#import "PGAccountManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // PGAccountManager handles all account operations
    
    // PGAccountManager is primarily designed for map object queries.
    // queryMapWithCoordinate:completion: and queryMapWithCellId:coordinate:completion: are used to fetch map objects
    // These two queries DO NOT require the API user to manually log into accounts. PGAccountManager will auto-scale the
    // number of accounts based on query rate using the accounts in Accounts.plist.
    
    // PGAccountManager handles rate limiting internaly. Map object queries can be sent as fast as possible.
    // If there aren't enough accounts to handle the request rate the error code will be PGErrorCodeNoInactiveAccounts
    // If more accounts are being signed into to try and accomodate the query rate the error code will be PGErrorCodeSigningIn
    // In the case of an error in almost cases you can just call queryMapWithCoordinate again.
    
    // Perform a query at the specified location. These queries fetch data for it and surrounding cells. This can be used for traditional scanning.
    [[PGAccountManager sharedInstance] queryMapWithCoordinate:CLLocationCoordinate2DMake(40.752812, -73.982620) completion:^(NSString *username, GetMapObjectsResponse *response, NSError *error){
        NSLog(@"%@", response);
    }];
    
    // Perform a query for the data in the exact cell id to be used for spawn point scanners.
    // The coordinate is the location the account is moved to and it is recommended to be randomized within a few meters of the actual cell id.
    
    /*[[PGAccountManager sharedInstance] queryMapWithCellId:9926594386286608384 coordinate:CLLocationCoordinate2DMake(40.7533402475061, -73.982314235738) completion:^(NSString *username, GetMapObjectsResponse *response, NSError *error){
        NSLog(@"%@", response);
    }];*/
    
    
    
    
    
    // PGAccountManager can also handle other requests
    // Because non-map object requests are account based they require manually login
    // Other requests can easily be added by subclassing PGRequest and adding it to PGAccount
    
    PGAccountInfo *info = [[PGAccountInfo alloc] initWithUsername:@"username" password:@"password"];
    [[PGAccountManager sharedInstance] loginWithAccountInfo:info completion:^(PGAccount *account, NSError *error){
        if (error == nil) {
            [account getProfileWithCompletion:^(GetPlayerResponse *response, NSError *error){
                NSLog(@"%@", response);
            }];
        } else {
            NSLog(@"%@", error);
        }
        /*[account acceptTermsOfServiceWithCompletion:^(NSError *error){
            // successful if error == nil
        }];*/
    }];
}

@end
