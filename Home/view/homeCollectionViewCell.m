//
//  homeCollectionViewCell.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/21.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "homeCollectionViewCell.h"
#import "newsTableViewController.h"

@interface homeCollectionViewCell ()
@property (nonatomic, strong) newsTableViewController *newsVC;

@end
@implementation homeCollectionViewCell


-(void)awakeFromNib{
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"news" bundle:nil ];
    self.newsVC = [Storyboard instantiateInitialViewController];
    self.newsVC.tableView.frame =self.contentView.bounds;
   
    self.newsVC.tableView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.newsVC.tableView];
    
}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    self.newsVC.urlstr= urlStr;

}





@end
