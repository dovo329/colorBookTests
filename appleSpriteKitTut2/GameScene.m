//
//  GameScene.m
//  appleSpriteKitTut2
//
//  Created by Douglas Voss on 6/16/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {

    self.paletteFilter = [PaletteFilter new];
    self.paletteEffect = [SKEffectNode new];
    [self.paletteEffect setFilter:self.paletteFilter];
    
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"mtnHouseWithSun"];
        
    self.sprite.xScale = 0.5;
    self.sprite.yScale = 0.5;
    
    self.sprite.position = CGPointMake(self.sprite.size.width/2.0, self.sprite.size.height/2.0);
    
    [self.paletteEffect addChild:self.sprite];
    [self addChild:self.paletteEffect];

    self.lastTranslatePoint = CGPointMake(0,0);
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanMethod:)];
    panGest.maximumNumberOfTouches = 1;
    panGest.minimumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGest];
}

-(void)handlePanMethod:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [sender translationInView:self.view];
    
    CGFloat deltaX = translatedPoint.x - self.lastTranslatePoint.x;
    CGFloat deltaY = -(translatedPoint.y - self.lastTranslatePoint.y);
    NSLog(@"delta x:%f y:%f", deltaX, deltaY);
    CGPoint newPoint = CGPointMake(deltaX+self.sprite.position.x, deltaY+self.sprite.position.y);
    
    self.sprite.position = newPoint;
    self.lastTranslatePoint = translatedPoint;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.lastTranslatePoint = CGPointMake(0, 0);
    NSLog(@"lastTranslatePoint x:%f y:%f", self.lastTranslatePoint.x, self.lastTranslatePoint.y);
    
    self.paletteFilter.toggle = !self.paletteFilter.toggle;
    NSLog(@"touches began");
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
