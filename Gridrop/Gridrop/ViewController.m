//
//  ViewController.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "ViewController.h"
#import "GRMainView.h"
#import "GRCropViewController.h"
#import "GRSetting.h"

@interface ViewController ()
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, GRMainViewDelegate, GRCropViewControllerDelegate>
{
    GRMainView *_mainView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if(!_mainView) {
        GRMainView *mainView = [[GRMainView alloc] initWithFrame:self.view.bounds];
        mainView.delegate = self;
        [self.view addSubview:mainView];
        [mainView release];
        
        _mainView = mainView;
    }
}

- (void)presentPickerController
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:^{
            [pickerController release];
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image)
        image = info[UIImagePickerControllerOriginalImage];
    
    GRCropViewController *cropViewController = [[GRCropViewController alloc] init];
    cropViewController.originalImage = image;
    cropViewController.delegate = self;
    cropViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [picker presentViewController:cropViewController animated:YES completion:^{
        [cropViewController release];
    }];
}

- (void)mainView:(GRMainView *)view touchedUpInsideLoadButton:(UIButton *)button
{
    [self presentPickerController];
}

- (void)mainView:(GRMainView *)view touchedUpInsideSaveButton:(UIButton *)button
{
    CGSize indicatorSize = CGSizeMake(50, 50);
    CGRect indicatorFrame = CGRectMake(self.view.bounds.size.width / 2 - indicatorSize.width / 2,
                                       self.view.bounds.size.height / 2 - indicatorSize.height / 2,
                                       indicatorSize.width, indicatorSize.height);

    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:indicatorFrame];
    [self.view addSubview:indicatorView];
    [indicatorView release];
    [indicatorView startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for(int i=0; i<[view imageCount]; i++) {
            UIImageWriteToSavedPhotosAlbum([view imageAtIndex:i], nil, nil, nil);
            
            [NSThread sleepForTimeInterval:0.1];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                            message:@"Check Photos App."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [indicatorView removeFromSuperview];
        });
    });
}

- (void)didCancelCropViewController:(GRCropViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didFinishCropViewController:(GRCropViewController *)viewController croppedImages:(NSArray *)images
{
    [self dismissViewControllerAnimated:YES completion:^{
        viewController.originalImage = nil;
    }];

    [_mainView removeImageViews];
    for(int i=0; i<images.count; i++)
        [_mainView setImage:images[i] atIndex:i];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
