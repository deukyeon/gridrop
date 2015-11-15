//
//  GRMainView.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRMainView.h"
#import "GRSetting.h"

@interface GRMainView ()
{
    NSMutableArray *_imageViews;
    UIButton *_loadButton;
    UIButton *_saveButton;
}
@end

@implementation GRMainView

- (CGFloat)lengthBetweenImageViews
{
    return 2.0;
}

- (CGRect)imageViewFrameWithIndex:(NSUInteger)index
{
    CGFloat length = floor((self.bounds.size.width - ([GRSetting columnCount] + 1) * [self lengthBetweenImageViews]) / [GRSetting columnCount]);
    
    NSUInteger colIndex = index % [GRSetting columnCount];
    NSUInteger rowIndex = index / [GRSetting columnCount];
    
    return CGRectMake([self lengthBetweenImageViews] * (1 + colIndex) + length * colIndex,
                      floor(self.bounds.size.height / 2 - (length * [GRSetting rowCount]) / 2 +
                            ([self lengthBetweenImageViews] + length) * rowIndex),
                      length, length);
}

- (CGSize)buttonSize
{
    return CGSizeMake(60, 40);
}

- (CGRect)loadButtonFrame
{
    return CGRectMake(4, 0, [self buttonSize].width, [self buttonSize].height);
}

- (CGRect)saveButtonFrame
{
    return CGRectMake(self.bounds.size.width - 4 - [self buttonSize].width, 0,
                      [self buttonSize].width, [self buttonSize].height);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        _loadButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loadButton setTitle:@"Load" forState:UIControlStateNormal];
        _loadButton.frame = [self loadButtonFrame];
        [_loadButton addTarget:self action:@selector(loadButton:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loadButton];
        
        _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        _saveButton.frame = [self saveButtonFrame];
        [_saveButton addTarget:self action:@selector(saveButton:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_saveButton];
        
        _imageViews = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [_imageViews release];
    
    [super dealloc];
}

- (void)setImage:(UIImage *)image AtIndex:(NSUInteger)index
{
    if(index >= _imageViews.count) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self imageViewFrameWithIndex:index]];
        [_imageViews addObject:imageView];
        [self addSubview:imageView];
        [imageView release];
    }
    
    ((UIImageView *)_imageViews[index]).image = image;
}

- (UIImage *)imageAtIndex:(NSUInteger)index
{
    if(index > 2) return nil;
    return ((UIImageView *)_imageViews[index]).image;
}

- (NSUInteger)imageCount
{
    return _imageViews.count;
}

- (void)loadButton:(UIButton *)button
{
    if(self.delegate)
        [self.delegate mainView:self touchedUpInsideLoadButton:button];
}

- (void)saveButton:(UIButton *)button
{
    if(_imageViews.count < 1) return;
    
    if(self.delegate)
        [self.delegate mainView:self touchedUpInsideSaveButton:button];
}

@end
