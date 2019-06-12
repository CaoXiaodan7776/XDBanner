//
//  DKPhotoLoopView.h
//  DKPhotoLooop_Demo
//
//  Created by DoubleK on 2016/11/30.
//  Copyright © 2016年 DoubleK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBannerModel.h"

@class DKPhotoLoopView;

@protocol DKPhotoLoopViewDelegate <NSObject>

//点击事件
- (void)loopView:(DKPhotoLoopView *)loopView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DKPhotoLoopView : UIView

- (id)initWithFrame:(CGRect)frame withImgsArr:(NSArray *)array;

- (id)initWithFrame:(CGRect)frame withImgsArr:(NSArray *)array timeInterval:(NSTimeInterval)timeInterval;

@property (nonatomic, weak) id<DKPhotoLoopViewDelegate> delegate;
@property (nonatomic, strong) NSArray<YFBannerModel *> *imgsArr;   //照片数组

@end
