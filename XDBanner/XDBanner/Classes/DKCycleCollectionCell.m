//
//  DKCycleCollectionCell.m
//  DKPhotoLooop_Demo
//
//  Created by DoubleK on 2016/11/30.
//  Copyright © 2016年 DoubleK. All rights reserved.
//

#import "DKCycleCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Corners.h"
@interface DKCycleCollectionCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation DKCycleCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, self.width, self.height - 4)];
//    [_imgView setCornerRadius:CGSizeMake(6, 6)];
    [self.contentView addSubview:_imgView];
}

- (void)setImgsArr:(NSArray *)imgsArr
{
    if (_imgsArr != imgsArr) {
        _imgsArr = imgsArr;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    if (_indexPath != indexPath) {
        _indexPath = indexPath;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    YFBannerModel *model = [self.imgsArr objectAtIndexSafe:self.indexPath.row];
//    [_imgView setImage:[UIImage imageNamed:imgName]];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
}

@end
