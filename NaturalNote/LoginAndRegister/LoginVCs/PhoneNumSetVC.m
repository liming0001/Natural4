//
//  PhoneNumSetVC.m
//  NaturalNote
//
//  Created by 李黎明 on 2017/10/26.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "PhoneNumSetVC.h"
#import "NNLoginBaseView.h"
#import "UpdatePhoneNumRequest.h"
#import "SendCodeRequest.h"

@interface PhoneNumSetVC ()

@property (nonatomic, strong) NNLoginBaseView *underView;
@property (nonatomic, strong) UITextField *phoneNumber;
@property (nonatomic, strong) UITextField *verifyCode;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PhoneNumSetVC

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.underView addSubview:self.phoneNumber];
    [self.underView addSubview:self.verifyButton];
    [self.underView addSubview:self.verifyCode];
    [self.underView addSubview:self.commitButton];
    
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@80);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.verifyButton.mas_left).offset(-15);
        make.height.mas_equalTo(@35);
    }];
    
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneNumber);
        make.right.equalTo(self.underView).offset(-30);
        make.size.mas_equalTo(CGSizeMake(62, 35));
    }];
    
    [self.verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumber);
        make.top.equalTo(self.phoneNumber.mas_bottom).offset(5);
        make.right.equalTo(self.verifyButton);
        make.height.mas_equalTo(@35);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyCode.mas_bottom).offset(30);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
}

- (void)bindWithViewModel {
    [super bindWithViewModel];
    
    self.underView.titleLabel.text = @"绑定手机号码";
    
    @weakify(self);
    RACCommand *validCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self validPhone];
        return [RACSignal empty];
    }];
    self.verifyButton.rac_command = validCommand;
    
    RACCommand *comitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self commitPhone];
        return [RACSignal empty];
    }];
    self.commitButton.rac_command = comitCommand;
 
    [[self.underView.leftNavigationButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController popViewControllerAnimated:YES];
     }];
}

- (void)validPhone{
    if (self.verifyCode.text.length == 0) {
        [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"请输入手机号"];
        return;
    }
    
    [self.verifyButton setTitle:@"60" forState:UIControlStateNormal];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
    
    SendCodeRequest *request = [SendCodeRequest new];
    request.phoneNum = self.phoneNumber.text;
    request.smsType = @"3";
    [request startWithCompletionHandle:^(LXBaseRequest *request, id response, BOOL success) {
        SendCodeResponse *data = [SendCodeResponse mj_objectWithKeyValues:response];
        if (data.success) {
            
        }
        else {
            [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"发送短信验证码失败"];
        }
    }];
    
}

- (void)timeCountdown {
    NSInteger count = self.verifyButton.titleLabel.text.integerValue;
    count--;
    if (count > 0) {
        self.verifyButton.enabled = NO;
        [self.verifyButton setTitle:[NSString stringWithFormat:@"%ld", count] forState:UIControlStateNormal];
    }
    else {
        [self.timer invalidate];
        self.verifyButton.enabled = YES;
        [self.verifyButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

- (void)commitPhone{
    if (self.phoneNumber.text.length == 0) {
        [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"请输入验证码"];
        return;
    }
    
    [SVProgressHUD show];
    UpdatePhoneNumRequest *request = [UpdatePhoneNumRequest new];
    request.userPhoneNum = self.phoneNumber.text;
    [request startWithCompletionHandle:^(LXBaseRequest *request, id response, BOOL success) {
        NSLog(@"loginresponse11===%@",response);
        [SVProgressHUD dismiss];
        LoginResponse *data = [LoginResponse mj_objectWithKeyValues:response];
        if (data.success) {
            if (_didFinishedCallback) {
                _didFinishedCallback(self.phoneNumber.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [[ZLAlertCenter defaultCenter] postAlertWithMessage:data.desc];
        }
        
    }];
}

#pragma mark - Getter
- (NNLoginBaseView *)underView {
    if (!_underView) {
        _underView = [[NNLoginBaseView alloc] initWithFrame:self.view.bounds];
        _underView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _underView;
}

- (UITextField *)phoneNumber {
    if (!_phoneNumber) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = @"请输入绑定的手机号";
        textField.font = [UIFont systemFontOfSize:12];
        textField.textColor = [UIColor colorWithHexRGB:0x333333];
        textField.background = [[UIImage imageNamed:@"bt_white_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        _phoneNumber = textField;
    }
    return _phoneNumber;
}

- (UITextField *)verifyCode {
    if (!_verifyCode) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = @"请输入验证码";
        textField.font = [UIFont systemFontOfSize:12];
        textField.textColor = [UIColor colorWithHexRGB:0x333333];
        textField.background = [[UIImage imageNamed:@"bt_white_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        _verifyCode = textField;
    }
    return _verifyCode;
}

- (UIButton *)commitButton {
    if (!_commitButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *image = [[UIImage imageNamed:@"bt_green_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        UIImage *selectedImage = [[UIImage imageNamed:@"bt_green_selected"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
        [button setTitle:@"提交" forState:UIControlStateNormal];
        _commitButton = button;
    }
    return _commitButton;
}

- (UIButton *)verifyButton {
    if (!_verifyButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyButton = button;
    }
    return _verifyButton;
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
