//
//  JMCBeaconManager.h
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCBeaconManager : NSObject

-(void)registerBeaconWithProximityId:(NSString*)pid andIdentifier:(NSString *)identifier major:(int)major andMinor:(int)minor;

-(NSString *)generateID:(NSString *)beaconId andMajor:(NSString *)major andMinor:(NSString *)minor;
@property(nonatomic,strong)UITextView * logView;

@end
