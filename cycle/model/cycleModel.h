//
//  cycleModel.h
//  网易新闻
//
//  Created by 王玉牛 on 16/7/21.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cycleModel : NSObject
//轮播图标题
@property (nonatomic, copy) NSString *title;
//轮播图片
@property (nonatomic, copy) NSString *imgsrc;
//下载方法
+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void(^)(NSError *error))failBlock;
@end
