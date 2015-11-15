//
//  GRCropView.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRCropView.h"
#import "GRCropAssistView.h"

@interface GRCropView ()
{
    UIImageView *_imageView;
    GRCropAssistView *_assistView;
    
    UIButton *_cancelButton;
    UIButton *_finishButton;
}
@end

@implementation GRCropView

- (CGSize)buttonSize
{
    return CGSizeMake(60, 40);
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

- (CGFloat)paddingImageView
{
    return 10;
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
    
    width = self.bounds.size.width - 2 * [self paddingImageView];
    height = width / ratio;
    
    if(height > self.bounds.size.height - [self buttonSize].height - 2 * [self paddingImageView]) {
        CGFloat oldHeight = height;
        height = self.bounds.size.height - [self buttonSize].height - 2 * [self paddingImageView];
        width = width * (height / oldHeight);
    }
    
    CGRect frame = CGRectMake(self.bounds.size.width / 2 - width / 2,
                              self.bounds.size.height / 2 - height / 2 + [self buttonSize].height / 2,
                              width, height);
    
    _imageView.frame = frame;
    _assistView.frame = frame;
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

@end
