//
//  JMCBeaconManager.m
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//


#import "JMCBeaconManager.h"

@interface JMCBeaconManager()<CLLocationManagerDelegate>
{
    CLProximity proximity;
}
@property(nonatomic,strong)CLLocationManager * locationManager;
@property(nonatomic,strong) CLBeacon * currentBeacon;
@end


@implementation JMCBeaconManager


-(void)logMessage:(NSString *)message{
    self.logView.text = [NSString stringWithFormat:@"%@\n %@\n\n%@", [NSDate new],message,self.logView.text];
    NSLog(@"%@ %s ",message,__PRETTY_FUNCTION__);
}

-(id)init{
    self = [super init];
    if(self){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
         [_locationManager startUpdatingLocation];
    }
    return self;
}

/**
    Checks if iBeacon monitoring is supported
 */
-(BOOL)isSupported:(NSMutableString*)message{
    BOOL enabled = NO;

    NSMutableString * msg = [NSMutableString new];
    [msg appendFormat:@""];
    if([CLLocationManager isMonitoringAvailableForClass:[CLRegion class]]){
        enabled = YES;
    }
    else{
        enabled = NO&&enabled;
       [message appendFormat:@"%@ /n %@ ",message, @"Region Monitoring is not available on this device"];
    }
    
    NSLog(@"%d",[CLLocationManager authorizationStatus]);
    
    if([CLLocationManager authorizationStatus ]== kCLAuthorizationStatusAuthorized ){
        enabled = YES&&enabled;
    }
    else{
        enabled = NO&&enabled;
       [message appendFormat:@"%@ /n %@ ",message, @"Applications must be explicitly authorized to use location services by the user and location services must themselves currently be enabled for the system."];
    }


    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable) {
        enabled = YES&&enabled;

    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied)
    {
      [message appendFormat:@"%@ /n %@ ",message, @"The user explicitly disabled background behavior for this app or for the whole system."];
        
        enabled = NO&&enabled;
    }
    else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted)
    {
      
        [message appendFormat:@"%@ /n %@ ",message, @"unavailable on this system due to device configuration; the user cannot enable the feature."];
        
        enabled = NO&&enabled;

    }
    
    if(enabled) {
        message = [@"iBeacon monitoring is supported" mutableCopy];
    }
    [self logMessage:message];

    
    return enabled;
}

-(BOOL)isEnabled{
    return [CLLocationManager isMonitoringAvailableForClass:[CLRegion class]] &&[CLLocationManager authorizationStatus ]== kCLAuthorizationStatusAuthorized;
}

-(BOOL)canDeviceSupportAppBackgroundRefresh
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

/**
 Register beacons only using identifier and proximity uiid
 */
-(void)registerBeaconWithProximityId:(NSString*)pid andIdentifier:(NSString *)identifier{
    NSUUID *proximityUUID = [[NSUUID alloc]
                             initWithUUIDString:pid];
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID identifier:identifier];
    beaconRegion= [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID identifier:identifier];
    
    beaconRegion.notifyOnEntry=YES;
    beaconRegion.notifyOnExit=YES;
    beaconRegion.notifyEntryStateOnDisplay=YES;
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
    
}

/**
 Estimote beacons use a fixed Proximity UUID of B9407F30-F5F8-466E-AFF9-25556B57FE6D.
 
 Each beacon has a unique ID formatted as follows: proximityUUID.major.minor. We reserved the proximityUUID for all our beacons. The major and minor values are randomized by default but can be customized.
 */

-(void)registerBeaconWithProximityId:(NSString*)pid andIdentifier:(NSString *)identifier major:(int)major andMinor:(int)minor{
    NSUUID *proximityUUID = [[NSUUID alloc]
                             initWithUUIDString:pid];
    
    CLBeaconRegion *beaconRegion;// = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID major:major identifier:identifier];
    beaconRegion= [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID identifier:identifier];
    
    beaconRegion.notifyOnEntry=YES;
    beaconRegion.notifyOnExit=YES;
    beaconRegion.notifyEntryStateOnDisplay=YES;
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
}

/**Tells the delegate that the user enter  specified region.*/
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    if([region isKindOfClass:[CLBeaconRegion class]]){
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *) region];
        if(self.regionEvent){
            self.regionEvent([[(CLBeaconRegion *) region major]intValue],[[(CLBeaconRegion *) region minor]intValue],YES);
                             }
    }
    
    
    
}


/** Tells the delegate that the user left the specified region.*/
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    proximity = -1;
    
    if([region isKindOfClass:[CLBeaconRegion class]]){
       [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
        if(self.regionEvent){
            self.regionEvent([[(CLBeaconRegion *) region major]intValue],[[(CLBeaconRegion *) region minor]intValue],NO);
        }

    }
}

/** Tells the delegate about the state of the specified region. (required) */
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    [self logMessage:[NSString stringWithFormat:@"State for region: %@ is: %d",region, (int)state]];
    
    
    
    NSLog(@"%@",log);
    
    if(state == CLRegionStateInside){
        //check if the region is beacon region
        if([region isKindOfClass:[CLBeaconRegion class]]){
            //start ranging beacons
            [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *) region];
        }
    }
}


/**Generates id that can be used as an identifier of the beacon */
-(NSString *)generateID:(NSString *)beaconId andMajor:(NSString *)major andMinor:(NSString *)minor{
    //according to estimote id has format: proximityUUID.major.minor
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    
    return [NSString stringWithFormat:@"%@.%@.%@",beaconId,major,minor];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // Delegate of the location manager, when you have an error
    NSLog(@"didFailWithError: %@", error);
    
    UIAlertView *errorAlert = [[UIAlertView alloc]     initWithTitle:NSLocalizedString(@"application_name", nil) message:NSLocalizedString(@"location_error", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
    
    [errorAlert show];
}

/**Tells the delegate that one or more beacons are in range. */
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    for(CLBeacon *beacon in beacons)
    {
        
        if(proximity != beacon.proximity){
            proximity = beacon.proximity;
            [self logMessage:[NSString stringWithFormat:@"Beacon range: %@",beacon]];
            NSLog(@"Beacon proximity is: %d",(int)beacon.proximity);
            NSLog(@"Beacon found: %@",beacon);
            if(self.beaconFound){
                self.beaconFound(beacon.major.intValue, beacon.minor.intValue, beacon.proximity);
            }
        }
        //  [self displayContentFor:beacon andRegion:region];
    }
    
    
    //[self.locationManager stopRangingBeaconsInRegion:region];
}

/** this method will display a content related to the closest beacon */
-(void)displayContentFor:(CLBeacon * )beacon andRegion:(CLRegion *)region{
    if(!_currentBeacon){
        _currentBeacon = beacon;
    }
    else{
        if([_currentBeacon.proximityUUID isEqual:_currentBeacon.proximityUUID]&&_currentBeacon.major ==_currentBeacon.major&&_currentBeacon.minor == _currentBeacon.minor)
        {
            
            if(_currentBeacon.proximity == beacon.proximity){
                //don't change it
                //get content for beacon
                
            } //same beacon but different proximity
            else{
                
            }
        }
    }
}

/** Tells the delegate that an error occurred while gathering ranging information for a set of beacons. */
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error{
    NSString * log = [NSString stringWithFormat:@"Failed: %@ %s", error, __PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@",log);
    
}

/** Tells the delegate that a new region is being monitored.*/
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    [self.locationManager requestStateForRegion:region];
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    //NSLog(@"%@",log);
    // NSLog(@"%@",region);
    
}

/** Tells the delegate that the delivery of location updates has resumed.*/
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
    NSString * log = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
    [self logMessage:log];
    NSLog(@"%@ %s",log, __PRETTY_FUNCTION__);
    
}




@end
