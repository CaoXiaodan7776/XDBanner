//
//  DKBannerModel.h
//  YFEducation
//
//  Created by Fearless on 2019/3/26.
//  Copyright © 2019 zdyc. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface DKBannerModel : NSObject
@property (nonatomic, copy)     NSString *picUrl;
/**关联url （链接地址）*/
@property (nonatomic, copy)     NSString *relContent;
/**跳转类型 */
@property (nonatomic, assign)   NSInteger jumpType;
@end



NS_ASSUME_NONNULL_END
