//
//  GameScene.h
//
//  Created by : Chao
//  Project    : elel
//  Date       : 16/8/3
//
//  Copyright (c) 2016年 Chao.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "chipmunk.h"

@class Player;

@interface GameScene : CCScene<CCPhysicsCollisionDelegate>
{
    CCTiledMap *map;
    CCPhysicsNode *physicsWorld;
    Player *player;
    BOOL bGameOver;
}

@property (nonatomic, strong) NSArray *distanceBgArray;
@property (nonatomic, strong) NSArray *nearbyBgArray;

- (instancetype)init;

// -----------------------------------------------------------------------

@end


































