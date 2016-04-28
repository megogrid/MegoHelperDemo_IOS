//
//  saveImage.h
//  TESTAPP
//
//  Created by Lalit on 10/12/15.
//  Copyright (c) 2015 ankit-iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface saveImage : NSObject{

    UIAlertView* statusAlert;
}

-(void)saveImage:(UIImage*)imageForSave;

@end
