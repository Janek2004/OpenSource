//
//  JMCView.m
//  CoreAnimationFun
//
//  Created by sadmin on 5/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCView.h"
#import "JMCConstants.h"

#define SUN_RADIUS 50

#define MERKURY_RADIUS 10
#define MERKURY_SUN_DISTANCE 30

#define VENUS_RADIUS 15
#define VENUS_SUN_DISTANCE 45

#define EARTH_RADIUS 25
#define EARTH_SUN_DISTANCE 65

#define MOON_RADIUS 5
#define MOON_EARTH_DISTANCE 12




@interface JMCView(){
    CGRect merkuryBoundingRect;
    CGRect venusBoundingRect;
    CGRect earthBoundingRect;
    
}
@property (nonatomic,strong) UIImageView * sun;
@property (nonatomic,strong) UIImageView * earth;
@property (nonatomic,strong) UIImageView * moon;
@property (nonatomic,strong) UIImageView * mercury;
@property (nonatomic,strong) UIImageView * venus;
@end

@implementation JMCView


-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[super init];
    if(self){
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    [self animatePlanets];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor]CGColor]);
    CGContextStrokeEllipseInRect(context, earthBoundingRect);
    CGContextStrokeEllipseInRect(context, merkuryBoundingRect);
    CGContextStrokeEllipseInRect(context, venusBoundingRect);
    
}

-(void)animatePlanets{
    [self animateSun];
    [self animateEarth];
    [self animateMoon];

    _mercury= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mercury"]];
    _venus= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Venus"]];
    
    merkuryBoundingRect = CGRectMake(self.center.x- MERKURY_SUN_DISTANCE, self.center.y - MERKURY_SUN_DISTANCE,  2*MERKURY_SUN_DISTANCE, 2*MERKURY_SUN_DISTANCE);
    
    venusBoundingRect = CGRectMake(self.center.x- VENUS_SUN_DISTANCE, self.center.y - VENUS_SUN_DISTANCE,  2*VENUS_SUN_DISTANCE, 2*VENUS_SUN_DISTANCE);
    
    [self animateObject:_mercury duration:8 boundingRect:merkuryBoundingRect key:@"Mercury" radius:MERKURY_RADIUS];
    
    [self animateObject:_venus duration:7 boundingRect:venusBoundingRect key:@"Venus" radius:VENUS_RADIUS];
    

}

-(void)animateSun{
    _sun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Sun"]];
    _sun.frame = CGRectMake(0, 0, SUN_RADIUS, SUN_RADIUS);
    _sun.center =  self.center;
    
    [self addSubview:_sun];
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"rotation";
    
    float x = CGRectGetMidX(self.frame);
    float y = CGRectGetMidY(self.frame);
    
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(x,y, SUN_RADIUS, SUN_RADIUS), NULL));
    orbit.duration = 1;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
    //[self.sun.layer addAnimation:orbit forKey:@"sun"];
}

-(void)animateMercury{
    
    
    CGRect boundingRect = CGRectMake(_sun.center.x- 80, _sun.center.y - 80, 160, 160);
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
    [_mercury.layer addAnimation:orbit forKey:@"orbit"];
}


-(void)animateMoon{
    _moon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Moon"]];
    _moon.frame = CGRectMake(0, 0, MOON_RADIUS, MOON_RADIUS);
    
    CGRect boundingRect = CGRectMake(_earth.center.x- MOON_EARTH_DISTANCE, _earth.center.y - MOON_EARTH_DISTANCE,  2*MOON_EARTH_DISTANCE, 2* MOON_EARTH_DISTANCE);
    
    [self.earth.layer addSublayer:_moon.layer];
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode=kCAAnimationRotateAuto;
    
     _moon.layer.anchorPoint = CGPointMake(1, 1);
    
    [_moon.layer addAnimation:orbit forKey:@"orbit"];
}


-(void)animateEarth{
    _earth = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Earth"]];
    _earth.frame = CGRectMake(0, 0, EARTH_RADIUS, EARTH_RADIUS);
    earthBoundingRect = CGRectMake(_sun.center.x- EARTH_SUN_DISTANCE, _sun.center.y - EARTH_SUN_DISTANCE,  2*EARTH_SUN_DISTANCE, 2* EARTH_SUN_DISTANCE);

    [self addSubview:_earth];
    _earth.layer.anchorPoint = CGPointMake(1, 1);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(earthBoundingRect, NULL));
    orbit.duration = 6;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    
    [_earth.layer addAnimation:orbit forKey:@"orbit"];
    
}

-(void)animateObject:(UIImageView *)object duration:(int)duration boundingRect:(CGRect)boundingRect key:(NSString *)key radius:(float)radius{
    object.frame = CGRectMake(0, 0, radius, radius);
    [self addSubview:object];
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = duration;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    object.layer.anchorPoint = CGPointMake(1, 1);
    
    [object.layer addAnimation:orbit forKey:key];

}






@end
