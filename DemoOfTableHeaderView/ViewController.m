//
//  ViewController.m
//  DemoOfTableHeaderView
//
//  Created by 吴 吴 on 16/9/12.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "ViewController.h"
#import "InfoHeaderView.h"
#import "CExpandHeader.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView    *infoTable;
    InfoHeaderView *infoHeaderView;
    UIImageView    *bkIcon;
    CExpandHeader  *expandHeader;
    
    UIImageView    *headerImageView;
}

@end

@implementation ViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavView];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 创建UI

- (void)setNavView {
    UIView *titleView                    = [[UIView alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
    titleView.backgroundColor            = [UIColor clearColor];
    self.navigationItem.titleView        = titleView;
    
    headerImageView                      = [[UIImageView alloc] init];
    headerImageView.frame                = CGRectMake((titleView.frame.size.width-68)/2,9,68,68);
    headerImageView.backgroundColor      = [UIColor redColor];
    headerImageView.layer.cornerRadius   = 34;
    headerImageView.layer.masksToBounds  = YES;
    headerImageView.clipsToBounds        = YES;
    [titleView addSubview:headerImageView];
}

- (void)setupUI {
    infoHeaderView                       = [[InfoHeaderView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.width)];
    infoHeaderView.backgroundColor       = [UIColor clearColor];
    
    infoTable                            = [[UITableView alloc]initWithFrame:CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height-64) style:UITableViewStylePlain];
    infoTable.backgroundColor            = [UIColor clearColor];
    infoTable.tableHeaderView            = infoHeaderView;
    infoTable.dataSource                 = self;
    infoTable.delegate                   = self;
    [self.view addSubview:infoTable];
    
    bkIcon                               = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.width)];
    bkIcon.backgroundColor               = [UIColor clearColor];
    bkIcon.clipsToBounds                 = YES;
    bkIcon.contentMode                   = UIViewContentModeScaleAspectFill;
    bkIcon.image                         = [UIImage imageNamed:@"bkIcon"];

    expandHeader                         = [CExpandHeader expandWithScrollView:infoTable expandView:bkIcon];
}


#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    CGFloat scale = 1.0;
    if (offsetY <= 0)
    {
        /**
         * 下拉放大,有上限值
         */
        scale = MIN(1.5, 1 - offsetY / 300);
    }
    else
    {
        /**
         * 上拉缩小,有上限值
         */
        scale = MAX(0.45, 1 - offsetY / 300);
    }
    /**
     *  进行缩放
     */
    headerImageView.transform = CGAffineTransformMakeScale(scale, scale);

    /**
     *  保证缩放过程中头像的y坐标不变
     */
    CGRect frame          = headerImageView.frame;
    frame.origin.y        = 9;
    headerImageView.frame = frame;
}

@end
