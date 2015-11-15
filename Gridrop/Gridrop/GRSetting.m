//
//  GRSetting.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRSetting.h"

@implementation GRSetting

+ (NSUInteger)gridCount
{
    return [self rowCount] * [self columnCount];
}

+ (NSUInteger)rowCount
{
    return 1;
}

+ (NSUInteger)columnCount
{
    return 3;
}

@end
