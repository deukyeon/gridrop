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

static NSUInteger _rowCount = 1;
+ (NSUInteger)rowCount
{
    return _rowCount;
}

+ (void)setRowCount:(NSUInteger)rowCount
{
    _rowCount = rowCount;
}

static NSUInteger _columnCount = 3;
+ (NSUInteger)columnCount
{
    return _columnCount;
}

+ (void)setColumnCount:(NSUInteger)columnCount
{
    _columnCount = columnCount;
}

+ (NSString *)storedGridCountKey
{
    return @"GRSetting-grid-count-key";
}

+(void)setRowCountAndColumnCountFromUserDefaults
{
    if([[NSUserDefaults standardUserDefaults] valueForKey:[self storedGridCountKey]] != nil) {
        int gridCount = [[[NSUserDefaults standardUserDefaults] valueForKey:[self storedGridCountKey]] intValue];
        if(gridCount == 1)
            [self setRowCount:2];
        else if(gridCount == 2)
            [self setRowCount:3];
        else
            [self setRowCount:1];
    }
}

@end
