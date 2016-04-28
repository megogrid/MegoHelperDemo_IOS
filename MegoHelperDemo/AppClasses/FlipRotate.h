//
//  FlipRotate.h
//  TESTAPP
//
//  Created by Lalit on 09/12/15.
//  Copyright (c) 2015 ankit-iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlipRotate : NSObject

-(void)FlipVertical:(UIImageView*)chosenImageView;

-(void)FlipHorizontal:(UIImageView*)chosenImageView;

- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle;

@end

#define DEGREES_TO_RADIANS(x) (x * M_PI/180.0)
