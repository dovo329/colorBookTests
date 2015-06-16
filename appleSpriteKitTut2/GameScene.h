//
//  GameScene.h
//  appleSpriteKitTut2
//

//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PaletteFilter.h"

@interface GameScene : SKScene

@property (nonatomic, strong) SKSpriteNode *sprite;

@property (nonatomic, strong) PaletteFilter *paletteFilter;
@property (nonatomic, strong) SKEffectNode *paletteEffect;

@property (nonatomic, assign) CGPoint lastTranslatePoint;

@end
