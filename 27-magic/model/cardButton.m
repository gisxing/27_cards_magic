//
//  cardButton.m
//  27-magic
//
//  Created by gisxing on 14-1-9.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "cardButton.h"
#import "Common.h"
#include <math.h>


@interface cardButton()
    


@end
@implementation cardButton

#define LABEL_HEIGHT 20

- (NSString *)contents {
    if (!_contents) _contents = @"magic";
    return _contents;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Get width of button
        [self commonInit];
    }
    return self;
}

-(void) commonInit{
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    _hue = 0.5;
    _saturation = 0.5;
    _brightness = 0.5;
    
    
    
    // handle a lable on it
    double buttonWidth = self.frame.size.width;
    double buttonHeight = self.frame.size.height;
    
    // Initialize buttonLabel
    self.labelTop = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, buttonWidth - 20, LABEL_HEIGHT)];
    self.labelBottom = [[UILabel alloc] initWithFrame:CGRectMake(10, buttonHeight - 10 - LABEL_HEIGHT, buttonWidth - 20, LABEL_HEIGHT)];
    
    self.labelTop.backgroundColor = [UIColor clearColor];
    self.labelBottom.backgroundColor = [UIColor clearColor];
    
    self.labelTop.font =  [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:11.0];
    self.labelBottom.font =  [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:11.0];
    
    self.labelTop.text = self.contents;
    self.labelBottom.text = self.contents;
    
    self.labelTop.textColor = [UIColor blackColor];
    self.labelBottom.textColor = [UIColor blackColor];
    
    self.labelBottom.textAlignment = NSTextAlignmentLeft;
    self.labelBottom.transform = CGAffineTransformMakeRotation(M_PI);
    [self addSubview:self.labelTop];
    [self addSubview:self.labelBottom];

}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        
        [self commonInit];
        //self.transform = CGAffineTransformMakeRotation(M_PI/2);
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{

    
    CGFloat actualBrightness = self.brightness;
    if (self.state == UIControlStateHighlighted) {
        actualBrightness -= 0.10;
    }
    
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *  blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor *  highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    UIColor *  highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    UIColor *  shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    // self.brightness is now acutalBrightness
    UIColor * outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*actualBrightness alpha:1.0];
    UIColor * outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.80*actualBrightness alpha:1.0];
    UIColor * innerStroke = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.80*actualBrightness alpha:1.0];
    UIColor * innerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.90*actualBrightness alpha:1.0];
    UIColor * innerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.70*actualBrightness alpha:1.0];
    
    CGFloat outerMargin = 5.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
    
    CGFloat innerMargin = 3.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 6.0);
    
    CGFloat highlightMargin = 2.0f;
    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, outerTop.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, outerPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, outerRect, outerTop.CGColor, outerBottom.CGColor);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, innerRect, innerTop.CGColor, innerBottom.CGColor);
    CGContextRestoreGState(context);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 4.0);
        CGContextAddPath(context, outerPath);
        CGContextAddPath(context, highlightPath);
        CGContextEOClip(context);
        drawLinearGradient(context, outerRect, highlightStart.CGColor, highlightStop.CGColor);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, innerStroke.CGColor);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
    CFRelease(highlightPath);
    
    
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.657 green: 0.438 blue: 0 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.886 green: 0 blue: 0.295 alpha: 1];
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(2.1, 7.1);
    CGFloat shadowBlurRadius = 5;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.41, 7.97)];
    [bezierPath addCurveToPoint: CGPointMake(17.1, 6.95) controlPoint1: CGPointMake(5.07, -2.54) controlPoint2: CGPointMake(10.7, -2.34)];
    [bezierPath addCurveToPoint: CGPointMake(34.58, 48.72) controlPoint1: CGPointMake(22.64, 15) controlPoint2: CGPointMake(28.55, 29.54)];
    [bezierPath addCurveToPoint: CGPointMake(43.99, 82.16) controlPoint1: CGPointMake(37.92, 59.36) controlPoint2: CGPointMake(41.09, 70.76)];
    [bezierPath addCurveToPoint: CGPointMake(46.7, 93.19) controlPoint1: CGPointMake(45.01, 86.16) controlPoint2: CGPointMake(45.91, 89.86)];
    [bezierPath addCurveToPoint: CGPointMake(47.43, 96.28) controlPoint1: CGPointMake(46.98, 94.36) controlPoint2: CGPointMake(47.22, 95.39)];
    [bezierPath addCurveToPoint: CGPointMake(47.68, 97.39) controlPoint1: CGPointMake(47.55, 96.82) controlPoint2: CGPointMake(47.63, 97.19)];
    [bezierPath addLineToPoint: CGPointMake(47.43, 104.97)];
    [bezierPath addCurveToPoint: CGPointMake(47.19, 103.89) controlPoint1: CGPointMake(47.39, 104.78) controlPoint2: CGPointMake(47.31, 104.42)];
    [bezierPath addCurveToPoint: CGPointMake(46.47, 100.82) controlPoint1: CGPointMake(46.98, 103.01) controlPoint2: CGPointMake(46.74, 101.98)];
    [bezierPath addCurveToPoint: CGPointMake(43.77, 89.85) controlPoint1: CGPointMake(45.68, 97.51) controlPoint2: CGPointMake(44.78, 93.83)];
    [bezierPath addCurveToPoint: CGPointMake(34.4, 56.55) controlPoint1: CGPointMake(40.89, 78.5) controlPoint2: CGPointMake(37.73, 67.15)];
    [bezierPath addCurveToPoint: CGPointMake(17.01, 15) controlPoint1: CGPointMake(28.4, 37.47) controlPoint2: CGPointMake(22.52, 23)];
    [bezierPath addCurveToPoint: CGPointMake(0.54, 15.93) controlPoint1: CGPointMake(10.68, 5.81) controlPoint2: CGPointMake(5.12, 5.61)];
    [bezierPath addLineToPoint: CGPointMake(0.41, 7.97)];
    [bezierPath closePath];
    bezierPath.miterLimit = 14;
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
    
    [color2 setStroke];
    bezierPath.lineWidth = 0.5;
    [bezierPath stroke];
    
    

    
}

-(void) setHue:(CGFloat)hue
{
    _hue = hue;
    [self setNeedsDisplay];
}

-(void) setSaturation:(CGFloat)saturation
{
    _saturation = saturation;
    [self setNeedsDisplay];
}

-(void) setBrightness:(CGFloat)brightness
{
    _brightness = brightness;
    [self setNeedsDisplay];
}

- (void)hesitateUpdate
{
    [self setNeedsDisplay];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
