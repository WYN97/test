//
//  newsModel.h
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSArray *imgextra;
@property (nonatomic, assign) BOOL imgType;

+(void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock  failureBlock:(void (^)(NSError *error))failureBlock;


@end
