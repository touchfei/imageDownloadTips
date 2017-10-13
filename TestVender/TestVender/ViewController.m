//
//  ViewController.m
//  TestVender
//
//  Created by gaofei on 2017/8/11.
//
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "FSTableViewCell.h"
#import "AFNetworking.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray<NSString *> *datas;
@end

@implementation ViewController

static NSString *identifier = @"cell";

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 200;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)datas {
    if (!_datas) {
        _datas = @[@"http://img.taopic.com/uploads/allimg/140330/234771-140330195Q491.jpg",
                   @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=328dc2296d09c93d13ff06b4f75492a9/71cf3bc79f3df8dc2a9a07b6c711728b47102876.jpg",
                   @"http://dl.bizhi.sogou.com/images/2012/02/27/203769.jpg",
                   @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=fa0e7a2bbb3533fae1bb9b6dc0ba976a/838ba61ea8d3fd1fa2e2511f3a4e251f95ca5f28.jpg",
                   @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=ae4e87268d94a4c21e2eef68669d71a0/7c1ed21b0ef41bd5d5a88edd5bda81cb39db3d1b.jpg",
                   @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=41bbfd0dba7eca80060831a4f94afda8/64380cd7912397dd52eec32a5382b2b7d0a2870d.jpg",
                   @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=41bbfd0dba7eca80060831a4f94afda8/64380cd7912397dd52eec32a5382b2b7d0a2870d.jpg",
                   @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=d23dcf1d22381f308a1485eac168267d/e824b899a9014c082214d580007b02087bf4f4ec.jpg"];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
}

- (void)loadData
{
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:nil];
    
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
    
//    NSURL *url = [NSURL URLWithString:@""];
    
//     [NSMutableURLRequest requestWithURL:url];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"www.baidu.com" parameters:parameters error:nil];
    
    NSSet<NSData *> *set = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:set];
    security.allowInvalidCertificates = true;
    
    
    mgr.securityPolicy = security;
    
    NSURLSessionDataTask *task = [mgr dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [task resume];
}


- (void)request
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.baidu.com"]];
    NSURLSession *seesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"add cell index = %ld",indexPath.row);
    FSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FSTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    cell.urlStr = self.datas[indexPath.row];
  
    return cell;
}


    
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue()))== 0) {
        
    }
}


@end
