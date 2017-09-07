//
//  DMDrawingBoardView.h
//  DMDrawingBoardForMac
//
//  Created by lbq on 2017/9/5.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Drawingboard.pbobjc.h"

@interface DMDrawingBoardView : NSView

@property (nonatomic, strong) DMPaint *paint;
@end
