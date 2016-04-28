//
//  HelperNavigator.h
//  MeCoin_Demo
//
//  Created by Lalit on 06/02/16.
//  Copyright (c) 2016 unity. All rights reserved.
//

#define FAQ @"Faq"
#define UserQueries @"UserQueries"
#define Survey @"Survey"
#define Update @"Update"
#define Rate @"Rate"
#define Help @"Help"
#define FeedBack @"FeedBack"
#define Tutorial @"Tutorial"

#import <UIKit/UIKit.h>


@interface MHHelperNavigator : NSObject

-(void)getAllHelperServices:(UIView *)view;


-(void)getHelperView:(UIViewController *)helperView andType :(NSString *)typeString;
@end
