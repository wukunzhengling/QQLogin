//
//  ViewController.m
//  QQLogin
//
//  Created by wk on 2017/8/8.
//  Copyright © 2017年 wk. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>

@interface ViewController ()

@property(nonatomic, strong)UITextField *userName;
@property(nonatomic, strong)UITextField *passWord;
@property(nonatomic, strong)AVPlayer *loginPlayer;
@property(nonatomic, strong)UIButton *loginBtn;

@end

@implementation ViewController

- (AVPlayer *)loginPlayer
{
    if (_loginPlayer == nil) {
        NSString *videoPath = [[NSBundle mainBundle]pathForResource:@"register_guide_video.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:videoPath];
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
        _loginPlayer = [[AVPlayer alloc]initWithPlayerItem:item];
        _loginPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        AVPlayerLayer *player = [AVPlayerLayer playerLayerWithPlayer:_loginPlayer];
        player.frame = self.view.bounds;
        [self.view.layer insertSublayer:player atIndex:0];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goOnPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _loginPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUi];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.loginPlayer play];
}

- (void)goOnPlay
{

    [self.loginPlayer seekToTime:CMTimeMake(0, 1)];
    [self.loginPlayer play];
}
- (void)setUi{
    
    __weak typeof(self) weakSelf = self;
    UIView *backView = [[UIView alloc]init];
    backView.frame = self.view.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    [self.view addSubview:backView];
    
    _userName = [[UITextField alloc]init];
    _userName.placeholder = @"请输入账号";
    _userName.font = [UIFont systemFontOfSize:17.0];
    [backView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(80.0);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(15.0);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-15.0);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor whiteColor];
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userName);
        make.right.mas_equalTo(weakSelf.userName);
        make.top.mas_equalTo(weakSelf.userName.mas_bottom).offset(5.0);
        make.height.mas_equalTo(2.0);
    }];
    _passWord = [[UITextField alloc]init];
    _passWord.placeholder = @"请输入密码";
    _passWord.font = [UIFont systemFontOfSize:17.0];
    [backView addSubview:_passWord];
    [_passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(20.0);
        make.left.mas_equalTo(weakSelf.userName);
        make.right.mas_equalTo(weakSelf.userName);
    }];
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor whiteColor];
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.passWord);
        make.right.mas_equalTo(weakSelf.passWord);
        make.top.mas_equalTo(weakSelf.passWord.mas_bottom).offset(5.0);
        make.height.mas_equalTo(2.0);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginBtn setTintColor:[UIColor whiteColor]];
    _loginBtn.backgroundColor =  [UIColor colorWithRed:24/255.0 green:154/255.0 blue:204/255.0 alpha:1.0];
    [_loginBtn setTitle:@"登入" forState:UIControlStateNormal];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [backView addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.passWord);
        make.right.mas_equalTo(weakSelf.passWord);
        make.top.mas_equalTo(line1.mas_bottom).offset(60.0);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
