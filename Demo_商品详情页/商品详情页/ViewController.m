//
//  ViewController.m
//  商品详情页
//
//  Created by 本农记 on 16/2/16.
//  Copyright © 2016年 韩秀辉. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "MJRefresh.h"
#import "UIView+Extension.h"

static NSString *tableViewReuseIdentifier = @"UITableViewCell";
static NSString *collectionViewReuseIdentifier = @"UICollectionViewCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

/** 商品详情整体 */
@property(strong,nonatomic)UIScrollView *scrollView;

/** 第一页 */
@property(strong,nonatomic)UITableView *tableView;

/** 第二页 */
@property (nonatomic, strong) UIView *twoPageView;
/** 网页 */
@property (strong,nonatomic)  UIWebView *webView;
/** 推荐商品视图 */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *goodsDetailButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *toolButton;

@end

@implementation ViewController

#pragma mark - Lazy Methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - kSTATUSBAR_NAVIGATION_HEIGHT - kTOOLHEIGHT)];
        _scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, (kSCREEN_HEIGHT - kSTATUSBAR_NAVIGATION_HEIGHT) * 2);
//        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UIButton *)toolButton {
    if (!_toolButton) {
        _toolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _toolButton.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), kSCREEN_WIDTH, kTOOLHEIGHT);
        _toolButton.backgroundColor = [UIColor colorWithRed:0.311 green:0.516 blue:1.000 alpha:1.000];
        [_toolButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_toolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toolButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _toolButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_toolButton setImage:[UIImage imageNamed:@"iconfont-cartfill"] forState:UIControlStateNormal];
        [_toolButton addTarget:self
                        action:@selector(publicClick)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.scrollView.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewReuseIdentifier];
    }
    return _tableView;
}

#pragma mark - 第二页
- (UIView *)twoPageView {
    if (!_twoPageView) {
        _twoPageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.tableView.width, self.tableView.height)];
    }
    return _twoPageView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodsDetailButton.frame), self.tableView.width, self.tableView.height - self.goodsDetailButton.height)];
    }
    return _webView;
}

- (UIButton *)goodsDetailButton {
    if (!_goodsDetailButton) {
        _goodsDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _goodsDetailButton.frame = CGRectMake(0, 0, self.tableView.width/2, 50);
        [_goodsDetailButton setTitle:@"图文详情" forState:UIControlStateNormal];
        [_goodsDetailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _goodsDetailButton.backgroundColor = [UIColor colorWithRed:1.000 green:0.551 blue:0.935 alpha:1.000];
        [_goodsDetailButton addTarget:self action:@selector(goodsDetailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsDetailButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame = CGRectMake(CGRectGetMaxX(self.goodsDetailButton.frame), 0, self.tableView.width/2, 50);
        [_commentButton setTitle:@"推荐商品" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentButton.backgroundColor = [UIColor colorWithRed:0.545 green:0.565 blue:1.000 alpha:1.000];
        [_commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kSCREEN_WIDTH/2 - 5, kSCREEN_WIDTH/2 - 5);
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.webView.frame collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.goodsDetailButton.frame), self.tableView.width, self.tableView.height - self.goodsDetailButton.height);
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewReuseIdentifier];
    }
    return _collectionView;
}


#pragma mark - View lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情页";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 添加子控件
    [self addSubView];
    
    // 添加子控件
    [self setupHeaderFooter];
    
    // 配置上拉和下拉操作
    [self configureRefresh];
}

#pragma mark - View lifeCycle
- (void)addSubView {
    [self.view    addSubview:self.scrollView];
    [self.view    addSubview:self.toolButton];
    [self.scrollView  addSubview:self.tableView];
    [self.scrollView  addSubview:self.twoPageView];
    [self.twoPageView addSubview:self.webView];
    [self.twoPageView addSubview:self.goodsDetailButton];
    [self.twoPageView addSubview:self.commentButton];
}

- (void)configureRefresh {
    // 动画时间
    CGFloat duration = 0.3f;
    
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.height);
        } completion:^(BOOL finished) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];
    self.tableView.footer = footer;
    
    
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //结束加载
            [self.webView.scrollView.header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor redColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    self.webView.scrollView.header = header;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    
    // 3.设置 UICollectionView 下拉显示商品详情
    MJRefreshGifHeader *cHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self.collectionView.header endRefreshing];
        }];
    }];
    cHeader.lastUpdatedTimeLabel.hidden = YES;
    [cHeader setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [cHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [cHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    header.stateLabel.textColor = [UIColor redColor];
    self.collectionView.header = cHeader;
}

- (void)setupHeaderFooter {
    // 头部
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    self.tableView.tableHeaderView = headerView;
    UIImageView *one = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NO.25_挪威"]];
    one.frame = headerView.bounds;
    [headerView addSubview:one];
    
    // 尾部
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 55)];
    self.tableView.tableFooterView = footerView;
    UIButton *randomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    randomButton.backgroundColor = [UIColor whiteColor];
    randomButton.frame = CGRectMake(50, 10, footerView.width - 100, 35.f);
    [randomButton setImage:[UIImage imageNamed:@"iconfont-homefill"] forState:UIControlStateNormal];
    [randomButton setTitle:@"进店逛逛" forState:UIControlStateNormal];
    [randomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    randomButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    randomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [randomButton addTarget:self
                     action:@selector(publicClick)
           forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:randomButton];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewReuseIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"商品详情 ~ ~ %zd  %zd",indexPath.section, indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewReuseIdentifier forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beauty3"]];
    return cell;
}

#pragma mark - Action methods
- (void)goodsDetailButtonClick {
    self.webView.hidden = NO;
    self.collectionView.hidden = YES;
    [self.twoPageView addSubview:self.webView];
}

- (void)commentButtonClick {
    self.webView.hidden = YES;
    self.collectionView.hidden = NO;
    [self.twoPageView addSubview:self.collectionView];
}

- (void)publicClick {
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
}
@end
