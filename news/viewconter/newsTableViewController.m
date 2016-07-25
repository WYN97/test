//
//  newsTableViewController.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/21.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "newsTableViewController.h"
#import "newsModel.h"
#import "newsTableViewCell.h"
@interface newsTableViewController ()
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation newsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setUrlstr:(NSString *)urlstr{
    NSLog(@"%@",urlstr);
    [newsModel downloadWithUrlstr:urlstr successBlock:^(NSArray *arr) {
        self.dataArr =arr;
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
    
    

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return  self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell" forIndexPath:indexPath];
    newsModel *model = self.dataArr[indexPath.row];
    NSString *Identifier;
    if (model.imgType) {
        Identifier = @"bigCell";
    }else if (model.imgextra.count == 2){
    Identifier = @"ImagesCell";
    }else{
    Identifier =@"BaseCell";
    }
    
    newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.model = model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    newsModel *model = self.dataArr[indexPath.row];
    if (model.imgType) {
        return 180;
    }else if (model.imgextra.count == 2){
    
        return 150;
    }
    else{
    
        return 80;
    
    
    }
}

@end
