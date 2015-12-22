//
//  GRBoxView.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRBoxView.h"
#import "GRSetting.h"

@implementation GRBoxView

- (void)setFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = (frame.size.width / [GRSetting columnCount]) * [GRSetting rowCount];
    
    if(height > frame.size.height) {
        width = width * (frame.size.height / height);
        height = frame.size.height;
    }
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, width, height)];
}

@end
