//
//  GRImageManager.h
//  ThreePicsGram
//
//  Created by Deukyeon on 2015. 11. 15..
//  Copyright (c) 2015년 Deukyeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRImageManager : NSObject

+ (UIImage *)CropImage:(UIImage *)image rect:(CGRect)rect;

@end
