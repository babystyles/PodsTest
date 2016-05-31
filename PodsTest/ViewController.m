//
//  ViewController.m
//  PodsTest
//
//  Created by 林泽琛 on 16/5/27.
//  Copyright © 2016年 林泽琛. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "TwoUIViewController.h"
#define WS __weak typeof(self) weakSelf= self;//防止循环引用
@interface ViewController ()<UITextFieldDelegate>
{
    UIView *vi;
    UITextField *textfield;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS;//宏的使用
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"ScrollView" forState:0];
    [button addTarget:self action:@selector(CreateScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //为控件添加约束mas_makeConstraints
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       //设置button的宽高
        make.size.mas_equalTo(CGSizeMake(100, 50));
        //设置button与顶部的约束
        make.top.mas_equalTo(40);
        //设置button相对X轴居中
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        
    }];
    
    
    
    vi=[UIView new];
    [vi setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:vi];
    
    
    [vi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        //设置vi的底部约束等于self.view底部（记住底部和右侧都是负值）
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    UIView *vi1=[UIView new];
    UIView *vi2=[UIView new];
    [vi1 setBackgroundColor:[UIColor yellowColor]];
    [vi2 setBackgroundColor:[UIColor yellowColor]];
    [vi addSubview:vi1];
    [vi addSubview:vi2];
    int padding=10;
    [vi1 mas_makeConstraints:^(MASConstraintMaker *make) {
      
        //相对Y轴居中
        make.centerY.mas_equalTo(vi.mas_centerY);
        //左侧约束
        make.left.mas_equalTo(vi.mas_left).with.offset(padding);
        //右侧约束（记住底部和右侧都是负值）
        make.right.mas_equalTo(vi2.mas_left).with.offset(-padding);
        //设置宽高
        make.height.mas_equalTo(@100);
        make.width.mas_equalTo(vi2);
        
        
    }];
    
    [vi2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(vi.mas_centerY);
        //with或者and在这里只是一个连接词，提高代码可读性
        make.left.mas_equalTo(vi1.mas_right).with.offset(padding);
        make.right.mas_equalTo(vi.mas_right).with.offset(-padding);
        make.height.mas_equalTo(@100);
        make.width.mas_equalTo(vi1);
        
        
    }];
    textfield=[UITextField new];
    textfield.delegate=self;
    textfield.placeholder=@"请输入文字";
    [textfield setBackgroundColor:[UIColor whiteColor]];
    [vi addSubview:textfield];
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
       //相对vi1的底部设置约束
        make.top.mas_equalTo(vi1.mas_bottom).with.offset(4*padding);
        make.left.equalTo(vi.mas_left).with.offset(padding);
        make.right.equalTo(vi.mas_right).with.offset(-padding);
        make.bottom.mas_equalTo(vi.mas_bottom).with.offset(-padding);
       //备注：如果你上下左右约束设置好，他会自动计算宽高
        
    }];
    //键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //点击return 键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    [textField resignFirstResponder];
    return YES;
}
-(void)keyboardWillAppear:(NSNotification *)noti{
    //获取键盘的高度和动画
    NSDictionary *userinfo=[noti userInfo];
    CGRect rect=[userinfo [UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardheight=CGRectGetHeight(rect);
    CGFloat keyboardDuration=[userinfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    WS;
    //更新之前的约束mas_updateConstraints
    [vi mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(-keyboardheight);
        
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}
-(void)keyboardWillDisappear:(NSNotification *)noti{
    
    NSDictionary *userinfo=[noti userInfo];
//    CGRect rect=[userinfo [UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGFloat keyboardheight=CGRectGetHeight(rect);
    CGFloat keyboardDuration=[userinfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    WS;
    [vi mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}
//点击页面任何位置键盘消失
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [textfield resignFirstResponder];
}
-(void)CreateScrollView:(UIButton *)button{
    
    TwoUIViewController *two=[TwoUIViewController new];
    [self presentViewController:two animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
