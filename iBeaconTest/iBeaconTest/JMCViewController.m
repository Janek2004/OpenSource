//
//  JMCViewController.m
//  iBeaconTest
//
//  Created by sadmin on 2/21/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//

#import "JMCViewController.h"
#import "JMCBeaconManager.h"

//the main id of the beacon in the production version we will need to keep reference to this number in some kind of online database

#define BEACONID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
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

    //Registering the region
    [_manager registerBeaconWithProximityId:BEACONID andIdentifier:@"Beacon Identifier 1" major:1 andMinor:1];
    
 
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
