//
//  FlipRotate.m
//  TESTAPP
//
//  Created by Lalit on 09/12/15.
//  Copyright (c) 2015 ankit-iphone. All rights reserved.
//

#import "FlipRotate.h"

@implementation FlipRotate


- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle
{
    CGFloat angleInRadians = angle * (M_PI / 180);
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGRect imgRect = CGRectMake(0, 0, width, height);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angleInRadians);
    CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, transform);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bmContext = CGBitmapContextCreate(NULL,
                                                   rotatedRect.size.width,
                                                   rotatedRect.size.height,
                                                   8,
                                                   0,
                                                   colorSpace,
                                                   (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextSetAllowsAntialiasing(bmContext, YES);
    CGContextSetShouldAntialias(bmContext, YES);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM( bmContext, 0.5f * rotatedRect.size.width, 0.5f * rotatedRect.size.height ) ;
    CGContextRotateCTM(bmContext, angleInRadians);
    CGContextDrawImage(bmContext, CGRectMake(-imgRect.size.width* 0.5f, -imgRect.size.height * 0.5f,
                                             imgRect.size.width,
                                             imgRect.size.height),
                       imgRef);
    CGImageRef rotatedImage = CGBitmapContextCreateImage(bmContext);
   // CFRelease(bmContext);
    return rotatedImage;
}


//******************************flip*****************************

-(void)FlipVertical:(UIImageView*)chosenImageView
{
    
    UIImage *chosenImage = [self flipImageVertically: chosenImageView.image];
    
    [UIView transitionWithView:chosenImageView                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromTop +
     UIViewAnimationOptionBeginFromCurrentState
                    animations:^{
                        chosenImageView.image= chosenImage;
                    }
                    completion:^(BOOL finished)
     {
         
     }
     
     ];
    
    
}

- (UIImage *) flipImageVertically:(UIImage *)OriginalImage
{
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:OriginalImage];
    
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, tempImageView.frame.size.height
                                                           );
    CGContextConcatCTM(context, flipVertical);
    
    [tempImageView.layer renderInContext:context];
    
    UIImage *flipedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return flipedImage;
}


-(void)FlipHorizontal:(UIImageView*)chosenImageView
{
    
    
    UIImage*chosenImage= [self flipImageHorizontally: chosenImageView.image];
    
    [UIView transitionWithView:chosenImageView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight +
     UIViewAnimationOptionBeginFromCurrentState
                    animations:^{
                        chosenImageView.image= chosenImage;
                        
                    }
                    completion:^(BOOL finished)
     {
         
     }
     ];
}

- (UIImage *) flipImageHorizontally:(UIImage *)OriginalImage
{
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:OriginalImage];
    
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGAffineTransform flipHorizontal = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0,tempImageView.frame.size.width,0.0);
    
    
    CGContextConcatCTM(context, flipHorizontal);
    
    [tempImageView.layer renderInContext:context];
    
    UIImage *flipedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return flipedImage;
}





@end
