//
//  UIImage+Filters.h
//  NYXImagesKit
//


#import "NYXImagesHelper.h"


@interface UIImage (NYX_Filtering)

-(UIImage*)brightenWithValue:(float)factor;

-(UIImage*)contrastAdjustmentWithValue:(float)value;

-(UIImage*)sharpenWithBias:(CGFloat)bias;

-(UIImage*)gammaCorrectionWithValue:(float)value;



-(UIImage*)unsharpenWithBias:(NSInteger)bias;


-(UIImage*)embossWithBias:(NSInteger)bias;
@end
