//
//  CellGradientLayer.m
//  ConciseNote
//
//  Created by han pyanfield on 12-1-3.
//  Copyright (c) 2012年 pyanfield. All rights reserved.
//

#import "CellGradientLayer.h"

@implementation CellGradientLayer

- (id)init
{
    if (self = [super init]) {
        UIColor *colorOne		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:1.0 alpha:1.0];
		UIColor *colorTwo		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
		UIColor *colorThree	        = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
		UIColor *colorFour		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
        
        NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
        
		self.colors = colors;	
		
        
		NSNumber *stopOne		= [NSNumber numberWithFloat:0.0];
		NSNumber *stopTwo		= [NSNumber numberWithFloat:0.02];
		NSNumber *stopThree	        = [NSNumber numberWithFloat:0.98];
		NSNumber *stopFour		= [NSNumber numberWithFloat:1.0];
		
		NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
		
		self.locations = locations;
        
		self.startPoint = CGPointMake(0.5, 0.0);		
		self.endPoint = CGPointMake(0.5, 1.0);
    }
    
    return self;
}

@end
