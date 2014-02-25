//
//  JMCViewController.m
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//

#import "JMCViewController.h"
#import "JMCBeaconManager.h"
#define BEACONID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define MAJOR_ID @"10000"
#define GREEN_MINOR @"1"


@interface JMCViewController ()
@property (strong, nonatomic) IBOutlet UITextView *logTextView;
@property (nonatomic,strong) JMCBeaconManager * manager;
@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _manager = [[JMCBeaconManager alloc]init];
    _manager.logView = self.logTextView;
    //get identifier
    NSString * greenBeacon = [_manager generateID:BEACONID andMajor:MAJOR_ID andMinor:GREEN_MINOR];
    [_manager registerBeaconWithProximityId:BEACONID andIdentifier:greenBeacon];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
