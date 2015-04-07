//
//  FWAnalogClock.m
//  BedsideClock
//
//  Created by Charles Childers on 2/25/14.
//  Copyright (c) 2014 Charles Childers. All rights reserved.
//

#import "FWAnalogClock.h"

@implementation FWAnalogClock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)updateTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh"];
    NSString *hour = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"Hour: %@", hour);
    [self setHour:[hour floatValue]];

    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"mm"];
    NSString *minute = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"Minute: %@", minute);
    [self setMinute:[minute floatValue]];
}


- (CGPoint)findCenter
{
    CGPoint center;
    center.x = [self bounds].origin.x + [self bounds].size.width / 2.0;
    center.y = [self bounds].origin.y + [self bounds].size.height / 2.0;
    return center;
}


- (void)drawClockFrame:(CGContextRef) ctx  frameColor:(UIColor *) frameColor  markerColor:(UIColor *) markerColor
{
    CGPoint center = [self findCenter];
    float maxRadius = hypot([self bounds].size.width, [self bounds].size.height) / 4.0;
    
    // Outer Frame
    CGContextSetLineWidth(ctx, 10);
    [[frameColor colorWithAlphaComponent:0.35] set];
    CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
    CGContextStrokePath(ctx);
    
    // Draw Hour indicators
    float theta = 0;
    float distance = maxRadius * 0.9;
    
    [[markerColor colorWithAlphaComponent:0.35] set];
    CGContextSetLineWidth(ctx, 5.0);
    
    for(int i = 0; i < 12; i++) {
        theta = theta + (30 * M_PI / 180);
        float x = center.x + distance * cos(theta);
        float y = center.y + distance * sin(theta);
        
        CGContextAddArc(ctx, x, y, maxRadius / 80, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(ctx);
    }
}

- (void)drawHand:(CGContextRef) ctx  from:(float) x  to:(float) y  width:(float) width
{
    CGPoint center = [self findCenter];
    CGContextSetLineWidth(ctx, width);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, x, y);
    CGContextStrokePath(ctx);
}


- (void)drawHourHand:(CGContextRef) ctx  withColor:(UIColor *) color
{
    [[UIColor darkGrayColor] set];
    CGPoint center = [self findCenter];
    float length = [self bounds].size.width / 5;
    float theta = (30 * M_PI / 180);
    float x = center.x + length * cos((([self hour] + [self minute]/60 + 1/3600) * theta) - M_PI/2);
    float y = center.y + length * sin((([self hour] + [self minute]/60 + 1/3600) * theta) - M_PI/2);
    [self drawHand:ctx from:x to:y width:5.0];
}


- (void)drawMinuteHand:(CGContextRef) ctx  withColor:(UIColor *) color
{
    [color set];
    CGPoint center = [self findCenter];
    float length = [self bounds].size.width / 3;
    float theta = (6 * M_PI / 180);
    float x = center.x + length * cos((([self minute] + 1/60) * theta) - M_PI/2);
    float y = center.y + length * sin((([self minute] + 1/60) * theta) - M_PI/2);
    [self drawHand:ctx from:x to:y width:5.0];
}


- (void)drawRect:(CGRect)dirty
{
    NSLog(@"Updating...");
    [self updateTime];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawClockFrame:ctx frameColor:[UIColor grayColor] markerColor:[UIColor grayColor]];
    [self drawHourHand:ctx withColor:[UIColor darkGrayColor]];
    [self drawMinuteHand:ctx withColor:[UIColor grayColor]];
}

@end

