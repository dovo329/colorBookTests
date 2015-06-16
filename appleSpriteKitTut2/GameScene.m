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
    /* Setup your scene here */
    /*SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];*/
    
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"mtnHouseWithSun"];
        
    self.sprite.xScale = 1.0;
    self.sprite.yScale = 1.0;
    self.sprite.position = CGPointMake(0, 0);

    [self addChild:self.sprite];

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
    
    /* Called when a touch begins */
    
    /*for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"mtnHouseWithSun"];
        
        sprite.xScale = 0.2;
        sprite.yScale = 0.2;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }*/
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
