//
//  DMPoint+DM.m
//  DMOnlineDrawingBoard(iPhone)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMPoint+DM.h"

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
@end
