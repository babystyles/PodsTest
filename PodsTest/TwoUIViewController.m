//
//  TwoUIViewController.m
//  PodsTest
//
//  Created by 林泽琛 on 16/5/31.
//  Copyright © 2016年 林泽琛. All rights reserved.
//

#import "TwoUIViewController.h"
#import "Masonry.h"
#define WS __weak typeof(self) weakSelf= self;//防止循环引用
@interface TwoUIViewController ()

@end

@implementation TwoUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    WS;
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Back" forState:0];
    [button addTarget:self action:@selector(dismissScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        
    }];
    
    [self CreateScrollView];
}
-(void)CreateScrollView{
    
    WS;
    UIScrollView *scr=[UIScrollView new];
    scr.showsVerticalScrollIndicator=YES;
    [scr setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:scr];
    [scr mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置ScrollView四个方向的边缘距离，当然也可以使用top，left，right，bottom来分别设置，这里是合在一起设置了（edges）
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(80, 10, 10, 10));
    }];
    
    UIView *container = [UIView new];
    [scr addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scr);
        make.width.equalTo(scr);
    }];
    
    int count = 20;
    UIView *lastView = nil;
    
    // 循环便利位置约束
    for (int i = 0; i <= count; i++) {
        UIView *subView = [UIView new];
        [container addSubview:subView];
        // 随机色
        subView.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 200 / 256.0 ) + 0.5 alpha:1];
        
        // 为其添加约束
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            //
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(20 * i);
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        lastView = subView;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
}


-(void)dismissScrollView:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
