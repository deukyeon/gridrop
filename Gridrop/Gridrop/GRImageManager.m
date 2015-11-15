//
//  GRImageManager.m
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import "GRImageManager.h"

@implementation GRImageManager

+ (UIImage *)CropImage:(UIImage *)image rect:(CGRect)rect
{
    UIImage *croppedImage;
    
    @autoreleasepool {
        [image retain];
    
        UIGraphicsBeginImageContext(rect.size);
        
        [image drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
        croppedImage = [UIGraphicsGetImageFromCurrentImageContext() retain];
        
        UIGraphicsEndImageContext();
        
        [image release];
    }
    
    return croppedImage;
}

@end
