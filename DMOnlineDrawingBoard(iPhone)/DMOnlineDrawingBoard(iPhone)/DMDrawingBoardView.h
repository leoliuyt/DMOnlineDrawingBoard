//
//  DMDrawingBoardView.h
//  DMDrawingBoard
//
//  Created by lbq on 2017/9/4.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMDrawingBoardViewDelegate <NSObject>

- (void)sendData:(NSData *)data;

@end
@interface DMDrawingBoardView : UIView

@property (nonatomic, weak) id<DMDrawingBoardViewDelegate> delegate;
@end
