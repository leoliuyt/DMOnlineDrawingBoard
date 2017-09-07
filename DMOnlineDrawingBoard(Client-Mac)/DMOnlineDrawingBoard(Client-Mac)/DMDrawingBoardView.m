//
//  DMDrawingBoardView.m
//  DMDrawingBoardForMac
//
//  Created by lbq on 2017/9/5.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMDrawingBoardView.h"
#import "Drawingboard.pbobjc.h"
#import <Quartz/Quartz.h>
#import <CoreVideo/CoreVideo.h>
#import "DMPoint+DM.h"

@interface DMDrawingBoardView()
{
    CVDisplayLinkRef _displayLink;
    CGDirectDisplayID _displayID;
}

@property (nonatomic, strong) NSMutableArray<DMStroke *> *strokes;
@property (nonatomic, strong) NSMutableArray <DMPoint *>*points;

@property (nonatomic, strong) NSBezierPath *path;

//@property (nonatomic, strong) NSDisplayLink *displayLink;

@property (nonatomic, assign) BOOL isChanging;

@end

@implementation DMDrawingBoardView

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    [self configureLayer];
    self.path = [NSBezierPath bezierPath];
    self.strokes = [NSMutableArray arrayWithCapacity:100];
    self.points = [NSMutableArray arrayWithCapacity:100];
    
//    [self configureCVDisplayLink];
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if(self.isChanging){
            [self setNeedsDisplay:YES];
        }
    }];
    return self;
}

- (void)configureCVDisplayLink
{
    _displayID = CGMainDisplayID();
    CVReturn            error = kCVReturnSuccess;
    error = CVDisplayLinkCreateWithCGDisplay(_displayID, &_displayLink);
    if (error)
    {
        NSLog(@"DisplayLink created with error:%d", error);
        _displayLink = NULL;
    }
    CVDisplayLinkSetOutputCallback(_displayLink, DisplayLinkCallback, (__bridge void *)self);
    
    CVDisplayLinkStart(_displayLink);
    
}

- (void)setPaint:(DMPaint *)paint
{
    _paint = paint;
    [self setNeedsDisplay:YES];
}

- (CVReturn)getFrameForTime:(const CVTimeStamp *)outputTime {
    NSLog(@"%s,%@",__func__,[NSThread mainThread]);
    if(self.isChanging){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsDisplay:YES];
        });
    }
    return kCVReturnSuccess;
}

static CVReturn DisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext) {
    @autoreleasepool {
        return [(__bridge DMDrawingBoardView *)displayLinkContext getFrameForTime:outputTime];
    }
}

- (void)configureLayer
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor = nil;
}

+(Class)layerClass{
    return [CAShapeLayer class];
}


- (void)mouseDown:(NSEvent *)event
{
    NSLog(@"mouseDown:%s---%@",__func__,NSStringFromPoint(event.locationInWindow));
//    NSValue *value = [NSValue valueWithPoint:event.locationInWindow];
    DMPoint *dmPoint = [DMPoint convertToDM:event.locationInWindow];
    [self.points removeAllObjects];
    [self.points addObject:dmPoint];
    DMStroke *stroke = [[DMStroke alloc] init];
    [self.strokes addObject:stroke];
    self.isChanging = YES;
}

- (void)mouseDragged:(NSEvent *)event
{
//    NSLog(@"mouseDragged:%s---%@",__func__,NSStringFromPoint(event.locationInWindow));
//    NSValue *value = [NSValue valueWithPoint:event.locationInWindow];
    DMPoint *dmPoint = [DMPoint convertToDM:event.locationInWindow];
    [self.points addObject:dmPoint];
    DMStroke *stroke = self.strokes.lastObject;
    stroke.pointsArray = [self.points copy];
}

- (void)mouseUp:(NSEvent *)event
{
    NSLog(@"mouseUp:%s---%@",__func__,NSStringFromPoint(event.locationInWindow));
    self.isChanging = NO;
}


- (void)mouseExited:(NSEvent *)event
{
    NSLog(@"%s",__func__);
}

- (void)mouseEntered:(NSEvent *)event
{
    NSLog(@"%s",__func__);
}

- (void)mouseMoved:(NSEvent *)event
{
    [super mouseMoved:event];
     NSLog(@"Move:%s---%@",__func__,NSStringFromPoint(event.locationInWindow));
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
//    NSLog(@"%s",__func__);
    [self.paint.strokesArray enumerateObjectsUsingBlock:^(DMStroke * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSBezierPath *path = [NSBezierPath bezierPath];
        path.lineWidth = 4;
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        [[NSColor redColor] setStroke];
//        [path strokeWithBlendMode:kCGBlendModeCopy alpha:1.0];
        [obj.pointsArray enumerateObjectsUsingBlock:^(DMPoint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSPoint point = [obj convertToCG];
            if (idx == 0) {
                NSLog(@"=========idx===%@",NSStringFromPoint(point));
                [path moveToPoint:point];
            } else {
                [path lineToPoint:point];
            }
        }];
        [path stroke];
    }];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    CVDisplayLinkStop(_displayLink);
    CVDisplayLinkRelease(_displayLink);
}

@end
