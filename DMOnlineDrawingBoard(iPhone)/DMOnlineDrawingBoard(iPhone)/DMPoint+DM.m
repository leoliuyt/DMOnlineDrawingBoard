//
//  DMPoint+DM.m
//  DMOnlineDrawingBoard(iPhone)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMPoint+DM.h"

@implementation DMPoint (DM)

+(instancetype)convertToDM:(CGPoint)aPoint
{
    DMPoint *point = [DMPoint new];
    point.x = aPoint.x;
    point.y = aPoint.y;
    point.boardW = CGRectGetWidth([UIScreen mainScreen].bounds);
    point.boardH = CGRectGetHeight([UIScreen mainScreen].bounds);
    return point;
}

-(CGPoint)convertToCG
{
    return CGPointMake(self.x, self.y);
}
@end
