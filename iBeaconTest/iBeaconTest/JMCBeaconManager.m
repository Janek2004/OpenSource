//
//  JMCBeaconManager.m
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//
@import CoreLocation;

#import "JMCBeaconManager.h"

@implementation JMCBeaconManager


// Create a beacon identifier using uuidgen

-(void)registerBeaconWithProximityId:(NSString*)pid andIdentifier:(NSString *)identifier{
    NSUUID *proximityUUID = [[NSUUID alloc]
                             initWithUUIDString:pid];
    
    // Create the beacon region.
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
                                    initWithProximityUUID:proximityUUID
                                    identifier:identifier];

}

@end
