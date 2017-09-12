# ObjectivePoGo

ObjectivePoGo is an Objective C API developed fetching data from the Pokemon Go servers prior to the Oct. 7, 2016 update. It was developed to allow scanning from iOS devices while on the go without the need for a central server.

# Usage:
## Authentication:
To begin scanning, one or more accounts must be signed with PGAccountManager. The -loginWithAccountInfo: method can be called many times to perform multi-account scanning.
```Objective-C
PGAccountInfo *info = [[PGAccountInfo alloc] initWithUsername:@"username" password:@"password"];
[[PGAccountManager sharedInstance] loginWithAccountInfo:info atCoordinate:CLLocationCoordinate2DMake(40.752812, -73.982620) completion:^(PGAccount *account, NSError *error){
  if (error == nil) {
    [account getProfileWithCompletion:^(GetPlayerResponse *response, NSError *error){
      NSLog(@"%@", response);
    }];
  } else {
      NSLog(@"%@", error);
  }
}];
```
## Scanning:
Once one or more accounts have successfully logged in, scanning can begin. When a new location is scanned, the nearest available account is moved to the coordinate for scanning.

### Coordinate Scanning:
Perform a query at the specified location. These queries fetch data for it and surrounding cells.
```Objective-C
[[PGAccountManager sharedInstance] queryMapWithCoordinate:CLLocationCoordinate2DMake(40.752812, -73.982620) completion:^(NSString *username, GetMapObjectsResponse *response, NSError *error){
  NSLog(@"%@", response);
}];
```

### S2Cell Scanning:
Perform a query for the data in the exact cell id to be used for spawn point scanners. The coordinate is the location the account is moved to and it is recommended to be randomized within a few meters of the actual cell id.
```Objective-C
[[PGAccountManager sharedInstance] queryMapWithCellId:9926594386286608384 coordinate:CLLocationCoordinate2DMake(40.7533402475061, -73.982314235738) completion:^(NSString *username, GetMapObjectsResponse *response, NSError *error){
  NSLog(@"%@", response);
}];
```
