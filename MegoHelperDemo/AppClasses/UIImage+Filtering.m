//
//  UIImage+Filters.m
//  NYXImagesKit
//


#import "UIImage+Filtering.h"
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>


/* Negative multiplier to invert a number */
//static float __negativeMultiplier = -1.0f;

#pragma mark - Emboss kernels
/* vImage kernel */
static int16_t __s_emboss_kernel_3x3[9] = {
    -2, 0, 0,
    0, 1, 0,
    0, 0, 2
};


#pragma mark - Sharpen kernels
/* vImage kernel */
static int16_t __s_sharpen_kernel_3x3[9] = {
	-1, -1, -1, 
	-1, 9, -1, 
	-1, -1, -1
};

#pragma mark - Unsharpen kernels
/* vImage kernel */
static int16_t __s_unsharpen_kernel_3x3[9] = {
	-1, -1, -1, 
	-1, 17, -1, 
	-1, -1, -1
};


@implementation UIImage (NYX_Filtering)




// Value should be in the range (-255, 255)
-(UIImage*)brightenWithValue:(float)value
{
	/// Create an ARGB bitmap context
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, width * kNyxNumberOfComponentsPerARBGPixel, NYXImageHasAlpha(self.CGImage));
	if (!bmContext) 
		return nil;

	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage); 

	/// Grab the image raw data
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}

	const size_t pixelsCount = width * height;
	float* dataAsFloat = (float*)malloc(sizeof(float) * pixelsCount);
	float min = (float)kNyxMinPixelComponentValue, max = (float)kNyxMaxPixelComponentValue;

	/// Calculate red components
	vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &value, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 1, 4, pixelsCount);

	/// Calculate green components
	vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &value, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 2, 4, pixelsCount);

	/// Calculate blue components
	vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &value, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 3, 4, pixelsCount);

	CGImageRef brightenedImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage* brightened = [UIImage imageWithCGImage:brightenedImageRef scale:self.scale orientation:self.imageOrientation];

	/// Cleanup
	CGImageRelease(brightenedImageRef);
	free(dataAsFloat);
	CGContextRelease(bmContext);

	return brightened;
}

/// (-255, 255)
-(UIImage*)contrastAdjustmentWithValue:(float)value
{
	/// Create an ARGB bitmap context
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, width * kNyxNumberOfComponentsPerARBGPixel, NYXImageHasAlpha(self.CGImage));
	if (!bmContext) 
		return nil;

	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

	/// Grab the image raw data
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}

	const size_t pixelsCount = width * height;
	float* dataAsFloat = (float*)malloc(sizeof(float) * pixelsCount);
	float min = (float)kNyxMinPixelComponentValue, max = (float)kNyxMaxPixelComponentValue;

	/// Contrast correction factor
	const float factor = (259.0f * (value + 255.0f)) / (255.0f * (259.0f - value));

	float v1 = -128.0f, v2 = 128.0f;

	/// Calculate red components
	vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &v1, dataAsFloat, 1, pixelsCount);
	vDSP_vsmul(dataAsFloat, 1, &factor, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &v2, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 1, 4, pixelsCount);

	/// Calculate green components
	vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &v1, dataAsFloat, 1, pixelsCount);
	vDSP_vsmul(dataAsFloat, 1, &factor, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &v2, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 2, 4, pixelsCount);

	/// Calculate blue components
	vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &v1, dataAsFloat, 1, pixelsCount);
	vDSP_vsmul(dataAsFloat, 1, &factor, dataAsFloat, 1, pixelsCount);
	vDSP_vsadd(dataAsFloat, 1, &v2, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 3, 4, pixelsCount);

	/// Create an image object from the context
	CGImageRef contrastedImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage* contrasted = [UIImage imageWithCGImage:contrastedImageRef scale:self.scale orientation:self.imageOrientation];

	/// Cleanup
	CGImageRelease(contrastedImageRef);
	free(dataAsFloat);
	CGContextRelease(bmContext);

	return contrasted;
}


/// (0.01, 8)
-(UIImage*)gammaCorrectionWithValue:(float)value
{
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;
	/// Number of bytes per row, each pixel in the bitmap will be represented by 4 bytes (ARGB), 8 bits of alpha/red/green/blue
	const size_t bytesPerRow = width * kNyxNumberOfComponentsPerARBGPixel;

	/// Create an ARGB bitmap context
	CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, bytesPerRow, NYXImageHasAlpha(self.CGImage));
	if (!bmContext) 
		return nil;

	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

	/// Grab the image raw data
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}

	const size_t pixelsCount = width * height;
	const size_t n = sizeof(float) * pixelsCount;
	float* dataAsFloat = (float*)malloc(n);
	float* temp = (float*)malloc(n);
	float min = (float)kNyxMinPixelComponentValue, max = (float)kNyxMaxPixelComponentValue;
	const int iPixels = (int)pixelsCount;
	
	/// Need a vector with same size :(
	vDSP_vfill(&value, temp, 1, pixelsCount);
	
	/// Calculate red components
	vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsdiv(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
	vvpowf(dataAsFloat, temp, dataAsFloat, &iPixels);
	vDSP_vsmul(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 1, 4, pixelsCount);
	
	/// Calculate green components
	vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsdiv(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
	vvpowf(dataAsFloat, temp, dataAsFloat, &iPixels);
	vDSP_vsmul(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 2, 4, pixelsCount);
	
	/// Calculate blue components
	vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
	vDSP_vsdiv(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
	vvpowf(dataAsFloat, temp, dataAsFloat, &iPixels);
	vDSP_vsmul(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
	vDSP_vfixu8(dataAsFloat, 1, data + 3, 4, pixelsCount);
	
	/// Cleanup
	free(temp);
	free(dataAsFloat);

	/// Create an image object from the context
	CGImageRef gammaImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage* gamma = [UIImage imageWithCGImage:gammaImageRef];

	/// Cleanup
	CGImageRelease(gammaImageRef);
	CGContextRelease(bmContext);

	return gamma;
}


-(UIImage*)sharpenWithBias:(CGFloat)bias
{
	/// Create an ARGB bitmap context
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;
	const size_t bytesPerRow = width * kNyxNumberOfComponentsPerARBGPixel;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, bytesPerRow, NYXImageHasAlpha(self.CGImage));
	if (!bmContext) 
		return nil;

	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage); 

	/// Grab the image raw data
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}

	const size_t n = sizeof(UInt8) * width * height * 4;
	void* outt = malloc(n);
	vImage_Buffer src = {data, height, width, bytesPerRow};
	vImage_Buffer dest = {outt, height, width, bytesPerRow};
	vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_sharpen_kernel_3x3, 3, 3, 1/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
	
	memcpy(data, outt, n);
	
	free(outt);

	CGImageRef sharpenedImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage* sharpened = [UIImage imageWithCGImage:sharpenedImageRef];

	/// Cleanup
	CGImageRelease(sharpenedImageRef);
	CGContextRelease(bmContext);

	return sharpened;
}

-(UIImage*)unsharpenWithBias:(NSInteger)bias
{
	/// Create an ARGB bitmap context
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;
	const size_t bytesPerRow = width * kNyxNumberOfComponentsPerARBGPixel;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, bytesPerRow, NYXImageHasAlpha(self.CGImage));
	if (!bmContext) 
		return nil;

	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage); 

	/// Grab the image raw data
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}

	const size_t n = sizeof(UInt8) * width * height * 4;
	void* outt = malloc(n);
	vImage_Buffer src = {data, height, width, bytesPerRow};
	vImage_Buffer dest = {outt, height, width, bytesPerRow};
	vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_unsharpen_kernel_3x3, 3, 3, 9/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
	
	memcpy(data, outt, n);
	
	free(outt);

	CGImageRef unsharpenedImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage* unsharpened = [UIImage imageWithCGImage:unsharpenedImageRef];

	/// Cleanup
	CGImageRelease(unsharpenedImageRef);
	CGContextRelease(bmContext);

	return unsharpened;
}

-(UIImage*)embossWithBias:(NSInteger)bias
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    const size_t bytesPerRow = width * kNyxNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, bytesPerRow, NYXImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_emboss_kernel_3x3, 3, 3, 1/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef embossImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* emboss = [UIImage imageWithCGImage:embossImageRef];
    
    /// Cleanup
    CGImageRelease(embossImageRef);
    CGContextRelease(bmContext);
    
    return emboss;
}
@end
