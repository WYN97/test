//
//  ChannelModel.h
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject
//标签名
@property (nonatomic, copy) NSString *tname;
//标签id
@property (nonatomic, copy) NSString *tid;


+(NSArray *)channels;
@end
