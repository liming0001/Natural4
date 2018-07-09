//
//  LoginVC.m
//  NaturalNote
//
//  Created by Liu on 16/9/15.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "LoginVC.h"
#import "LoginViewModel.h"
#import "NNLoginBaseView.h"
#import "WXLoginRequest.h"
#import "JPUSHService.h"
#import "PhoneNumSetVC.h"
#import "WXApi.h"
@interface LoginVC ()

@property (nonatomic, strong) LoginViewModel *viewModel;
@property (nonatomic, strong) NNLoginBaseView *underView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *wxButton;

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *openid;

@end

@implementation LoginVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviewAndLayout];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheView)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)tapTheView {
    [self.view endEditing:YES];
}

- (void)addSubviewAndLayout {
    [self.view addSubview:self.underView];
    [self.underView addSubview:self.headImage];
    [self.underView addSubview:self.account];
    [self.underView addSubview:self.password];
    [self.underView addSubview:self.registerButton];
    [self.underView addSubview:self.forgetButton];
    [self.underView addSubview:self.loginButton];
    
    if ([WXApi isWXAppInstalled]) {
        //把微信登录的按钮隐藏掉。
        [self.underView addSubview:self.wxButton];
    }
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@114);
        make.centerX.equalTo(self.underView);
        make.size.mas_equalTo(CGSizeMake(81, 81));
    }];
    
    [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(36);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.account.mas_bottom).offset(10);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(5);
        make.left.equalTo(self.password);
        make.height.mas_equalTo(@20);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(5);
        make.right.equalTo(self.password);
        make.height.mas_equalTo(@20);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetButton.mas_bottom).offset(20);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
//    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.loginButton.mas_bottom).offset(20);
//        make.left.equalTo(self.underView).offset(30);
//        make.right.equalTo(self.underView).offset(-30);
//        make.height.mas_equalTo(@20);
//    }];
}

- (void)bindWithViewModel {
    [super bindWithViewModel];
    
    self.underView.titleLabel.text = self.viewModel.title;
    RAC(self.viewModel, account) = self.account.rac_textSignal;
    RAC(self.viewModel, password) = self.password.rac_textSignal;
    RAC(self.headImage, image) = RACObserve(self.viewModel, userImage);
    
    self.loginButton.rac_command = self.viewModel.loginCommand;
    self.forgetButton.rac_command = self.viewModel.forgetCommand;
    self.registerButton.rac_command = self.viewModel.registerCommand;
    
    @weakify(self);
    RACCommand *wxCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self wxLogin];
        return [RACSignal empty];
    }];
    self.wxButton.rac_command = wxCommand;
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
    }];
    
    self.underView.leftNavigationButton.rac_command = self.viewModel.dismissCommand;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedWeChatLoginMessage:) name:Wechat_Login_Notify object:nil];
}

- (void)wxLogin {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = WXPacket_State ;//用于在OnResp中判断是哪个应用向微信发起的授权，这里填写的会在OnResp里面被微信返回
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

- (void)receivedWeChatLoginMessage:(NSNotification *)notification {
    [SVProgressHUD show];
    NSArray *params = notification.object;
    if (params.count<2) {
        [SVProgressHUD dismiss];
        return;
    }
    _openid = params[0];
    _access_token = params[1];
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",_access_token,_openid];
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (data) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic777 = %@",dic);
            NSString *openid = [CommonUtility ReturnBlankString:dic[@"openid"]];
            NSString *nickname = [CommonUtility ReturnBlankString:dic[@"nickname"]];
            NSNumber *sex = dic[@"sex"];
            NSString *headimgurl = [CommonUtility ReturnBlankString:dic[@"headimgurl"]];
            NSString *unionid = [CommonUtility ReturnBlankString:dic[@"unionid"]];
            WXLoginRequest *request = [WXLoginRequest new];
            request.openid = openid;
            request.nickname = nickname;
            request.sex = sex;
            request.headimgurl = headimgurl;
            request.unionid = unionid;
            request.registrationId = [CommonUtility sharedManager].registrationId;
            [request startWithCompletionHandle:^(LXBaseRequest *request, id response, BOOL success) {
                NSLog(@"loginresponse11===%@",response);
                LoginResponse *data = [LoginResponse mj_objectWithKeyValues:response];
                if ([response[@"success"]boolValue]) {
                    USERVALUE.userInfo = data;
                    NSString *phoneS = [CommonUtility ReturnBlankString:USERVALUE.userInfo.userPhoneNum];
                    if (phoneS.length != 0) {
                        [self saveUserInfo];
                    }else{
                        PhoneNumSetVC *VC = [[PhoneNumSetVC alloc]init];
                        VC.didFinishedCallback = ^(NSString *phoneNumber) {
                            USERVALUE.userInfo.userPhoneNum = phoneNumber;
                            [self saveUserInfo];
                        };
                        [self.navigationController pushViewController:VC animated:YES];
                    }
                }else {
                    [[ZLAlertCenter defaultCenter] postAlertWithMessage:data.desc];
                }
            }];
        }
    });
}

- (void)saveUserInfo{
    [USERVALUE saveToDisk];
    //登录
    [JPUSHService setAlias:USERVALUE.userInfo.userPhoneNum completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:1];
    [CommonUtility sharedManager].isLoginAgain = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:Login_Notify object:nil];
    
    [CommonUtility sharedManager].isLoginAgain = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:Login_Notify object:nil];
    [self.viewModel.services dismissViewModelAnimated:YES completion:nil];
//    [self.viewModel.services dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

#pragma mark - Getter
- (NNLoginBaseView *)underView {
    if (!_underView) {
        _underView = [[NNLoginBaseView alloc] initWithFrame:self.view.bounds];
        _underView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _underView;
}

- (UIImageView *)headImage {
    if (!_headImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.layer.cornerRadius = 81/2;
        imageView.layer.masksToBounds = YES;
        _headImage = imageView;
    }
    return _headImage;
}

- (UITextField *)account {
    if (!_account) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = @"请输入帐号";
        textField.font = [UIFont systemFontOfSize:12];
        textField.textColor = [UIColor colorWithHexRGB:0x333333];
        textField.background = [[UIImage imageNamed:@"bt_white_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        _account = textField;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"icon_login_user"];
        imageView.contentMode = UIViewContentModeCenter;
        textField.leftView = imageView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _account;
}

- (UITextField *)password {
    if (!_password) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = @"请输入密码";
        textField.font = [UIFont systemFontOfSize:12];
        textField.textColor = [UIColor colorWithHexRGB:0x333333];
        textField.background = [[UIImage imageNamed:@"bt_white_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        _password = textField;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"icon_login_lock"];
        imageView.contentMode = UIViewContentModeCenter;
        textField.leftView = imageView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.secureTextEntry = YES;
    }
    return _password;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *image = [[UIImage imageNamed:@"bt_green_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        UIImage *selectedImage = [[UIImage imageNamed:@"bt_green_selected"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
        [button setTitle:@"登 录" forState:UIControlStateNormal];
        _loginButton = button;
    }
    return _loginButton;
}

- (UIButton *)wxButton {
    if (!_wxButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"没有账号，直接使用微信登录" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        _wxButton = button;
    }
    return _wxButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"注册新用户" forState:UIControlStateNormal];
        _registerButton = button;
    }
    return _registerButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton = button;
    }
    return _forgetButton;
}

@end
