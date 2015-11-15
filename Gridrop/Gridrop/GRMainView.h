//
//  GRMainView.h
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRMainView;

@protocol GRMainViewDelegate <NSObject>

- (void)mainView:(GRMainView *)view touchedUpInsideLoadButton:(UIButton *)button;
- (void)mainView:(GRMainView *)view touchedUpInsideSaveButton:(UIButton *)button;

@end

@interface GRMainView : UIView

@property (nonatomic, assign) id<GRMainViewDelegate> delegate;

- (void)setImage:(UIImage *)image AtIndex:(NSUInteger)index;
- (UIImage *)imageAtIndex:(NSUInteger)index;
- (NSUInteger)imageCount;

@end
