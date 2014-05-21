//
//  JMCViewController.m
//  CoreAnimationFun
//
//  Created by sadmin on 5/20/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCViewController.h"

@interface JMCViewController ()
@property (nonatomic,strong) UIImageView * sun;
@property (nonatomic,strong) UIImageView * earth;
@property (nonatomic,strong) UIImageView * moon;
@property (nonatomic,strong) UIImageView * mercury;


@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self animatePlanets];
}


-(void)animatePlanets{
    self.view.backgroundColor = [UIColor blackColor];
    _sun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Sun"]];
    _sun.frame = CGRectMake(0, 0, 75, 75);
    _sun.center =  self.view.center;
    
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
   // _sun.layer.anchorPoint = CGPointMake(CGRectGetHeight(_sun.frame)/2.0, CGRectGetWidth(_sun.frame)/2.0);

    float x = CGRectGetMidX(self.view.frame);
    float y = CGRectGetMidY(self.view.frame);
    
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(x,y,75,75), NULL));
    orbit.duration = 15;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
    [self.view addSubview:_sun];
    [self animateEarth];
    [self animateMoon];
}


-(void)animateMercury{
    _mercury= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mercury"]];
    
    CGRect boundingRect = CGRectMake(_sun.center.x- 80, _sun.center.y - 80, 160, 160);
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
    [_moon.layer addAnimation:orbit forKey:@"orbit"];
}


-(void)animateMoon{
    _moon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Moon"]];
    _moon.frame = CGRectMake(0, 0, 10, 10);
    
    CGRect boundingRect = CGRectMake(_earth.center.x- 30, _earth.center.y - 30, 60, 60);
    [self.earth.layer addSublayer:_moon.layer];
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
    [_moon.layer addAnimation:orbit forKey:@"orbit"];
}


-(void)animateEarth{
    _earth = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Earth"]];
    _earth.frame = CGRectMake(0, 0, 50, 50);
  
    CGRect boundingRect = CGRectMake(_sun.center.x- 100, _sun.center.y - 100, 200, 200);
    [self.view addSubview:_earth];
    
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 6;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
    [_earth.layer addAnimation:orbit forKey:@"orbit"];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
