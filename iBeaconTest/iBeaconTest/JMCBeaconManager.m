//
//  JMCBeaconManager.m
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//
@import CoreLocation;

#import "JMCBeaconManager.h"

@interface JMCBeaconManager()<CLLocationManagerDelegate>
{
    CLBeaconRegion *beaconRegion;
    CLBeaconRegion *beaconRegion2;
    CLBeaconRegion *beaconRegion3;
}
@property(nonatomic,strong)CLLocationManager * locationManager;
@end


@implementation JMCBeaconManager


-(void)logMessage:(NSString *)message{
    self.logView.text = [NSString stringWithFormat:@"%@\n\n%@",self.logView.text,message];
}

-(id)init{
    self = [super init];
    if(self){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy  = 1;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return self;
}


-(BOOL)isEnabled{
    return [CLLocationManager isMonitoringAvailableForClass:[CLRegion class]] &&[CLLocationManager authorizationStatus ]== kCLAuthorizationStatusAuthorized;
}

-(BOOL)CanDeviceSupportAppBackgroundRefresh
{
    // Override point for customization after application launch.
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable) {
        NSLog(@"Background updates are available for the app.");
        return YES;
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied)
    {
        NSLog(@"The user explicitly disabled background behavior for this app or for the whole system.");
        return NO;
    }
    else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted)
    {
        NSLog(@"Background updates are unavailable and the user cannot enable them again. For example, this status can occur when parental controls are in effect for the current user.");
        return NO;
    }
    return NO;
}

// Create a beacon identifier using uuidgen

/*
 Estimote beacons use a fixed Proximity UUID of B9407F30-F5F8-466E-AFF9-25556B57FE6D.
 
 Each beacon has a unique ID formatted as follows: proximityUUID.major.minor. We reserved the proximityUUID for all our beacons. The major and minor values are randomized by default but can be customized.
 */

-(void)registerBeaconWithProximityId:(NSString*)pid andIdentifier:(NSString *)identifier{
    NSUUID *proximityUUID = [[NSUUID alloc]
                             initWithUUIDString:pid];
    
    
    beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID major:1 minor:1 identifier:@"1"];
    
    beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID major:1 identifier:@"1"];
    
    
  //  beaconRegion2 = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID major:1 minor:2 identifier:@"2"];
   // beaconRegion3 = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID major:1 minor:3 identifier:@"3"];

    beaconRegion.notifyOnEntry=YES;
    beaconRegion.notifyOnExit=YES;
    beaconRegion.notifyEntryStateOnDisplay=YES;
    beaconRegion2.notifyOnEntry=YES;
    beaconRegion2.notifyOnExit=YES;
    beaconRegion2.notifyEntryStateOnDisplay=YES;
    beaconRegion3.notifyOnEntry=YES;
    beaconRegion3.notifyOnExit=YES;
    beaconRegion3.notifyEntryStateOnDisplay=YES;
    
//    [self.locationManager startMonitoringForRegion:beaconRegion3];
    [self.locationManager startMonitoringForRegion:beaconRegion];
//  [self.locationManager startMonitoringForRegion:beaconRegion2];
   
}

/*Tells the delegate that the user enter  specified region.*/
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    if([region isKindOfClass:[CLBeaconRegion class]]){
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *) region];
    }

}


/*Tells the delegate that the user left the specified region.*/
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);


}

/*Tells the delegate about the state of the specified region. (required) */
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    [self logMessage:[NSString stringWithFormat:@"State for region: %@ is: %d",region, state]];
    NSLog(@"%@",log);

    if(state == CLRegionStateInside){
        //check if the region is beacon region
        if([region isKindOfClass:[CLBeaconRegion class]]){
            //start ranging beacons
            [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *) region];
        }
    }
}

-(NSString *)generateID:(NSString *)beaconId andMajor:(NSString *)major andMinor:(NSString *)minor{
    //according to estimote id has format: proximityUUID.major.minor
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);

    return [NSString stringWithFormat:@"%@.%@.%@",beaconId,major,minor];
}

/*Tells the delegate that one or more beacons are in range. */
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    
    for(CLBeacon *beacon in beacons)
    {
        [self logMessage:[NSString stringWithFormat:@"Beacon found: %@",beacon]];
        NSLog(@"Beacon found: %@",beacon);
    }
}

/* Tells the delegate that an error occurred while gathering ranging information for a set of beacons. */
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);

    
}

/*Tells the delegate that a new region is being monitored.*/
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    NSLog(@"%@",region);

}

/*Tells the delegate that the delivery of location updates has resumed.*/
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);

}



@end
