//
//  ViewController.h
//  MegoShopDemo
//
//  Created by jaiom on 02/03/16.
//  Copyright (c) 2016 Migital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,SlideViewDelegate>

@property (nonatomic , retain) UIImage *chosenImage;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) NSString *imageName;

@end

