//
//  GRCropAssistView.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRCropAssistView.h"
#import "GRBoxView.h"

@interface GRCropAssistView ()
{
    GRBoxView *_boxView;
}
@end

@implementation GRCropAssistView

- (CGFloat)borderWidth
{
    return 1.0 / [[UIScreen mainScreen] scale];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        _boxView = [[GRBoxView alloc] initWithFrame:self.bounds];
        _boxView.layer.borderColor = [UIColor whiteColor].CGColor;
        _boxView.layer.borderWidth = [self borderWidth];
        _boxView.userInteractionEnabled = NO;
        [self addSubview:_boxView];
        [_boxView release];
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(), _boxView.frame);
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _boxView.frame = self.bounds;
    _boxView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    NSSet *allTouches = [event allTouches];
    
    if(allTouches.count == 1) {
        CGPoint currentPoint = [[allTouches allObjects][0] locationInView:self];
        CGPoint previousPoint = [[allTouches allObjects][0] previousLocationInView:self];
        
        _boxView.center =
        [self boxViewCenterWithPoint:CGPointMake(_boxView.center.x + (currentPoint.x - previousPoint.x),
                                                 _boxView.center.y + (currentPoint.y - previousPoint.y))];
        
        [self setNeedsDisplay];
    }
    else if(allTouches.count == 2) {
        CGPoint currentPoint[2], previousPoint[2];
        
        currentPoint[0] = [[allTouches allObjects][0] locationInView:self];
        currentPoint[1] = [[allTouches allObjects][1] locationInView:self];
        
        previousPoint[0] = [[allTouches allObjects][0] previousLocationInView:self];
        previousPoint[1] = [[allTouches allObjects][1] previousLocationInView:self];
        
        CGFloat currentLength = [self distanceWithPoint1:currentPoint[0] point2:currentPoint[1]];
        CGFloat previousLength = [self distanceWithPoint1:previousPoint[0] point2:previousPoint[1]];
        
        CGFloat scaleFactor = currentLength / previousLength;

        CGPoint oldCenter = _boxView.center;
        CGSize newSize = CGSizeMake(MAX(30, MIN(_boxView.frame.size.width * scaleFactor, self.bounds.size.width)),
                                    MAX(10, MIN(_boxView.frame.size.height * scaleFactor, self.bounds.size.height)));

        _boxView.frame = CGRectMake(oldCenter.x - newSize.width / 2, oldCenter.y - newSize.height / 2,
                                    newSize.width, newSize.height);
        _boxView.center = [self boxViewCenterWithPoint:_boxView.center];
        
        [self setNeedsDisplay];
    }
}

- (CGPoint)boxViewCenterWithPoint:(CGPoint)p
{
    CGFloat x = MIN(MAX(_boxView.frame.size.width / 2, p.x), self.bounds.size.width - _boxView.frame.size.width / 2);
    CGFloat y = MIN(MAX(_boxView.frame.size.height / 2, p.y), self.bounds.size.height - _boxView.frame.size.height / 2);

    return CGPointMake(x, y);
}

- (CGFloat)distanceWithPoint1:(CGPoint)p1 point2:(CGPoint)p2
{
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}

- (CGRect)cropRect
{
    return _boxView.frame;
//    return CGRectMake(round(_boxView.frame.origin.x),
//                      round(_boxView.frame.origin.y),
//                      round(_boxView.frame.size.width),
//                      round(_boxView.frame.size.height));
}

@end
