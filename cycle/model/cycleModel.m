//
//  cycleModel.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/21.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "cycleModel.h"
#import "NetworlTool.h"
@implementation cycleModel
//字典转模型
+(instancetype)CycleModelWithDic:(NSDictionary *)dic
{
    cycleModel *model = [[cycleModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}


+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void (^)(NSArray *))successBlock failBlock:(void (^)(NSError *))failBlock{

    [[NetworlTool sharedNetworlTool]GET:urlstr parameters:nil  progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *Arr = [responseObject objectForKey:key];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:Arr.count];
        [Arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            cycleModel *model = [self CycleModelWithDic:obj];
            
            
            [arrM addObject:model];
            
            
            
        }];
        
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
        
        
        
    }];







}








@end












