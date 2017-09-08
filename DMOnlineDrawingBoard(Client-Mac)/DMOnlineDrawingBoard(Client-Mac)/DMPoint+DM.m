//
//  DMPoint+DM.m
//  DMOnlineDrawingBoard(iPhone)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMPoint+DM.h"
#import <Cocoa/Cocoa.h>

@implementation DMPoint (DM)

+(instancetype)convertToDM:(NSPoint)aPoint
{
    DMPoint *point = [DMPoint new];
    point.x = aPoint.x;
    point.y = aPoint.y;
    return point;
}

-(NSPoint)convertToCG
{
    return NSMakePoint(self.x, self.y);
}

//将iOS 左手坐标系转换成osx上的右手坐标系
- (DMPoint *)convertCoordinate:(CGSize)size
{
    DMPoint *point = [DMPoint new];
    point.x = size.width * self.x / self.boardW;
    point.y =  size.height - size.height * self.y / self.boardH;
    return point;
}

@end
