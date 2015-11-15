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
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y,
                               frame.size.width, (frame.size.width / [GRSetting columnCount]) * [GRSetting rowCount])];
}

@end
