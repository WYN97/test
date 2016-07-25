//
//  NetworlTool.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "NetworlTool.h"
#import <AFNetworking.h>
@implementation NetworlTool

static id _instancetype;
+(instancetype)sharedNetworlTool{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseurl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        _instancetype = [[self alloc]initWithBaseURL:baseurl];;
    });
    
    
    return _instancetype;
}
@end
