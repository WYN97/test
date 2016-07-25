//
//  newsModel.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "newsModel.h"
#import "NetworlTool.h"
@implementation newsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
+(instancetype)NewsModelWithDic:(NSDictionary *)dic {

    newsModel *model = [[newsModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}


+(void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock{

    
    
    [[NetworlTool sharedNetworlTool]GET:urlstr parameters:nil  progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        NSDictionary *dic = responseObject;
        NSString *key = dic.keyEnumerator.nextObject;
        NSArray *arr = [dic objectForKey:key];
        NSMutableArray *arrM  = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            newsModel *model  =[self NewsModelWithDic:obj ];
            [arrM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];


}

























@end


















