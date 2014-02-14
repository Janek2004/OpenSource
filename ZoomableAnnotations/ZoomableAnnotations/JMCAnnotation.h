//
// Created by Terry Lewis II on 2/8/14.
// Copyright (c) 2014 Terry Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface JMCAnnotation : NSObject <MKAnnotation>
- (instancetype)initWithTitle:(NSString*)title andLocation:(CLLocation *)location;
@property(nonatomic, readonly) CLLocation *location;


@end