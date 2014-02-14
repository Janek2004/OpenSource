//
//  JMCViewController.m
//  ZoomableAnnotations
//
//  Created by sadmin on 2/13/14.
//  Copyright (c) 2014 JanuszChudzynski. All rights reserved.
//

#import "JMCViewController.h"
#import "JMCAnnotation.h"
#import "JMCAnnotationView.h"

@import MapKit;

#define MIN_ZOOM_LEVEL 1
#define MAX_ZOOM_LEVEL  20
#define Identifier @"MapAnnotation"


#define MERCATOR_RADIUS 85445659.44705395



@interface JMCViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic)  NSArray * locations;

@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    

    JMCAnnotation * pcola = [[JMCAnnotation alloc]initWithTitle:@"1" andLocation: [[CLLocation alloc] initWithLatitude:30.4333  longitude:-87.2000]];
    JMCAnnotation * newyork = [[JMCAnnotation alloc]initWithTitle:@"2" andLocation: [[CLLocation alloc] initWithLatitude:40.6700  longitude:-73.9400]];

    self.locations =@[pcola,newyork];
    [self.mapView addAnnotations:self.locations];
    
}

#pragma mark MapKit Delegate
//Getting zoom level of the map http://stackoverflow.com/questions/7594827/how-to-find-current-zoom-level-of-mkmapview
-(MKZoomScale)getZoomLevel{
    CLLocationDegrees longitudeDelta = self.mapView.region.span.longitudeDelta;
    CGFloat mapWidthInPixels = self.mapView.bounds.size.width;
    double zoomScale = longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * mapWidthInPixels);
    double zoomer = MAX_ZOOM_LEVEL - log2( zoomScale );
    if ( zoomer < 0 ) zoomer = 0;
    //  zoomer = round(zoomer);
    return zoomer;


}

//Formatting each of the annotation's views
- (void)formatAnnotationView:(JMCAnnotationView *)pinView forMapView:(MKMapView *)aMapView {
    if(pinView) {
        double zoomLevel = [self getZoomLevel];
        // f(min) = a
        // f(max) = b
        //f(x) = x - min   ===>   f(min) = min - min = 0
        //        (b-a)(x - min)
        //f(x) = --------------  + a
        //         max - min
        
        //min scale value
        double a = 0.65;
        //max scale value
        double b = 2.5;
        
        int min = MIN_ZOOM_LEVEL;
        double max = MAX_ZOOM_LEVEL;
        double scale;
        scale = a + (b - a) * (zoomLevel - 1) * 1.0 / (max - min);
    
        //Applying transformation to the annotations
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
        pinView.transform = scaleTransform;
        
        CGAffineTransform t = CGAffineTransformTranslate(pinView.transform, 0, -pinView.frame.size.height / 2.0);
        pinView.transform = t;
    }
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    for(JMCAnnotation *v in mapView.annotations) {//viewForAnnotation
        if([v isKindOfClass:[MKUserLocation class]]) {
            
        } else {
            JMCAnnotationView *vv = (JMCAnnotationView *)[mapView viewForAnnotation:v];
            [self formatAnnotationView:vv forMapView:mapView];
        }
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    else {
        JMCAnnotationView *view = (JMCAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];
        if(!view) view = [[JMCAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Identifier];
        
        //set's size and location based on zoom level
        [self formatAnnotationView:view forMapView:mapView];
        
        
        return view;
    }
}



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(JMCAnnotationView *)view {
    
}


#pragma mark memory management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
