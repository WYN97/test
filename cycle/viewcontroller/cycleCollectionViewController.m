//
//  cycleCollectionViewController.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/21.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "cycleCollectionViewController.h"
#import "cycleModel.h"
#import "cycleCollectionViewCell.h"

@interface cycleCollectionViewController ()
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

@end

@implementation cycleCollectionViewController

static NSString * const reuseIdentifier = @"Cell";



-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    self.FlowLayout.itemSize = self.collectionView.bounds.size;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createPageControl];
    
    [self loadCycleModelData];


}

- (void)createPageControl {
    self.pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:self.pageControl];

    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];

}



-(void)loadCycleModelData{

    
    [cycleModel loadCycleDataWithUrlstr:@"ad/headline/0-4.html" successBlock:^(NSArray *listArr) {
        self.dataArr = listArr;
        [self.collectionView reloadData];
        self.pageControl.numberOfPages = self.dataArr.count;
        
        CGSize papeContolSize = [self.pageControl sizeForNumberOfPages:self.dataArr.count];
        CGFloat pageControlX = self.view.bounds.size.width - papeContolSize.width - 10;
        
        CGFloat pageControlY = self.view.bounds.size.height -papeContolSize.height;
        
        self.pageControl.frame = CGRectMake(pageControlX, pageControlY, papeContolSize.width, papeContolSize.height);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
    
 
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    self.pageControl.currentPage = index%self.dataArr.count;
    NSIndexPath *indexPath;
    
    
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    if (index == 0) {
        indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
        
    }else if (index == items -1 ){
    
        indexPath = [NSIndexPath indexPathForItem:self.dataArr.count -1  inSection:0];
    
    
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];

}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.dataArr.count * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    cycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    cycleModel *model = self.dataArr[indexPath.item%self.dataArr.count];
    // Configure the cell
    cell.model = model;
    return cell;
}



@end
