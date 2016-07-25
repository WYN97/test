//
//  NetworlTool.h
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetworlTool : AFHTTPSessionManager
+(instancetype)sharedNetworlTool;
@end
