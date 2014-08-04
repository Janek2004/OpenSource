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



@interface JMCViewController ()
@property (strong, nonatomic) IBOutlet UITextView *logTextView;
@property (nonatomic,strong) JMCBeaconManager * beaconManager;
@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  //  _beaconManager = [JMCBeaconManager new];
 //   _beaconManager.logView = self.logTextView;

    //Registering the region
   //[_manager registerBeaconWithProximityId:BEACONID andIdentifier:@"ATC BEA" major:-1 andMinor:-1];

   }





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
