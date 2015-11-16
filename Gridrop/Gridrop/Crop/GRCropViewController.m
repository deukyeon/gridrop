//
//  GRCropViewController.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRCropViewController.h"
#import "GRCropView.h"
#import "GRImageManager.h"
#import "GRSetting.h"

@interface GRCropViewController () <GRCropViewDelegate>
{
    GRCropView *_cropView;
    
    UIButton *_cancelButton;
}
@end

@implementation GRCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(!_cropView) {
        _cropView = [[GRCropView alloc] initWithFrame:self.view.bounds];
        _cropView.delegate = self;
        [_cropView setImage:self.originalImage];
        [self.view addSubview:_cropView];
        [_cropView release];
    }
}

- (void)dealloc
{
    self.originalImage = nil;
    
    [super dealloc];
}

- (void)cropView:(GRCropView *)view touchedUpCancelButton:(UIButton *)button
{
    if(self.delegate)
        [self.delegate didCancelCropViewController:self];
}

- (void)cropView:(GRCropView *)view touchedUpFinishButton:(UIButton *)button cropRect:(CGRect)cropRect
{
    [self.originalImage retain];
    
    NSMutableArray *croppedImages = [NSMutableArray array];
    
    CGRect scaledCropRect = CGRectApplyAffineTransform(cropRect, CGAffineTransformMakeScale([view imageScale], [view imageScale]));
    
    CGFloat width = round(scaledCropRect.size.width / [GRSetting columnCount]);
    CGFloat height = round(scaledCropRect.size.height / [GRSetting rowCount]);
    
    for(int i=0; i<[GRSetting gridCount]; i++) {
        CGRect rect = CGRectMake(round(scaledCropRect.origin.x + width * (i % [GRSetting columnCount])),
                                 round(scaledCropRect.origin.y + height * (i / [GRSetting columnCount])),
                                 width, height);
        
        UIImage *croppedImage = [GRImageManager CropImage:self.originalImage rect:rect];
        [croppedImages addObject:croppedImage];
        [croppedImage release];
    }
    
    if(self.delegate)
        [self.delegate didFinishCropViewController:self croppedImages:croppedImages];
    
    [self.originalImage release];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
