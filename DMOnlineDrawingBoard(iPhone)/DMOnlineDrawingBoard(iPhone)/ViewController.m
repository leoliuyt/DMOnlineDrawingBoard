//
//  ViewController.m
//  DMOnlineDrawingBoard(iPhone)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "ViewController.h"
#import "DMDrawingBoardView.h"
#import <Masonry.h>
#import <GCDAsyncSocket.h>


@interface ViewController ()<GCDAsyncSocketDelegate,DMDrawingBoardViewDelegate>

@property (nonatomic, strong) DMDrawingBoardView *drawingBoardView;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction:)];
    [self.navigationItem setRightBarButtonItem:rightItem];

    NSError *error;
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    BOOL isConnect =  [self.clientSocket connectToHost:@"127.0.0.1" onPort:2201 error:&error];
    if (isConnect) {
        NSLog(@"connect success");
    } else {
        NSLog(@"%@",error.localizedDescription);
    }
    self.drawingBoardView.delegate = self;
    [self.drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)sendAction:(id)sender
{
    NSString *str = @"aaa";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: DMDrawingBoardViewDelegate

- (void)sendData:(NSData *)data
{
     [self.clientSocket writeData:data withTimeout:-1 tag:0];
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
