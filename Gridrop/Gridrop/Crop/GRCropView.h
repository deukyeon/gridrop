//
//  GRCropView.h
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRCropView;

@protocol GRCropViewDelegate <NSObject>

- (void)cropView:(GRCropView *)view touchedUpCancelButton:(UIButton *)button;
- (void)cropView:(GRCropView *)view touchedUpFinishButton:(UIButton *)button cropRect:(CGRect)cropRect;
- (void)cropView:(GRCropView *)view touchedUpGridCountControl:(UISegmentedControl *)control;

@end

@interface GRCropView : UIView

@property (nonatomic, assign) id<GRCropViewDelegate> delegate;

- (void)setImage:(UIImage *)image;

- (void)refresh;

- (CGFloat)imageScale;

@end
