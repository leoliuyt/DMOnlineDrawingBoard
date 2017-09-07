//
//  ViewController.m
//  DMOnlineDrawingBoard(Server)
//
//  Created by lbq on 2017/9/7.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "ViewController.h"
#import <GCDAsyncSocket.h>
@interface ViewController()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;

@property (nonatomic, strong) NSMutableArray<GCDAsyncSocket *> *acceptSockets;

@property (weak) IBOutlet NSTextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.acceptSockets = [[NSMutableArray alloc] initWithCapacity:2];
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//    self.serverSocket.delegate = self;
}

- (IBAction)enterAction:(id)sender {
    
    NSError *error;
    BOOL isAccept = [self.serverSocket acceptOnPort:[self.textfield.stringValue integerValue]error:&error];
    if (isAccept) {
        NSLog(@"accept");
    } else {
        NSLog(@"%@",error.localizedDescription);
    }
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

//MARK: GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"%s",__func__);
    [self.acceptSockets addObject:newSocket];
    [newSocket readDataWithTimeout:-1
                               tag:self.acceptSockets.count];
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%s",__func__);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    // 直接进行转发数据
    for (GCDAsyncSocket *clientSocket in self.acceptSockets) {
        if (sock != clientSocket) {
            
            [clientSocket writeData:data
                        withTimeout:-1
                                tag:0];
        }
    }
    [sock readDataWithTimeout:-1
                          tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%@",sock);
}

@end
