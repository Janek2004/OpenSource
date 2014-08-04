//
//  JMCBeaconManager.h
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
/**
 *  Class that can be used to monitor nearby beacons. To use it you should follow the steps:
 1. Check if beacons are supported calling isSupported method
 2. Register regions to monitor
 3. Specify beaconFound block to monitor beacons.
*/
@interface JMCBeaconManager : NSObject

/**
*  Description:  Registers beacons using major and minor identifier
*
*  @param pid        beacon identifier used internally
*  @param identifier beacon identifier
*  @param major      major identifier
*  @param minor      minor identifier
*/
-(void)registerBeaconWithProximityId:(NSString*)pid andIdentifier:(NSString *)identifier major:(int)major andMinor:(int)minor;

/**
 *  Generates unique ID
 *
 *  @param beaconId beacon identifier
 *  @param major    beacon major
 *  @param minor    beacon minor
 *
 *  @return returns string with unique identifier
 */
-(NSString *)generateID:(NSString *)beaconId andMajor:(NSString *)major andMinor:(NSString *)minor;

/**
 *  Checks if beacon is supported
 *
 *  @param message string that will contain message about problems with supporting the beacons
 *
 *  @return boolean that indicates if device supports beacons or not
 */
-(BOOL)isSupported:(NSMutableString*)message;

/**
 *  View used for loggin the events
 */
@property(nonatomic,strong)UITextView * logView;
/**
 *  Block used for monitoring and processing the beacons 
 */
@property(nonatomic, copy) void (^beaconFound)(int major, int minor, CLProximity proximity);

/**
 *  Block used for monitoring region events
 */
@property(nonatomic, copy) void (^regionEvent)(int major, int minor, BOOL entered);

@end
