//
//  Bird.m
//
//  Created by : Chao
//  Project    : elel
//  Date       : 16/8/5
//
//  Copyright (c) 2016年 Chao.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "bird.h"

// -----------------------------------------------------------------

@implementation bird

- (id)initWithImageNamed:(NSString *)imageName{
    
    self = [super initWithImageNamed:@"bird1.png"];
    if (self) {
        
        [self addAction];
    }
    
    return self;
}

- (CCAnimation *)getAnimation:(NSString *)name{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 1; i < 10; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%@%d.png", name, i];
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:str];
        [array addObject:frame];
    }
    
    CCAnimation *aniamtion = [CCAnimation animationWithSpriteFrames:array delay:0.1];
    
    return aniamtion;
}

- (void)addAction{
    
    CCActionAnimate *action = [CCActionAnimate actionWithAnimation:[self getAnimation:@"bird"]];
    
    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc] initWithAction:action];
    
    [self runAction:forever];
}

@end





