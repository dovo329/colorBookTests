//
//  GameScene.m
//  appleSpriteKitTut2
//
//  Created by Douglas Voss on 6/16/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

/*-(CGPoint)pointFromPixelCoord:(CGPoint)pixelCoord
{
    CGPoint retPoint = pixelCoord;
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 2.9) {
        retPoint.x /= 3.0;
        retPoint.y /= 3.0;
    } else if (scale > 1.9) {
        retPoint.x /= 2.0;
        retPoint.y /= 2.0;
    } else {
       // nothing
    }
    return retPoint;
}*/

-(void)didMoveToView:(SKView *)view {

    self.anchorPoint = CGPointMake(0.5, 0.5);
    //self.position = CGPointMake(0, 0);
    self.paletteFilter = [PaletteFilter new];
    self.paletteEffect = [SKEffectNode new];
    [self.paletteEffect setFilter:self.paletteFilter];
    //[self addChild:self.sprite];
    self.paletteEffect.shouldRasterize = false;
    //self.paletteEffect.shouldRasterize = true;
    //self.paletteEffect.blendMode = SKBlendModeReplace;
    self.paletteEffect.blendMode = SKBlendModeAlpha;
    self.paletteEffect.shouldEnableEffects = true;
    
    
    //SKTexture *texture = [SKTexture textureWithImageNamed:@"mtnHouseWithSun"];
    //self.sprite = [SKSpriteNode spriteNodeWithTexture:texture];
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"mtnHouseWithSun"];
    
    CGFloat newXScale = self.size.width / self.sprite.size.width;
    CGFloat newYScale = self.size.height / self.sprite.size.height;
    CGFloat newScale = MIN(newXScale, newYScale);
    self.sprite.xScale = newScale;
    self.sprite.yScale = newScale;
    //self.sprite.blendMode = SKBlendModeReplace;
    
    //self.sprite.position = CGPointMake(self.sprite.size.width/2.0, self.sprite.size.height/2.0);
    self.sprite.anchorPoint = CGPointMake(0.5, 0.5);
    
    //CGPoint spritePositionInPixels = CGPointMake(-self.sprite.size.width/2.0, -self.sprite.size.height/2.0);
    
    //self.sprite.position = [self pointFromPixelCoord:spritePositionInPixels];
    
    self.sprite.position = CGPointMake(0,0);
    
    //self.sprite.position = CGPointMake(-self.sprite.size.width/2.0, -self.sprite.size.height/2.0);
    
    [self addChild:self.sprite];
    //[self.paletteEffect addChild:self.sprite];
    //[self addChild:self.paletteEffect];

    self.lastTranslatePoint = CGPointMake(0,0);
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanMethod:)];
    panGest.maximumNumberOfTouches = 1;
    panGest.minimumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGest];
    
    UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchMethod:)];
    [self.view addGestureRecognizer:pinchGest];
}

// called once per frame?
-(void)update:(NSTimeInterval)currentTime
{
    self.paletteFilter.toggle = !self.paletteFilter.toggle;
}

-(void)handlePinchMethod:(UIPinchGestureRecognizer *)sender
{
    CGFloat scaleDelta = sender.velocity*0.025;
    self.sprite.xScale += scaleDelta;
    self.sprite.yScale += scaleDelta;

    CGFloat spriteLeft = (self.anchorPoint.x*self.size.width) - (self.sprite.anchorPoint.x*self.sprite.size.width);
    CGFloat spriteRight = (self.anchorPoint.x*self.size.width) + ((1.0-self.sprite.anchorPoint.x)*self.sprite.size.width);
    CGFloat spriteBottom = (self.anchorPoint.y*self.size.height) - (self.sprite.anchorPoint.y*self.sprite.size.height);
    CGFloat spriteTop = (self.anchorPoint.y*self.size.height) + ((1.0-self.sprite.anchorPoint.y)*self.sprite.size.height);

    // if we are zooming out then check for clip, but allow zoom in
    if (scaleDelta < 0.0)
    {
        // check if have exceeded bounds and undo scale if we have
        if ((spriteLeft > 0.0 || spriteRight < self.size.width) ||
            (spriteBottom > 0.0 || spriteTop < self.size.height))
        {
            self.sprite.xScale -= scaleDelta;
            self.sprite.yScale -= scaleDelta;
        }
    }
    // max zoom in of 6x
    if (self.sprite.xScale > 6.0) {
        self.sprite.xScale = 6.0;
    }
    if (self.sprite.yScale > 6.0) {
        self.sprite.yScale = 6.0;
    }
    
    //NSLog(@"scale = %f; velocity = %f xScale=%f yScale=%f", sender.scale, sender.velocity, self.sprite.xScale, self.sprite.yScale);
}

-(void)handlePanMethod:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [sender translationInView:self.view];

    CGFloat deltaX = -(translatedPoint.x - self.lastTranslatePoint.x);
    CGFloat deltaY = (translatedPoint.y - self.lastTranslatePoint.y);
    
    /*CGFloat widthRatio = self.sprite.size.width/self.size.width;
    CGFloat heightRatio = self.sprite.size.height/self.size.height;
    
    // only allow scroll if content is larger than the screen in that direction
    CGFloat deltaX = 0.0;
    if (widthRatio > 1.0)
    {
        deltaX = -(translatedPoint.x - self.lastTranslatePoint.x);
    }
    
    CGFloat deltaY = 0.0;
    if (heightRatio > 1.0)
    {
        deltaY = (translatedPoint.y - self.lastTranslatePoint.y);
    }*/
    
    //NSLog(@"delta x:%f y:%f", deltaX, deltaY);
    //CGPoint newPoint = CGPointMake(deltaX+self.sprite.position.x, deltaY+self.sprite.position.y);
    
    //self.sprite.position = newPoint;
    
    CGPoint newAnchorPoint = CGPointMake((deltaX/(self.sprite.size.width))+self.sprite.anchorPoint.x, (deltaY/(self.sprite.size.height))+self.sprite.anchorPoint.y);
    
    CGFloat spriteLeft = (self.anchorPoint.x*self.size.width) - (newAnchorPoint.x*self.sprite.size.width);
    CGFloat spriteRight = (self.anchorPoint.x*self.size.width) + ((1.0-newAnchorPoint.x)*self.sprite.size.width);
    CGFloat spriteBottom = (self.anchorPoint.y*self.size.height) - (newAnchorPoint.y*self.sprite.size.height);
    CGFloat spriteTop = (self.anchorPoint.y*self.size.height) + ((1.0-newAnchorPoint.y)*self.sprite.size.height);
    
    CGFloat clipX = newAnchorPoint.x;
    if (spriteLeft > 0.0 || spriteRight < self.size.width)
    {
        clipX = self.sprite.anchorPoint.x;
    }
    
    CGFloat clipY = newAnchorPoint.y;
    if (spriteBottom > 0.0 || spriteTop < self.size.height)
    {
        clipY = self.sprite.anchorPoint.y;
    }

    self.sprite.anchorPoint = CGPointMake(clipX, clipY);
    NSLog(@"anchorPoint x=%0.2f y=%0.2f w=%0.2f h=%0.2f sl=%0.2f sr=%0.2f st=%0.2f sb=%0.2f", self.sprite.anchorPoint.x, self.sprite.anchorPoint.y, self.sprite.size.width, self.sprite.size.height, spriteLeft, spriteRight, spriteTop, spriteBottom);
    self.lastTranslatePoint = translatedPoint;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.lastTranslatePoint = CGPointMake(0, 0);
    //NSLog(@"lastTranslatePoint x:%f y:%f", self.lastTranslatePoint.x, self.lastTranslatePoint.y);
    
    //self.paletteFilter.toggle = !self.paletteFilter.toggle;
    //NSLog(@"touches began");
}

@end
