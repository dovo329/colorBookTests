//
//  PaletteFilter.h
//  appleSpriteKitTut2
//
//  Created by Douglas Voss on 6/16/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

#define kColorCubeSideSize 64
#define kColorCubeSize kColorCubeSideSize * kColorCubeSideSize * kColorCubeSideSize * sizeof (float) * 4

@interface PaletteFilter : CIFilter {
    float *cubeData;
}

@property (strong, nonatomic) CIImage *inputImage;
@property (assign, nonatomic) BOOL toggle;
@property (strong, nonatomic) NSData *cubeNSData;
@property (strong, nonatomic) CIContext *ciContext;
@property (strong, nonatomic) CIFilter *filter;

@end
