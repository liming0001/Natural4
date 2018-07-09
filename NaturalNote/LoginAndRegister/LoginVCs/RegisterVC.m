//
//  RegisterVC.m
//  NaturalNote
//
//  Created by Liu on 16/9/17.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterViewModel.h"
#import "NNLoginBaseView.h"
#import "GenderSelectView.h"
#import "ZLDatePicker.h"

@interface RegisterVC ()<UITextFieldDelegate>

@property (nonatomic, strong) RegisterViewModel *viewModel;
@property (nonatomic, strong) NNLoginBaseView *underView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *nickName;
@property (nonatomic, strong) UITextField *name;
//@property (nonatomic, strong) UITextField *birthday;
@property (nonatomic, strong) UITextField *confirmPassword;
@property (nonatomic, strong) UIButton *changeUserImageButton;
@property (nonatomic, strong) UIButton *registerButton;
//@property (nonatomic, strong) GenderSelectView *genderSelectView;

@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) UITextField *verifyCode;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RegisterVC
@dynamic viewModel;

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

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
    [self.underView addSubview:self.changeUserImageButton];
    [self.underView addSubview:self.nickName];
    [self.underView addSubview:self.name];
//    [self.underView addSubview:self.genderSelectView];
//    [self.underView addSubview:self.birthday];
    [self.underView addSubview:self.account];
    [self.underView addSubview:self.password];
    [self.underView addSubview:self.confirmPassword];
    [self.underView addSubview:self.registerButton];
    [self.underView addSubview:self.verifyButton];
    [self.underView addSubview:self.verifyCode];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (ScreenHeight < 568) {
            make.top.mas_equalTo(@35);
        }
        else {
            make.top.mas_equalTo(@44);
        }
        make.centerX.equalTo(self.underView);
        make.size.mas_equalTo(CGSizeMake(81, 81));
    }];
    
    [self.changeUserImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nickName.mas_top).offset(-5);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@20);
    }];
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(40);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickName.mas_bottom).offset(10);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
//    [self.genderSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.name);
//        make.right.equalTo(self.underView).offset(-30);
//        make.size.mas_equalTo(CGSizeMake(44*2 + 10, 18));
//    }];
//    
//    [self.birthday mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.name.mas_bottom).offset(10);
//        make.left.equalTo(self.underView).offset(30);
//        make.right.equalTo(self.underView).offset(-30);
//        make.height.mas_equalTo(@35);
//    }];
    
    [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(35);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.verifyButton.mas_left).offset(-15);
        make.height.mas_equalTo(@35);
    }];
    
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.account);
        make.right.equalTo(self.underView).offset(-30);
        make.size.mas_equalTo(CGSizeMake(62, 35));
    }];
    
    [self.verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.account.mas_bottom).offset(10);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyCode.mas_bottom).offset(10);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
    [self.confirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(10);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmPassword.mas_bottom).offset(10);
        make.left.equalTo(self.underView).offset(30);
        make.right.equalTo(self.underView).offset(-30);
        make.height.mas_equalTo(@35);
    }];
}

- (void)bindWithViewModel {
    [super bindWithViewModel];
    
    self.underView.titleLabel.text = self.viewModel.title;
    RAC(self.headImage, image) = RACObserve(self.viewModel, userImage);
    RAC(self.viewModel, nickName) = self.nickName.rac_textSignal;
    RAC(self.viewModel, name) = self.name.rac_textSignal;
//    RAC(self.viewModel, birthday) = RACObserve(self.birthday, text);
    RAC(self.viewModel, account) = self.account.rac_textSignal;
    RAC(self.viewModel, password) = self.password.rac_textSignal;
    RAC(self.viewModel, confirmPassword) = self.confirmPassword.rac_textSignal;
//    RAC(self.viewModel, gender) = RACObserve(self.genderSelectView, gender);
    
    self.registerButton.rac_command = self.viewModel.registerCommand;
    
    @weakify(self);
    [[self.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
    }];
    
    [[self.underView.leftNavigationButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.viewModel.services popViewModelAnimated:YES];
    }];
    
    [[self.changeUserImageButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [LXAlertManager showActionSheetWithTitle:nil message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"相机", @"相册"] inView:self.view dismissBlock:^(NSInteger index, NSInteger cancelIndex) {
             if (index == 0) {
                 //相机
                 [UIImagePickerController showImagePickerWithSourceVC:self sourceType:UIImagePickerControllerSourceTypeCamera dismissBlock:^(UIImagePickerController *picker, UIImage *image, BOOL finished) {
                     self.headImage.image = image;
                 }];
             }
             else if (index == 1) {
                 //相册
                 [UIImagePickerController showImagePickerWithSourceVC:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary dismissBlock:^(UIImagePickerController *picker, UIImage *image, BOOL finished) {
                     self.headImage.image = image;
                 }];
             }
         } presentVC:self];
    }];
    
    self.verifyButton.rac_command = self.viewModel.getVerifyCodeCommand;
    RAC(self.viewModel, verifyCode) = self.verifyCode.rac_textSignal;
    
    [RACObserve(self.viewModel, sendSMSCodeSuccess) subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.sendSMSCodeSuccess) {
            [self.verifyButton setTitle:@"60" forState:UIControlStateNormal];
            self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
            [self.timer fire];
        }
        else {
            
        }
    }];
    
    [RACObserve(self.viewModel, registerSuccess) subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.registerSuccess) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (textField == self.birthday) {
//        [self.view endEditing:YES];
//        [ZLDatePicker showDatePickerWithDate:[NSDate date] completeHandle:^(UIDatePicker *picker, NSString *dateString) {
//            self.birthday.text = dateString;
//        }];
//        return NO;
//    }
    return YES;
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

- (UITextField *)configTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor colorWithHexRGB:0x333333];
    textField.background = [[UIImage imageNamed:@"bt_white_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    textField.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 35)];
    imageView.backgroundColor = [UIColor clearColor];
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

- (UITextField *)account {
    if (!_account) {
        _account = [self configTextField];
        _account.placeholder = @"绑定手机号";
    }
    return _account;
}

- (UITextField *)password {
    if (!_password) {
        _password = [self configTextField];
        _password.secureTextEntry = YES;
        _password.placeholder = @"登录密码";
    }
    return _password;
}

- (UITextField *)confirmPassword {
    if (!_confirmPassword) {
        _confirmPassword = [self configTextField];
        _confirmPassword.secureTextEntry = YES;
        _confirmPassword.placeholder = @"确认密码";
    }
    return _confirmPassword;
}

- (UITextField *)nickName {
    if (!_nickName) {
        _nickName = [self configTextField];
        _nickName.placeholder = @"请输入您的自然名（昵称）";
    }
    return _nickName;
}

- (UITextField *)name {
    if (!_name) {
        _name = [self configTextField];
        _name.placeholder = @"请输入您的真实姓名";
    }
    return _name;
}

//- (UITextField *)birthday {
//    if (!_birthday) {
//        _birthday = [self configTextField];
//        _birthday.placeholder = @"您的生日";
//    }
//    return _birthday;
//}

- (UIButton *)registerButton {
    if (!_registerButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *image = [[UIImage imageNamed:@"bt_green_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        UIImage *selectedImage = [[UIImage imageNamed:@"bt_green_selected"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
        [button setTitle:@"注 册" forState:UIControlStateNormal];
        _registerButton = button;
    }
    return _registerButton;
}

- (UIButton *)changeUserImageButton {
    if (!_changeUserImageButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"更换头像" forState:UIControlStateNormal];
        _changeUserImageButton = button;
    }
    return _changeUserImageButton;
}

//- (GenderSelectView *)genderSelectView {
//    if (!_genderSelectView) {
//        _genderSelectView = [[GenderSelectView alloc] initWithFrame:CGRectZero];
//        _genderSelectView.gender = @1;
//    }
//    return _genderSelectView;
//}

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

- (UITextField *)verifyCode {
    if (!_verifyCode) {
        _verifyCode = [self configTextField];
        _verifyCode.placeholder = @"请输入验证码";
    }
    return _verifyCode;
}

@end
