//
//  Player.m
//  elel
//
//  Created by Chao on 16/8/4.
//  Copyright © 2016年 Chao. All rights reserved.
//

#import "Player.h"
#import "cocos2d.h"

@implementation Player

- (CCAnimation *)getAnimation:(NSString *)name{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 1; i < 5; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%@%d.png", name, i];
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:str];
        [array addObject:frame];
    }
    
    CCAnimation *aniamtion = [CCAnimation animationWithSpriteFrames:array delay:0.1];
    
    return aniamtion;
}

- (void)flying{
    
    if (isFlying) {
        
        return;
    }
    
    [self stopAllActions];

    CCActionAnimate *action = [CCActionAnimate actionWithAnimation:[self getAnimation:@"flying"]];
    
    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc] initWithAction:action];
    
    [self runAction:forever];
    
    isFlying = YES;
}

- (void)die{
    
    [[OALSimpleAudio sharedInstance] playEffect:@"hit.mp3"];
    [self stopAllActions];

    CCActionAnimate *action = [CCActionAnimate actionWithAnimation:[self getAnimation:@"die"]];

    [self runAction:action];
}

- (void)down{
    
    [self stopAllActions];
    CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:@"down.png"];
    self.spriteFrame = frame;
    isFlying = NO;
}

- (void)drop{
    
    [self stopAllActions];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 1; i < 4; i++) {
        
        NSString *str = [NSString stringWithFormat:@"drop%d.png", i];
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:str];
        [array addObject:frame];
    }
    
    CCAnimation *aniamtion = [CCAnimation animationWithSpriteFrames:array delay:0.1];
    
    CCActionAnimate *action = [CCActionAnimate actionWithAnimation:aniamtion];
    
    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc] initWithAction:action];
    
    [self runAction:forever];
    isFlying = NO;
}

- (CCProgressNode *)hpBackground{
    
    if (!_hpBackground) {
        
        CCSprite *sprite = [CCSprite spriteWithImageNamed:@"progress1.png"];
        _hpBackground = [CCProgressNode progressWithSprite:sprite];
        _hpBackground.type = CCProgressNodeTypeBar;
        _hpBackground.percentage = 100;
        _hpBackground.scale = 0.5;
        _hpBackground.anchorPoint = CGPointZero;
    }
 
    return _hpBackground;
}

- (CCProgressNode *)realHp{
    
    if (!_realHp) {
        
        CCSprite *sprite = [CCSprite spriteWithImageNamed:@"progress2.png"];
        _realHp = [CCProgressNode progressWithSprite:sprite];
        _realHp.type = CCProgressNodeTypeBar;
        _realHp.scale = 0.5;
        _realHp.midpoint = CGPointMake(0, 0.5);
        _realHp.barChangeRate = CGPointMake(1, 0);
        _realHp.anchorPoint = CGPointZero;
    }
    
    return _realHp;
}

@end
