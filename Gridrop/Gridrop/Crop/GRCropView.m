//
//  GRCropView.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRCropView.h"
#import "GRCropAssistView.h"
#import "GRSetting.h"

@interface GRCropView ()
{
    UIImageView *_imageView;
    GRCropAssistView *_assistView;
    
    UIButton *_cancelButton;
    UIButton *_finishButton;
    
    UISegmentedControl *_gridCountControl;
}
@end

@implementation GRCropView

- (CGFloat)paddingCropView
{
    return 10;
}

- (CGFloat)imageViewMinY
{
    return [self paddingCropView] + [self buttonSize].height;
}

- (CGFloat)imageViewMaxY
{
    return self.bounds.size.height - (2 * [self paddingCropView] + [self gridCountControlHeight]);
}

- (CGFloat)imageViewMaxHeight
{
    return [self imageViewMaxY] - [self imageViewMinY];
}

- (CGSize)buttonSize
{
    return CGSizeMake(60, 60);
}

- (CGRect)cancelButtonFrame
{
    return CGRectMake(4, 0, [self buttonSize].width, [self buttonSize].height);
}

- (CGRect)finishButtonFrame
{
    return CGRectMake(self.bounds.size.width - 4 - [self buttonSize].width, 0,
                      [self buttonSize].width, [self buttonSize].height);
}

- (CGFloat)gridCountControlHeight
{
    return 60.0;
}

- (CGRect)gridCountControlFrame
{
    return CGRectMake([self paddingCropView], self.bounds.size.height - [self paddingCropView] - [self gridCountControlHeight],
                      self.bounds.size.width - 2 * [self paddingCropView], [self gridCountControlHeight]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = [self cancelButtonFrame];
        _cancelButton.exclusiveTouch = YES;
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _finishButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishButton.frame = [self finishButtonFrame];
        _finishButton.exclusiveTouch = YES;
        [_finishButton setTitle:@"Finish" forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(finishButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_finishButton];
        
        _gridCountControl = [[UISegmentedControl alloc] initWithItems:@[@"3x1", @"3x2", @"3x3"]];
        _gridCountControl.frame = [self gridCountControlFrame];
        if([[NSUserDefaults standardUserDefaults] valueForKey:[GRSetting storedGridCountKey]] == nil)
            _gridCountControl.selectedSegmentIndex = 0;
        else
            _gridCountControl.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:[GRSetting storedGridCountKey]] intValue];
        [_gridCountControl addTarget:self action:@selector(gridCountControl:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_gridCountControl];
        [_gridCountControl release];
        
    }
    
    return self;
}

- (void)dealloc
{
    _imageView.image = nil;
    
    [super dealloc];
}

- (void)setImage:(UIImage *)image
{
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView release];
        
        _assistView = [[GRCropAssistView alloc] init];
        [self addSubview:_assistView];
        [_assistView release];
    }
    
    _imageView.image = image;
    
    const CGFloat ratio = image.size.width / image.size.height;
    
    CGFloat width, height;
    
    width = self.bounds.size.width - 2 * [self paddingCropView];
    height = width / ratio;
    
    if(height > [self imageViewMaxHeight]) {
        CGFloat oldHeight = height;
        height = [self imageViewMaxHeight];
        width = width * (height / oldHeight);
    }
    
    CGRect frame = CGRectMake(self.bounds.size.width / 2 - width / 2,
                              [self imageViewMinY] + [self imageViewMaxHeight] / 2 - height / 2,
                              width, height);
    
    _imageView.frame = frame;
    _assistView.frame = frame;
}

- (void)refresh
{
    [_assistView setBoxViewFrameAndCenter];
}

- (CGFloat)imageScale
{
    return _imageView.image.size.width / _imageView.frame.size.width;
}

- (void)cancelButton:(UIButton *)button
{
    if(self.delegate)
        [self.delegate cropView:self touchedUpCancelButton:button];
}

- (void)finishButton:(UIButton *)button
{
    if(self.delegate)
        [self.delegate cropView:self touchedUpFinishButton:button cropRect:[_assistView cropRect]];
}

- (void)gridCountControl:(UISegmentedControl *)control
{
    if(self.delegate)
        [self.delegate cropView:self touchedUpGridCountControl:control];
}

@end
