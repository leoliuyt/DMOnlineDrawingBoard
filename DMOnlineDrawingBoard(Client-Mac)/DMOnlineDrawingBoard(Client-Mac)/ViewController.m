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

@interface ViewController()

@property (nonatomic, strong) DMDrawingBoardView *drawingBoardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
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
