//
//  JMCView.m
//  CoreAnimationFun
//
//  Created by sadmin on 5/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.

#import "JMCView.h"
#import "JMCConstants.h"

#define SUN_RADIUS 50

#define MERKURY_RADIUS 10
#define MERKURY_SUN_DISTANCE 30

#define VENUS_RADIUS 15
#define VENUS_SUN_DISTANCE 40

#define EARTH_RADIUS 17
#define EARTH_SUN_DISTANCE 55

#define MOON_RADIUS 5
#define MOON_EARTH_DISTANCE 10

#define MARS_RADIUS 16
#define MARS_SUN_DISTANCE 70

#define JUPITER_RADIUS 20
#define JUPITER_SUN_DISTANCE 85

#define SATURN_RADIUS 25
#define SATURN_SUN_DISTANCE 105

#define URANUS_RADIUS 25
#define URANUS_SUN_DISTANCE 120

#define NEPTUNE_RADIUS 25
#define NEPTUNE_SUN_DISTANCE 135

#define PLUTO_RADIUS 9
#define PLUTO_SUN_DISTANCE 145

#define ERIS_RADIUS 10
#define ERIS_SUN_DISTANCE 155

@interface JMCView(){
    CGRect merkuryBoundingRect;
    CGRect venusBoundingRect;
    CGRect earthBoundingRect;
    CGRect marsBoundingRect;
    CGRect jupiterBoundingRect;
    CGRect saturnBoundingRect;
    CGRect uranusBoundingRect;
    CGRect neptuneBoundingRect;
    CGRect plutoBoundingRect;
    CGRect erisBoundingRect;
}
@property (nonatomic,strong) UIImageView * sun;
@property (nonatomic,strong) UIImageView * earth;
@property (nonatomic,strong) UIImageView * moon;
@property (nonatomic,strong) UIImageView * mercury;
@property (nonatomic,strong) UIImageView * venus;
@property (nonatomic,strong) UIImageView * mars;
@property (nonatomic,strong) UIImageView * jupiter;
@property (nonatomic,strong) UIImageView * saturn;
@property (nonatomic,strong) UIImageView * uranus;
@property (nonatomic,strong) UIImageView * neptune;
@property (nonatomic,strong) UIImageView * pluto;
@property (nonatomic,strong) UIImageView * eris;


@end

@implementation JMCView
    BOOL _displayed = false;

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

- (void)drawRect:(CGRect)rect
{
    if (!_displayed){
        [self animatePlanets];
    }
    _displayed = YES;
    
    
    CATransform3D t = CATransform3DIdentity;
    t = CATransform3DRotate(t, 20.0f * M_PI / 180.0f, 1, 0, 0);
    
  //  self.layer.transform = t;


    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor]CGColor]);
    CGContextStrokeEllipseInRect(context, earthBoundingRect);
    CGContextStrokeEllipseInRect(context, merkuryBoundingRect);
    CGContextStrokeEllipseInRect(context, venusBoundingRect);
    CGContextStrokeEllipseInRect(context, marsBoundingRect);
    CGContextStrokeEllipseInRect(context, jupiterBoundingRect);
    
    CGContextStrokeEllipseInRect(context, saturnBoundingRect);
    CGContextStrokeEllipseInRect(context, uranusBoundingRect);
    CGContextStrokeEllipseInRect(context, neptuneBoundingRect);
    CGContextStrokeEllipseInRect(context, plutoBoundingRect);
    CGContextStrokeEllipseInRect(context, erisBoundingRect);
    
}


-(CGFloat)convertToLocal:(CGFloat)coords{
    //maxium distance is eris
    //
    
    
    return  0;
}


-(void)animatePlanets{
    [self animateSun];
  
   

    _mercury= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mercury"]];
    _venus= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Venus"]];
    _mars= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mars"]];
    _jupiter= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Jupiter"]];
    _saturn= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Saturn"]];
    _neptune= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Neptune"]];
    _uranus= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Uranus"]];
    _pluto= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Pluto"]];
    _eris= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Eris"]];
    _earth = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Earth"]];
    
   
    
    earthBoundingRect = CGRectMake(_sun.center.x- EARTH_SUN_DISTANCE, _sun.center.y - EARTH_SUN_DISTANCE,  2*EARTH_SUN_DISTANCE, 2* EARTH_SUN_DISTANCE);
    
    merkuryBoundingRect = CGRectMake(self.center.x- MERKURY_SUN_DISTANCE, self.center.y - MERKURY_SUN_DISTANCE,  2*MERKURY_SUN_DISTANCE, 2*MERKURY_SUN_DISTANCE);
    
    venusBoundingRect = CGRectMake(self.center.x- VENUS_SUN_DISTANCE, self.center.y - VENUS_SUN_DISTANCE,  2*VENUS_SUN_DISTANCE, 2*VENUS_SUN_DISTANCE);
    marsBoundingRect = CGRectMake(self.center.x- MARS_SUN_DISTANCE, self.center.y - MARS_SUN_DISTANCE,  2*MARS_SUN_DISTANCE, 2*MARS_SUN_DISTANCE);
    jupiterBoundingRect = CGRectMake(self.center.x- JUPITER_SUN_DISTANCE, self.center.y - JUPITER_SUN_DISTANCE,  2*JUPITER_SUN_DISTANCE, 2*JUPITER_SUN_DISTANCE);
    
    saturnBoundingRect = CGRectMake(self.center.x- SATURN_SUN_DISTANCE, self.center.y - SATURN_SUN_DISTANCE,  2*SATURN_SUN_DISTANCE, 2*SATURN_SUN_DISTANCE);
    
    uranusBoundingRect = CGRectMake(self.center.x- URANUS_SUN_DISTANCE, self.center.y - URANUS_SUN_DISTANCE,  2*URANUS_SUN_DISTANCE, 2*URANUS_SUN_DISTANCE);
    
    neptuneBoundingRect = CGRectMake(self.center.x- NEPTUNE_SUN_DISTANCE, self.center.y - NEPTUNE_SUN_DISTANCE,  2*NEPTUNE_SUN_DISTANCE, 2*NEPTUNE_SUN_DISTANCE);
    
    plutoBoundingRect = CGRectMake(self.center.x- PLUTO_SUN_DISTANCE, self.center.y - PLUTO_SUN_DISTANCE,  2*PLUTO_SUN_DISTANCE, 2*PLUTO_SUN_DISTANCE);
    
    erisBoundingRect = CGRectMake(self.center.x- ERIS_SUN_DISTANCE, self.center.y - ERIS_SUN_DISTANCE,  2*ERIS_SUN_DISTANCE, 2*ERIS_SUN_DISTANCE);
    
    [self animateObject:_mercury duration:12 boundingRect:merkuryBoundingRect key:@"Mercury" radius:MERKURY_RADIUS];
    [self animateObject:_earth duration:14 boundingRect:earthBoundingRect key:@"Earth" radius:EARTH_RADIUS];
    
    [self animateObject:_venus duration:11 boundingRect:venusBoundingRect key:@"Venus" radius:VENUS_RADIUS];
    [self animateObject:_mars duration:10 boundingRect:marsBoundingRect key:@"Mars" radius:MARS_RADIUS];
    [self animateObject:_jupiter duration:12 boundingRect:jupiterBoundingRect key:@"Jupiter" radius:JUPITER_RADIUS];
    [self animateObject:_saturn duration:13 boundingRect:saturnBoundingRect key:@"Saturn" radius:SATURN_RADIUS];
    [self animateObject:_uranus duration:15 boundingRect:uranusBoundingRect key:@"Uranus" radius:URANUS_RADIUS];
    [self animateObject:_neptune duration:14 boundingRect:neptuneBoundingRect key:@"Neptune" radius:NEPTUNE_RADIUS];
    [self animateObject:_pluto duration:17 boundingRect:plutoBoundingRect key:@"Pluto" radius:PLUTO_RADIUS];
    [self animateObject:_eris duration:19 boundingRect:erisBoundingRect key:@"Eris" radius:ERIS_RADIUS];
    [self animateMoon];
    
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
    orbit.rotationMode=kCAAnimationRotateAutoReverse;
}



-(void)animateMoon{
    _moon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Moon"]];
    _moon.frame = CGRectMake(0, 0, MOON_RADIUS, MOON_RADIUS);
    
    CGRect boundingRect = CGRectMake(_earth.center.x- MOON_EARTH_DISTANCE, _earth.center.y - MOON_EARTH_DISTANCE,  2*MOON_EARTH_DISTANCE, 2* MOON_EARTH_DISTANCE);
    
    [self.earth.layer addSublayer:_moon.layer];
    
    NSLog(@"%@ %@",_earth, _moon);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
   
     _moon.layer.anchorPoint = CGPointMake(1, 1);
    [_moon.layer addAnimation:orbit forKey:@"orbit"];
    
    
    
    
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
    int k = arc4random()%4;
    if(k<2)
    {
        orbit.speed =-1;
    }
    else{
        orbit.speed =1;
    }
    
    [object.layer addAnimation:orbit forKey:key];
    
}






@end
