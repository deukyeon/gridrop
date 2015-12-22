//
//  GRSetting.h
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRSetting : NSObject

+ (NSUInteger)gridCount;

+ (NSUInteger)rowCount;
+ (void)setRowCount:(NSUInteger)rowCount;

+ (NSUInteger)columnCount;
+ (void)setColumnCount:(NSUInteger)columnCount;

+ (NSString *)storedGridCountKey;

+(void)setRowCountAndColumnCountFromUserDefaults;

@end
