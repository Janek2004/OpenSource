//
// Created by Terry Lewis II on 2/8/14.
// Copyright (c) 2014 Terry Lewis. All rights reserved.
//

#import "JMCAnnotationView.h"

@interface JMCAnnotationView ()
@property(nonatomic, strong) UILabel *numberLabel;
@end

@implementation JMCAnnotationView
@synthesize centerOffset = _centerOffset;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if(!self) {
        return nil;
    }
    self.frame = CGRectMake(0, 0, 40, 38);
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
  
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    UIGraphicsGetCurrentContext();
    //// Color Declarations
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 0.114 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 1 green: 0.781 blue: 0.343 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.862 green: 0.279 blue: 0.279 alpha: 1];
    
    //// Abstracted Attributes
    NSString* textContent = self.annotation.title;
    
    //// Star Drawing
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(20.5, 0.5)];
    [starPath addLineToPoint: CGPointMake(27.55, 10.79)];
    [starPath addLineToPoint: CGPointMake(39.52, 14.32)];
    [starPath addLineToPoint: CGPointMake(31.91, 24.21)];
    [starPath addLineToPoint: CGPointMake(32.26, 36.68)];
    [starPath addLineToPoint: CGPointMake(20.5, 32.5)];
    [starPath addLineToPoint: CGPointMake(8.74, 36.68)];
    [starPath addLineToPoint: CGPointMake(9.09, 24.21)];
    [starPath addLineToPoint: CGPointMake(1.48, 14.32)];
    [starPath addLineToPoint: CGPointMake(13.45, 10.79)];
    [starPath closePath];
    [color setFill];
    [starPath fill];
    [color2 setStroke];
    starPath.lineWidth = 1;
    [starPath stroke];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(12, 14, 18, 11);
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [textStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 11.5], NSForegroundColorAttributeName: color3, NSParagraphStyleAttributeName: textStyle};
    
    [textContent drawInRect: textRect withAttributes: textFontAttributes];
    
}


- (void)setCenterOffset:(CGPoint)centerOffset {
    _centerOffset = centerOffset;
}

@end