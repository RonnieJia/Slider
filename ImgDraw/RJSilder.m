//
//  RJSilder.m
//  ImgDraw
//
//  Created by HuaoEAge on 16/3/22.
//  Copyright © 2016年 HuaoEAge. All rights reserved.
//

#import "RJSilder.h"

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

/** Parameters **/
#define TB_SAFEAREA_PADDING 60
#define TB_BACKGROUND_WIDTH 60

@interface RJSilder(){
    UITextField *_textField;
    int radius;
}
@end

@implementation RJSilder

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.angle = 360;
        radius = self.frame.size.width/2-TB_SAFEAREA_PADDING;

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** Draw the Brackground */
    
    // Create the path
    CGContextAddArc(ctx, self.frame.size.width/2.0, self.frame.size.height/2.0, radius, 0, ToRad(self.angle), 0);
    
    // Set the stroke color to black
    [[UIColor blackColor] setStroke];
    
    // Define line width and cap
    CGContextSetLineWidth(ctx, TB_BACKGROUND_WIDTH);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    // Draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
    
/** Draw the circle (using a clipped gradient) */
    
    // Create the Mask Image
    UIGraphicsBeginImageContext(CGSizeMake(320, 320));
    CGContextRef imgCtx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(imgCtx, self.frame.size.width/2.0, self.frame.size.height/2.0, radius, 0, ToRad(self.angle), 0);
    [[UIColor redColor] set];
    
    // Use shadow to create the blur effect
    CGContextSetShadowWithColor(imgCtx, CGSizeZero, self.angle/20, [UIColor blackColor].CGColor);
    
    // difine the path
    CGContextSetLineWidth(imgCtx, 40);
    CGContextDrawPath(imgCtx, kCGPathStroke);
    
    // Save the context content into the image mask
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    /** Clip context to the mask */
    CGContextSaveGState(ctx);
    
    CGContextClipToMask(ctx, self.bounds, mask);
    CGImageRelease(mask);
    
/** THE GRADIENT */
    
    // list of components
    CGFloat components[8] = {0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0};
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, components, NULL, 0);
    CGColorSpaceRelease(baseSpace);
    baseSpace = NULL;
    
    CGContextRestoreGState(ctx);
    
/** Add some light reflection effects on the background circle */
    CGContextSetLineWidth(ctx, 1);
    
    
    
    
}

@end
