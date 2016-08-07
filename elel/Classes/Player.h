//
//  Player.h
//  elel
//
//  Created by Chao on 16/8/4.
//  Copyright © 2016年 Chao. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Player : CCSprite
{
    BOOL isFlying;
}

@property (nonatomic, strong) CCProgressNode *realHp;
@property (nonatomic, strong) CCProgressNode *hpBackground;

- (void)flying;
- (void)die;
- (void)drop;
- (void)down;

@end
