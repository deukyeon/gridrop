//
//  GRCropViewController.h
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRCropViewController;
@protocol GRCropViewControllerDelegate <NSObject>

- (void)didCancelCropViewController:(GRCropViewController *)viewController;
- (void)didFinishCropViewController:(GRCropViewController *)viewController croppedImages:(NSArray *)images;

@end

@interface GRCropViewController : UIViewController

@property (nonatomic, assign) id<GRCropViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImage *originalImage;

@end
