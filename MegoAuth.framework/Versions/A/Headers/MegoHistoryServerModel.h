//
//  Created by David on 7/13/15.
//


/// @cond MegoHistoryServerModel.h;

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@protocol MegoServerDataHandller
@required
-(void)serviceSuccessHandller:(NSData*)Response;
-(void)servieFailedHandller:(NSString*)ErrorDescription;
-(void)getImage:(UIImage*)DownloadedImage;
-(void)coinUpdated:(NSDictionary*)Response;
-(void)configHandller:(NSDictionary*)Response;
-(void)authenticated:(NSString*)tokenKey;
-(void)authenticationServiceSuccessHandller;
-(void)recivegiftHandler:(NSDictionary*)Response;
-(void)sendgiftHandler:(NSDictionary*)Response;
-(void)notifyActionHandler:(NSDictionary*)Response;
@end

/*!
 @class         MeWardHistoryServerModel
 @brief         The NSObject class
 @discussion    This class is designed and implemented for send a request to server and get response from the server  .
 @classdesign   This class is design for Spically  to handle server request from the server and from the user.
 @helps         It helps no other classes.
 @helper        No helper exists for this class.
 */
@interface MegoHistoryServerModel : NSObject
{
   
}

@property (strong, nonatomic) id <MegoServerDataHandller> _delegate;
@property(nonatomic,strong)NSString *appID;
@property(nonatomic,strong)NSString *appSecrate;
@property(nonatomic,strong)NSString *developerID;
@property(nonatomic,strong)NSString *serverPath;
@property(nonatomic,strong)NSString *authenticationServerPath;
@property(nonatomic,strong) NSString *devicetoken;
@property(nonatomic,strong)NSString  *campname;
@property(nonatomic,strong)NSString *minGiftValue;
@property(nonatomic)int isAllowGifting;
@property(nonatomic,strong)NSString *mewardID;
@property(nonatomic,strong)NSString *appTokenKey;
@property(nonatomic,strong)NSString *appInstallationDate;
@property(nonatomic,strong)NSString *appDataSavedKey;
@property(nonatomic,strong)NSString *mewardCoinblanaceKey;




-(void)fetchCampaigns;
-(void)singleImageDownloadService:(NSString*)ImageUrl;
-(NSMutableArray*)parseJsonToInstallShareView:(NSData*)data;
-(void)fetchCreditsToPurchase;
-(NSString*)getRemainingCoinBalance;
-(void)saveandUpdateCoinBalance;
-(void)getDataFromLocalBundle :(NSString*)File;
-(void)fetchEarnedHistory;
-(void)fetchReadeamPointsDetails;
-(void)saveRemainingCoin:(NSString*)UsersCoinBalance;
-(void)getPurchasableCoinList;
-(void)updateCointoServer:(NSString*)PackageId CampaignId:(NSString*)CampaignId Coins:(NSString*)Coins type:(NSString*)type  type1:(NSString*)type1;
-(void)initializeMewardConfig;
-(void)sendGift:(NSString*)EmailId CreditsPoints:(NSString*)CreditsPoints;
-(void)receiveGift:(NSString*)promoCode;
-(void)notifyAction:(NSString*)eventId :(NSDictionary*)DicConditions;
-(void)getCreditBalance;
-(NSMutableArray*)parseJsonEarnedHistoryView:(NSData*)data;
-(NSMutableArray*)parseJsonBuyView:(NSData*)data;
-(NSMutableArray*)parseReadeamedPointsView:(NSData*)data;
+(void)notifyInstallRefferal:(NSString*)RefferalDetails;

+(UIImage*)getImageFromBundle:(NSString*)imageName;





-(void)getCampaigns;
-(void)getCampaignsForUser;
-(void)appDataParser:(NSDictionary*)Json;
-(void)intializeSDK;




@end
/// @endcond
