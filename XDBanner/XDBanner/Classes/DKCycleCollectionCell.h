//
//  DKCycleCollectionCell.h
//  DKPhotoLooop_Demo
//
//  Created by DoubleK on 2016/11/30.
//  Copyright © 2016年 DoubleK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEHomePageModel.h"
#import "YFBannerModel.h"

@interface DKCycleCollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<YFBannerModel *> *imgsArr;          //照片数组
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
