//
//  ViewController.m
//  DMOnlineDrawingBoard(Client-Mac)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "ViewController.h"
#import "DMDrawingBoardView.h"
#import <Masonry.h>
#import <GCDAsyncSocket.h>
#import "Drawingboard.pbobjc.h"

@interface ViewController()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) DMDrawingBoardView *drawingBoardView;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error;
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    BOOL isConnect =  [self.clientSocket connectToHost:@"127.0.0.1" onPort:2201 error:&error];
    if (isConnect) {
        NSLog(@"connect success");
    } else {
        NSLog(@"%@",error.localizedDescription);
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self readData];
    }];
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    
    [self.drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)readData
{
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

//MARK: GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"%s",__func__);
}
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%s",__func__);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"%@",sock);
    NSError *error;
    DMPaint *paint = [DMPaint parseFromData:data
                                      error:&error];
    if (!error) {
        self.drawingBoardView.paint = paint;
    }
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%@",sock);
}


//MARK: lazy
- (DMDrawingBoardView *)drawingBoardView
{
    if(!_drawingBoardView){
        _drawingBoardView = [[DMDrawingBoardView alloc] init];
        [self.view addSubview:_drawingBoardView];
    }
    return _drawingBoardView;
}
@end
