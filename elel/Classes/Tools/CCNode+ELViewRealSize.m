//
//  CCNode+ELViewRealSize.m
//  elel
//
//  Created by Chao on 16/8/7.
//  Copyright © 2016年 Chao. All rights reserved.
//

#import "CCNode+ELViewRealSize.h"

@implementation CCNode (ELViewRealSize)

- (CGFloat)ELheight{
    
    CGSize size = self.boundingBox.size;
    
    return size.height;
}

- (CGFloat)ELwidth{
    
    CGSize size = self.boundingBox.size;
    
    return size.width;
}

@end

