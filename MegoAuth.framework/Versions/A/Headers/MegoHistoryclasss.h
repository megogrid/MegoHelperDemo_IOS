
//  Created by David on 7/13/15.
//



/// @cond MegoHistoryclasss.h;

#import <UIKit/UIKit.h>

@protocol historyFailedDelegate <NSObject>

@required

-(void)HistoryFailedHandller:(NSError*)ErrorDescription;

@end

@interface MegoHistoryclasss : UIViewController
{
    UIView               *MainView;
   
    NSMutableArray       *requestParamArray;
    NSMutableArray       *tabArray;
    NSMutableArray       *themeDataArray;
    CGRect               collectionRect;
    UICollectionView     *themeCollectionView;
    UICollectionViewFlowLayout *layout;
    NSString              *myimage;
    NSMutableArray        *buttonimage;
    UIImageView           *header;
    UIView                *myview;
   
}
@property (strong, nonatomic) id <historyFailedDelegate> delegate;

/*!
 @brief this method is used for fetch Campaigns history list.
 @remark This is a super method for ask from the server for history Campaigns list .
 */
-(void)AuthenticationServiceSuccessHandller;

/*!
 @brief this method tell the user to get all history Campaigns list.
 @remark This is a super method for save  history Campaigns list that come from the server .
 */
-(void)ServiceSuccessHandller:(NSData*)data;

/*!
 @brief this method tell the user for warnings.
 */
-(void)ServieFailedHandller:(NSString*)ErrorDescription;




@property(nonatomic,strong)NSString *myName;
@property(nonatomic,strong)NSString*colorString;
@property(nonatomic,strong)UIImage *myImage;
@property(nonatomic)int myThemeType;
@property(nonatomic,strong)NSMutableArray *tableImages;
@property(nonatomic,strong)NSMutableArray *buttonimage;
-(void)GetHeader:(NSString *)getCreditvalue;
@end
/// @endcond
