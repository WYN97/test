//
//  homeViewController.m
//  网易新闻
//
//  Created by 王玉牛 on 16/7/19.
//  Copyright © 2016年 niuniu. All rights reserved.
//

#import "homeViewController.h"
#import "ChannelModel.h"
#import "channelLab.h"
#import "homeCollectionViewCell.h"
@interface homeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ChannelScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *NewsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;
//数据接收
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSMutableArray *labM;
@end

@implementation homeViewController

-(NSMutableArray *)labM{
    if (!_labM) {
        _labM=[NSMutableArray array];
    }

    
    return _labM;
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [ChannelModel channels];
    }

    return _dataArr;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.FlowLayout.itemSize = self.NewsCollectionView.bounds.size;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatChannelLab];
}

- (void)creatChannelLab {
    int labW = 80;
    int labH = self.ChannelScrollView.bounds.size.height;
    for (int i = 0;  i < self.dataArr.count; i ++ ) {
        channelLab *lab = [[channelLab alloc]init];
        
        lab.frame = CGRectMake(labW *i , 0,  labW, labH);
        ChannelModel *model = self.dataArr[i ];
        lab.text = model.tname;
        lab.tag = i ;
        [self.ChannelScrollView addSubview:lab];
        self.ChannelScrollView.contentSize = CGSizeMake(labW *self.dataArr.count, 0);
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [lab addGestureRecognizer:tap];
        //设置lab可以点击
        lab.userInteractionEnabled = YES;
        
        //把lab添加到频道数组里面
        [self.labM addObject:lab];
        
    }


}
//点击频道的方法
-(void)tapClick:(UIGestureRecognizer *)tap
{
    //获取选中的lab
    channelLab *lab = (channelLab *)tap.view;
    
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labOffsetX = lab.center.x - self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.ChannelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labOffsetX < minOffsetX) {
        labOffsetX = 0;
    }else if(labOffsetX > maxOffsetX)
    {
        labOffsetX = maxOffsetX;
    }
    
    // 设置频道滚动视图的滚动
    [self.ChannelScrollView setContentOffset:CGPointMake(labOffsetX, 0) animated:YES];
    
#pragma mark - 点击频道标签居中时,collectionView也跟着联动
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lab.tag inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}

#pragma mark - 监听底部conllectionView的滚动 : 滚动结束的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算滚动到第几个索引
    NSInteger index = scrollView.contentOffset.x /scrollView.bounds.size.width;
    //根据标签去找lab
    channelLab *lab = self.labM[index];
    
    //lab滚动的偏移量
    CGFloat labOffSetX = lab.center.x - self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.ChannelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labOffSetX < minOffsetX) {
        labOffSetX = 0;
    }else if(labOffSetX > maxOffsetX)
    {
        labOffSetX = maxOffsetX;
    }
    
    
    //真正的滚动channelScollview
    [self.ChannelScrollView setContentOffset:CGPointMake(labOffSetX, 0) animated:YES];
    
    
}
#pragma mark
#pragma mark -数据原方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    homeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ChannelModel *model = self.dataArr[indexPath.item];
    
    NSString *urlstr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    
    cell.urlStr = urlstr;

    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
