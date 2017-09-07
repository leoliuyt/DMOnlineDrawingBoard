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

@interface ViewController ()

@property (nonatomic, strong) DMDrawingBoardView *drawingBoardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DMDrawingBoardView *)drawingBoardView
{
    if(!_drawingBoardView){
        _drawingBoardView = [[DMDrawingBoardView alloc] init];
        [self.view addSubview:_drawingBoardView];
    }
    return _drawingBoardView;
}
@end
