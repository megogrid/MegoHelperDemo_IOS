//
//  Authenticate.h
//
//  Created by David-iphone on 12/06/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/*!
  @brief It is a protocol give Nserror callback.
 * @discussion This Protocol  give callback to Developer if any network or connection errors are occurs .
 * @param It is use to know error type, if Develper miss some Keys Put in .plist.
 @remark Give Error type .
 * @result return Error type
 *
 */

@protocol MegoAuthErrorHandling

/*!
 @brief It is a Delegate method give Nserror callback.
 * @discussion This Deleagte method  give callback to Developer if any network or connection errors are occurs .
 * @param It is use to know error type, if Develper miss some Keys Put in .plist.
 @remark Give Error type .
 * @result return Error type
 *
 */

-(void)megoAuthErrorHandler:(NSError*)ErrorDescription;

@end


/*!
 @class MegoAuthenticate
 
 @discussion Use this to configure application according to AppID,SecretKEYand DevID and fetch all data from server configured on CMS Panel */


@interface MegoAuthenticate : NSObject

@property (strong, nonatomic) id <MegoAuthErrorHandling> delegate;

/*!
 @brief It is a method  give callback(Send notification) to other Megoframewoks.
 * @discussion This method  give callback(Send notification) to other Megoframewoks give dynamic Urls and Authentication keys.
 * @param Use to Authenticate and give access to use MegoFrameworks.
 @remark It is must use by Developers to aceess and use other frameworks of Mego .
 * @result Authenticate MegoFrameworks
 *
 */

-(void)initializeMego;

/*!
  @brief It is a method  give History of purchased and Redeemed .
 * @discussion this provide the history of purchase item and get redeem credits by promo code
 * @param .pass UINavigationController
 * @result give History of purchased and Reedme
 *
 */
-(void)getHistory:(UINavigationController*)navigation;


@end
