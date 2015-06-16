//
//  PaletteFilter.m
//  appleSpriteKitTut2
//
//  Created by Douglas Voss on 6/16/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "PaletteFilter.h"

@implementation PaletteFilter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.toggle = false;
        // Allocate memory
        self.ciContext = [CIContext contextWithOptions:nil];
        
        UIImage *UIImg = [UIImage imageNamed:@"mtnHouseWithSun"];
        
        //UIImage *resizedImg = [UIImg resizedImage:CGSizeMake(480.0, 960.0) interpolationQuality:kCGInterpolationHigh];
        
        self.inputImage = [[CIImage alloc] initWithCGImage:UIImg.CGImage];
        
        // Set data for cube
        self.cubeData = (float *)malloc (kColorCubeSize);
        
        float rgb[3], *c = self.cubeData;
        // Populate cube with a simple gradient going from 0 to 1
        for (int z = 0; z < kColorCubeSideSize; z++){
            rgb[2] = ((double)z)/(kColorCubeSideSize-1); // Blue value
            for (int y = 0; y < kColorCubeSideSize; y++){
                rgb[1] = ((double)y)/(kColorCubeSideSize-1); // Green value
                for (int x = 0; x < kColorCubeSideSize; x ++){
                    rgb[0] = ((double)x)/(kColorCubeSideSize-1); // Red value
                    // Convert RGB to HSV
                    // You can find publicly available rgbToHSV functions on the Internet
                    // Use the hue value to determine which to make transparent
                    // The minimum and maximum hue angle depends on
                    // the color you want to remove
                    // Calculate premultiplied alpha values for the cube
                    if (self.toggle) {
                        c[0] = rgb[0];
                        c[1] = rgb[1];
                        c[2] = rgb[2];
                        c[3] = 1.0;
                    } else {
                        c[0] = rgb[2];
                        c[1] = rgb[0];
                        c[2] = rgb[1];
                        c[3] = 1.0;
                    }
                    c += 4; // advance our pointer into memory for the next color value
                }
            }
        }
        // Create memory with the cube data
        self.cubeNSData = [NSData dataWithBytesNoCopy:self.cubeData
                                               length:kColorCubeSize
                                         freeWhenDone:YES];
        
        self.filter = [CIFilter filterWithName:@"CIColorCube"];
        [self.filter setValue:@(kColorCubeSideSize) forKey:@"inputCubeDimension"];
        // Set data for cube
        [self.filter setValue:self.cubeNSData forKey:@"inputCubeData"];
        [self.filter setValue:self.inputImage forKey:kCIInputImageKey];
    }
    return self;
}



- (CIImage *)outputImage {
    //NSLog(@"start %s", __PRETTY_FUNCTION__);
    /*float rgb[3], *c = self.cubeData;
     if (self.toggle) {
     
     } else {
     
     }
     // Create memory with the cube data
     self.cubeNSData = [NSData dataWithBytesNoCopy:self.cubeData
     length:kColorCubeSize
     freeWhenDone:YES];*/
    self.cubeData = (float *)malloc (kColorCubeSize);
    
    float rgb[3], *c = self.cubeData;
    // Populate cube with a simple gradient going from 0 to 1
    for (int z = 0; z < kColorCubeSideSize; z++){
        rgb[2] = ((double)z)/(kColorCubeSideSize-1); // Blue value
        for (int y = 0; y < kColorCubeSideSize; y++){
            rgb[1] = ((double)y)/(kColorCubeSideSize-1); // Green value
            for (int x = 0; x < kColorCubeSideSize; x ++){
                rgb[0] = ((double)x)/(kColorCubeSideSize-1); // Red value
                // Convert RGB to HSV
                // You can find publicly available rgbToHSV functions on the Internet
                // Use the hue value to determine which to make transparent
                // The minimum and maximum hue angle depends on
                // the color you want to remove
                // Calculate premultiplied alpha values for the cube
                if (self.toggle) {
                    c[0] = rgb[0];
                    c[1] = rgb[1];
                    c[2] = rgb[2];
                    c[3] = 1.0;
                } else {
                    c[0] = rgb[2];
                    c[1] = rgb[0];
                    c[2] = rgb[1];
                    c[3] = 1.0;
                }
                c += 4; // advance our pointer into memory for the next color value
            }
        }
    }
    // Create memory with the cube data
    self.cubeNSData = [NSData dataWithBytesNoCopy:self.cubeData
                                           length:kColorCubeSize
                                     freeWhenDone:YES];
    
    //CIFilter *colorCube = [CIFilter filterWithName:@"CIColorCube"];
    //[colorCube setValue:@(kColorCubeSideSize) forKey:@"inputCubeDimension"];
    // Set data for cube
    
    // update colorcube on filter
    [self.filter setValue:self.cubeNSData forKey:@"inputCubeData"];
    CIImage *ciImage = [self.filter valueForKey:kCIOutputImageKey];
    return ciImage;
    //UIImage *result = [UIImage imageWithCIImage:ciImage];
    
    //[result drawInRect:self.bounds];
    
    //self.firstTime = false;
    
    //NSLog(@"end %s", __PRETTY_FUNCTION__);
}

@end
