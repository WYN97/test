//
//  ChannelModel.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

-(NSString *)description{
    return [NSString stringWithFormat:@"%@ %@",_tid,_tname];
}

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{

}

+(instancetype)channelsWithDic:(NSDictionary *)dic{
    ChannelModel *model = [[ChannelModel alloc]init];
//kvc
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


+(NSArray *)channels{
//    获取topic_news.json 文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];

//    转成二进制
    NSData *data = [NSData dataWithContentsOfFile:path];
    
//    反序列化
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //取出tList相对应的数组
    NSArray *arr = [dic objectForKey:@"tList"];
    
    //可变数组
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    
//    遍历数组
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChannelModel *model  = [self channelsWithDic:obj ];
        [arrM addObject:model];
        
    }];
   //排序
    [arrM sortUsingComparator:^NSComparisonResult(ChannelModel *obj1, ChannelModel * obj2) {
        return [obj1.tid compare:obj2.tid ];
    }];
    
    return arrM.copy;
}
@end
