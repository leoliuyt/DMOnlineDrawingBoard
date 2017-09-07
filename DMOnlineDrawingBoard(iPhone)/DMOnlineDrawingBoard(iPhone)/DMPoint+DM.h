//
//  DMPoint+DM.h
//  DMOnlineDrawingBoard(iPhone)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "Drawingboard.pbobjc.h"
#import <UIKit/UIKit.h>

@interface DMPoint (DM)

+(instancetype)convertToDM:(CGPoint)aPoint;

-(CGPoint)convertToCG;

@end
