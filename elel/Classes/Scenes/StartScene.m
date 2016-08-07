//
//  StartScene.m
//
//  Created by : Chao
//  Project    : elel
//  Date       : 16/8/7
//
//  Copyright (c) 2016年 Chao.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "StartScene.h"
#import "cocos2d-ui.h"
#import "GameScene.h"

// -----------------------------------------------------------------

@implementation StartScene

- (instancetype)init{
    
    self = [super init];
    
    [self creatSprites];
    
    return self;
}

- (void)creatSprites{
    
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"main.jpg"];
    bg.anchorPoint = CGPointZero;
    bg.scale = 0.5;
    [self addChild:bg];
    
    CCSpriteFrame *normal = [CCSpriteFrame frameWithImageNamed:@"start1.png"];
    CCButton *startGame = [CCButton buttonWithTitle:nil spriteFrame:normal];
    startGame.scale = 0.5;
    startGame.position = CGPointMake(100, bg.ELheight / 2);
    [startGame setTarget:self selector:@selector(startGame:)];
    [self addChild:startGame];
    
    CCSprite *title = [CCSprite spriteWithImageNamed:@"title.png"];
    title.position = CGPointMake(bg.ELwidth - title.ELwidth / 3, bg.ELheight/2);
    title.scale = 0.5;
    [self addChild:title];
    
    CCActionMoveBy *move1 = [CCActionMoveBy actionWithDuration:0.5 position:CGPointMake(0, 10)];
    CCActionMoveBy *move2 = [CCActionMoveBy actionWithDuration:0.5 position:CGPointMake(0, -10)];
    CCActionSequence *sequence = [CCActionSequence actionWithArray:@[move1, move2]];
    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc] initWithAction:sequence];
    [title runAction:forever];

}

- (void)startGame:(CCButton *)btn{
    
    [[OALSimpleAudio sharedInstance] playEffect:@"button.wav"];
    
    [[CCDirector sharedDirector] replaceScene:[GameScene new] withTransition:[CCTransition transitionFadeWithDuration:0.8]];
}

@end





