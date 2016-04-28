//
//  saveImage.m
//  TESTAPP
//
//  Created by Lalit on 10/12/15.
//  Copyright (c) 2015 ankit-iphone. All rights reserved.
//

#import "saveImage.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@implementation saveImage


-(void)saveImage:(UIImage*)imageForSave{
    
    
    ALAssetsLibrary *library= [[ALAssetsLibrary alloc] init];
    
    void (^completion)(NSURL *, NSError *) = ^(NSURL *assetURL, NSError *error) {
        if (error) NSLog(@"!!!ERROR,  write the image data to the assets library (camera roll): %@",
                         [error description]);
        NSLog(@"*** URL %@ | %@ || type: %@ ***", assetURL, [assetURL absoluteString], [assetURL class]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Photo Saved: ");
            [self showStatus:@"Image has been successfully saved.":1.00];
        });
    };
    void (^failure)(NSError *) = ^(NSError *error) {
        if (error == nil) return;
        NSLog(@"!!!ERROR, failed to add the asset to the custom photo album: %@", [error description]);
    };
    
    [library saveImage:imageForSave toAlbum:@"Demo App" completion:completion failure:failure];
}

- (void)showStatus:(NSString *)message :(double)timeout {
  statusAlert = [[UIAlertView alloc] initWithTitle:nil
                                              message:message
                                             delegate:nil
                                    cancelButtonTitle:nil
                                    otherButtonTitles:nil];
    [statusAlert show];
    [NSTimer scheduledTimerWithTimeInterval:timeout
                                     target:self
                                   selector:@selector(timerExpired:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)timerExpired:(NSTimer *)timer {
    [statusAlert dismissWithClickedButtonIndex:0 animated:YES];
}



@end
