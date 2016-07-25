//
//  cycleCollectionViewCell.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/21.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "cycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>


@interface cycleCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end



@implementation cycleCollectionViewCell
-(void)setModel:(cycleModel *)model{
    _model = model;
    
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    self.titleLab.text =model.title;
    

}
@end
