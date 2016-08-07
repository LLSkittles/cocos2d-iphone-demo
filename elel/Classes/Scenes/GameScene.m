//
//  GameScene.m
//
//  Created by : Chao
//  Project    : elel
//  Date       : 16/8/3
//
//  Copyright (c) 2016年 Chao.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameScene.h"
#import "Player.h"
#import "bird.h"
#import "airship.h"
#import "heart.h"

// -----------------------------------------------------------------------

@implementation GameScene

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");
    
    [self creatSprite];
    [self playerFlyToScene];
    
    return self;
}

- (void)creatSprite{
    
    physicsWorld = [CCPhysicsNode node];
    physicsWorld.gravity = CGPointMake(0, -98);
//    physicsWorld.debugDraw = YES;
    physicsWorld.collisionDelegate = self;
    
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"bj2.jpg"];
    [bg setPosition:CGPointMake(0, 0)];
    bg.anchorPoint = CGPointZero;
    bg.scale = 0.5;
    CCSprite *distanceBg1 = [CCSprite spriteWithImageNamed:@"b2.png"];
    [distanceBg1 setPosition:CGPointMake(0, 10)];
    distanceBg1.anchorPoint = CGPointZero;
    distanceBg1.scale = 0.5;
    
    CCSprite *distanceBg2 = [CCSprite spriteWithImageNamed:@"b2.png"];
    [distanceBg2 setPosition:CGPointMake(distanceBg1.ELwidth, 10)];
    distanceBg2.anchorPoint = CGPointZero;
    distanceBg2.scale = 0.5;
    
    _distanceBgArray = @[distanceBg1, distanceBg2];
    
    CCSprite *nearbyBg1 = [CCSprite spriteWithImageNamed:@"b1.png"];
    [nearbyBg1 setPosition:CGPointMake(0, 0)];
    nearbyBg1.anchorPoint = CGPointZero;
    nearbyBg1.scale = 0.5;
    
    CCSprite *nearbyBg2 = [CCSprite spriteWithImageNamed:@"b1.png"];
    [nearbyBg2 setPosition:CGPointMake(nearbyBg1.ELwidth, 0)];
    nearbyBg2.anchorPoint = CGPointZero;
    nearbyBg2.scale = 0.5;
    
    _nearbyBgArray = @[nearbyBg1, nearbyBg2];
    
    [self addChild:bg z:-4];
    [self addChild:distanceBg1 z:-3];
    [self addChild:distanceBg2 z:-3];
    [self addChild:nearbyBg1 z:-2];
    [self addChild:nearbyBg2 z:-2];
    
    [self addChild:physicsWorld];
    
    
    CCParticleSystem *em = [[CCParticleSystem alloc] initWithFile:@"dirt.plist"];
    [em setPosition:CGPointMake(300, 300)];
    [physicsWorld addChild:em];
    
    map = [CCTiledMap tiledMapWithFile:@"map.tmx"];
    [map setAnchorPoint:CGPointZero];
    [map setScale:0.5];
    [physicsWorld addChild:map];
    
    [self addBody:@"heart"];
    [self addBody:@"airship"];
    [self addBody:@"bird"];
    [self addGround];
}

- (void)playerFlyToScene{
    
    [self addPlayer];

    [player flying];
    //入场
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:4 position:CGPointMake(200, 200)];
    CCActionCallBlock *callBack = [CCActionCallBlock actionWithBlock:^{
        
        player.physicsBody.affectedByGravity = YES;
        [self setUserInteractionEnabled:YES];
        [player drop];
        [self addHpProgress];
        [self schedule:@selector(everySecond:) interval:1.0/60];
    }];
    
    CCActionSequence *sequence = [CCActionSequence actionWithArray:@[moveTo, callBack]];
    
    [player runAction:sequence];
}

- (void)addGround{
    
    CCNode *node = [CCNode node];
    CCPhysicsBody *ground = [CCPhysicsBody bodyWithRect:CGRectMake(0, 62, [[CCDirector sharedDirector] viewSize].width, 1) cornerRadius:0];
    ground.collisionType = @"ground";
    ground.type = CCPhysicsBodyTypeStatic;
    ground.surfaceVelocity = CGPointMake(0, 0);
    ground.friction = 0;
    ground.elasticity = 0;
    ground.density = 0;
    [node setPhysicsBody:ground];
    [physicsWorld addChild:node];
}

- (void)addBody:(NSString *)name{
    
    CCTiledMapObjectGroup *group = [map objectGroupNamed:name];
    NSMutableArray *objects = group.objects;
    for (NSDictionary *dic in objects) {
        float x = [dic[@"x"] floatValue];
        float y = [dic[@"y"] floatValue];
        
        Class class = NSClassFromString(name);
        CCSprite *sprite = [class spriteWithImageNamed:[NSString stringWithFormat:@"%@.png", name]];
        CCPhysicsBody *body = [CCPhysicsBody bodyWithCircleOfRadius:sprite.ELwidth/2 andCenter:CGPointMake(sprite.ELwidth/2, sprite.ELheight/2)];
        body.type = CCPhysicsBodyTypeStatic;
        body.collisionType = name;
        [sprite setPhysicsBody:body];
        [sprite setPosition:CGPointMake(x, y)];
        [map addChild:sprite];
    }
}

- (void)addPlayer{
    
    player = [Player spriteWithImageNamed:@"flying1.png"];
    player.position = CGPointMake(-30, 200);
    player.scale = 0.5;
    CCPhysicsBody *body = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0, 63, 155) cornerRadius:0];
    body.collisionType = @"player";
    player.physicsBody = body;
    player.physicsBody.affectedByGravity = NO;
    [physicsWorld addChild:player];
}

- (void)addHpProgress{
    
    CCProgressNode *hp = player.hpBackground;
    hp.position = CGPointMake(10, 320 - 40);
    
    CCProgressNode *realhp = player.realHp;;
    realhp.percentage = 100;
    realhp.position = CGPointMake(10, 320 - 40);
    
    [self addChild:hp];
    [self addChild:realhp];
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(Player *)nodeA heart:(CCNode *)nodeB{
    
    CCParticleSystem *em = [[CCParticleSystem alloc] initWithFile:@"stars.plist"];
    em.blendAdditive = YES;
    em.position = nodeB.position;
    [map addChild:em];

    nodeA.realHp.percentage  += 5;
    
    [nodeB removeFromParent];
    
    
    return NO;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(Player *)nodeA bird:(CCNode *)nodeB{

    nodeA.realHp.percentage  -= 5;
    [self gameOver];

    [nodeB removeFromParent];
    
    
    return NO;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(Player *)nodeA airship:(CCNode *)nodeB{

    nodeA.realHp.percentage  -= 5;
    [self gameOver];
    [nodeB removeFromParent];
    
    return NO;
}


-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(Player *)nodeA ground:(CCNode *)nodeB{
    

    if (!bGameOver) {

        [player down];
    }
    
    return YES;
}


-(void)everySecond:(CCTime)delta {
    
    player.realHp.percentage  -= 0.05;
    [self gameOver];

    CGSize visiableSize = [[CCDirector sharedDirector] viewSize];
    
    CCSprite *bg1 = _distanceBgArray[0];
    CCSprite *bg2 = _distanceBgArray[1];
    
    if(bg2.position.x <= 0){
        
        [bg1 setPosition:CGPointMake(0, bg1.position.y)];
    }
    
    float x1 = [bg1 position].x - 50 * delta;
    float x2 = bg2.ELwidth + x1;
    [bg1 setPosition:CGPointMake(x1, bg1.position.y)];
    [bg2 setPosition:CGPointMake(x2, bg2.position.y)];
    
    CCSprite *bg3 = _nearbyBgArray[0];
    CCSprite *bg4 = _nearbyBgArray[1];
    
    if(bg4.position.x <= 0){
        
        [bg3 setPosition:CGPointMake(0, bg3.position.y)];
    }
    
    float x3 = [bg3 position].x - 100 * delta;
    float x4 = bg4.ELwidth + x3;
    [bg3 setPosition:CGPointMake(x3, bg3.position.y)];
    [bg4 setPosition:CGPointMake(x4, bg4.position.y)];
    
    if (map.position.x <= visiableSize.width - map.ELwidth) {
        
        [self unschedule:@selector(everySecond:)];
    }
    CGPoint position = map.position;
    [map setPosition:CGPointMake(position.x - 130 * delta, position.y)];
}

- (void)gameOver{
    
    if (player.realHp.percentage <= 0) {
        
        bGameOver = YES;
        [self unscheduleAllSelectors];
        self.userInteractionEnabled = NO;
        [player die];
        
        CGSize visiableSize = [[CCDirector sharedDirector] viewSize];
        CCSprite *gameOver = [CCSprite spriteWithImageNamed:@"over.png"];
        gameOver.position = CGPointMake(visiableSize.width/2, visiableSize.height/2);
        gameOver.scale = 0.5;
        [self addChild:gameOver];
    }
}

#pragma mark - touch event
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
    player.physicsBody.velocity = CGPointZero;
    physicsWorld.gravity = CGPointMake(0, 98);
    [player flying];
}


-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
    player.physicsBody.velocity = CGPointZero;
    physicsWorld.gravity = CGPointMake(0, -98);
    [player drop];
}

@end























// why not add a few extra lines, so we dont have to sit and edit at the bottom of the screen ...
