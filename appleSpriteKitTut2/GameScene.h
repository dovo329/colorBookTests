//
//  GameScene.h
//  appleSpriteKitTut2
//

//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, assign) CGPoint lastTranslatePoint;

@end
