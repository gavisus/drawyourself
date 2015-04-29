//
//  AZDrawView.m
//  drawyourself
//
//  Created by Jung Kim on 12. 10. 8..
//  Copyright (c) 2012년 AuroraPlanet. All rights reserved.
//

#import "AZDrawView.h"

@interface AZDrawView ()
{
    NSArray *colorArray;
    CGContextRef cgContext;
    unsigned char colorIndex;
    NSMutableArray *pointArray;
    unsigned int drawCount;
}

@end

@implementation AZDrawView


- (void)initialize
{
    UIColor *color1 = [UIColor colorWithRed:0x3E/255.0 green:0xFF/255.0 blue:0x80/255.0 alpha:0xFF/255.0];
    UIColor *color2 = [UIColor colorWithRed:0xEB/255.0 green:0xFF/255.0 blue:0x25/255.0 alpha:0xFF/255.0];
    UIColor *color3 = [UIColor colorWithRed:0x70/255.0 green:0xFF/255.0 blue:0xFE/255.0 alpha:0xFF/255.0];
    colorArray = [NSArray arrayWithObjects:color1, color2, color3, nil];
    colorIndex = 0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(NULL, self.frame.size.width, self.frame.size.height, 8, 4*self.frame.size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    
    CGContextSetLineWidth(cgContext, 25);
    CGContextSetLineCap(cgContext, kCGLineCapRound);
    CGContextSetRGBStrokeColor(cgContext, 1.0, 1.0, 1.0, 1.0);
    
    pointArray = [[NSMutableArray alloc] initWithCapacity:10];
    drawCount = 0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialize];

}

- (void)timerFire:(NSTimer*)timer
{
    [self setNeedsDisplay];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
#if 0
    UITouch *touch;
    
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:10];
    for (touch in touches)
    {
        [newArray addObject:touch];
    }
    [pointArray addObject:newArray];
#endif
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch;

#if 0
    NSMutableArray *newArray = [pointArray objectAtIndex:pointArray.count-1];
    for (touch in touches)
    {
        [newArray addObject:touch];
    }
#endif
    
#if 1
    for (touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        CGPoint prevLocation = [touch previousLocationInView:self];
        CGContextMoveToPoint(cgContext, prevLocation.x, prevLocation.y);
        CGContextAddLineToPoint(cgContext, location.x, location.y);
        CGContextStrokePath(cgContext);
        NSLog(@"point[%d] %@", drawCount, NSStringFromCGPoint(location) );
        drawCount++;
    }
//    if (drawCount%5==0)
    {
        [self setNeedsDisplay];
    }
//    NSLog(@"setNeedsDisplay %d", drawCount);
#endif
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
#if 0

    UITouch *touch;
    int nIndex;
    CGPoint location;
    NSMutableArray *newArray;
    
    CGContextSetLineWidth(context, 25);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);

    for(newArray in pointArray)
    {
        nIndex = 0;
        CGContextBeginPath(context);
        for(touch in newArray)
        {
            location = [touch locationInView:self];
            
            if (nIndex==0)
            {
                CGContextMoveToPoint(context, location.x, location.y);
            }
            else
            {
                CGContextAddLineToPoint(context, location.x, location.y);
                CGContextMoveToPoint(context, location.x, location.y);
            }
            nIndex++;
        }
        CGContextStrokePath(context);
    }
#endif
    
#if 1
    CGRect bounds = [self bounds];
    CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
    CGImageRef image = CGBitmapContextCreateImage(cgContext);
    CGContextDrawImage(context, bounds, image);
    CGImageRelease(image);
#endif
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventSubtypeMotionShake)
    {
        //
        CGContextClearRect(cgContext, [self bounds]);
        //
        UIColor *selected = [colorArray objectAtIndex:rand()%[colorArray count]];
        CGFloat r,g,b;
        [selected getRed:&r green:&g blue:&b alpha:NULL];
        CGContextSetRGBStrokeColor(cgContext, r, g, b, 1);
        [self setNeedsDisplay];
    }
}

@end
