//
//  CampOrderVC.m
//  NaturalNote
//
//  Created by Liu on 16/11/13.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "CampOrderVC.h"
#import "CampOrderViewModel.h"

@interface CampOrderVC ()

@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *campLabel;
@property (nonatomic, strong) UILabel *campNameLabel;
@property (nonatomic, strong) UILabel *campTimeLabel;
@property (nonatomic, strong) UILabel *campAddressLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *isGuardLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *leftNavigationButton;

@property (nonatomic, strong) CampOrderViewModel *viewModel;

@end

@implementation CampOrderVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultNotify:) name:Wechat_Pay_Success_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultNotify:) name:Wechat_Pay_Fail_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultNotify:) name:Wechat_Pay_Cancel_Notify object:nil];
    
    
    [self.view addSubview:self.orderLabel];
    [self.view addSubview:self.campLabel];
    [self.view addSubview:self.campNameLabel];
    [self.view addSubview:self.campTimeLabel];
    [self.view addSubview:self.campAddressLabel];
    [self.view addSubview:self.priceLabel];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.nickNameLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.isGuardLabel];
    [self.view addSubview:self.button];
    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.campLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.orderLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.campNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.campLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.campTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.campNameLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.campAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.campTimeLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.campAddressLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.isGuardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(-8);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.bottom.equalTo(self.view).offset(-8);
        make.height.mas_equalTo(44);
    }];
    
    self.orderLabel.text = [NSString stringWithFormat:@"订单号:%@", self.viewModel.vm.orderID];
    self.campLabel.text = @"活动信息";
    self.campNameLabel.text = [NSString stringWithFormat:@"活动名称:%@", self.viewModel.vm.data.campName];
    self.campTimeLabel.text = [NSString stringWithFormat:@"活动时间:%@", self.viewModel.vm.data.campAddr];
    self.campAddressLabel.text = [NSString stringWithFormat:@"活动地址:%@-%@", self.viewModel.vm.data.campBeginTime, self.viewModel.vm.data.campEndTime];
    self.priceLabel.text = [NSString stringWithFormat:@"活动价格:¥%@", self.viewModel.vm.data.currPrice];
    self.titleLabel.text = @"报名信息";
    self.nickNameLabel.text = [NSString stringWithFormat:@"昵称:%@", self.viewModel.vm.nickName];
    self.nameLabel.text = [NSString stringWithFormat:@"姓名:%@", self.viewModel.vm.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"手机:%@", self.viewModel.vm.phoneNO];
    self.isGuardLabel.text = [NSString stringWithFormat:@"是否监护人:%@", self.viewModel.vm.isGuardian.integerValue == 2 ? @"是" : @"否"];
    
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel unidefinedOrder];
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavigationButton];
    [[self.leftNavigationButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController popViewControllerAnimated:YES];
     }];
}

- (void)payResultNotify:(NSNotification *)notify {
    if ([notify.name isEqualToString:Wechat_Pay_Success_Notify]) {
        [self.viewModel getPayResult];
    }
    else if ([notify.name isEqualToString:Wechat_Pay_Fail_Notify]) {
        [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"支付失败"];
    }
    else if ([notify.name isEqualToString:Wechat_Pay_Cancel_Notify]) {
        [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"支付取消"];
    }
}

- (void)bindWithViewModel {
    [super bindWithViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, payResultNumber) subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.payResultNumber.integerValue == 1) {
            [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"支付成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if (self.viewModel.payResultNumber.integerValue == 2) {
            [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"支付失败"];
        }
        else if (self.viewModel.payResultNumber.integerValue == 3) {
            [[ZLAlertCenter defaultCenter] postAlertWithMessage:@"正在确认支付结果"];
        }
    }];
}

#pragma mark - Getter
- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _orderLabel;
}

- (UILabel *)campLabel {
    if (!_campLabel) {
        _campLabel = [self configLabelWithFont:16 textColor:[UIColor appStyleColor]];
    }
    return _campLabel;
}

- (UILabel *)campNameLabel {
    if (!_campNameLabel) {
        _campNameLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _campNameLabel;
}

- (UILabel *)campTimeLabel {
    if (!_campTimeLabel) {
        _campTimeLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _campTimeLabel;
}

- (UILabel *)campAddressLabel {
    if (!_campAddressLabel) {
        _campAddressLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _campAddressLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self configLabelWithFont:16 textColor:[UIColor appStyleColor]];
    }
    return _titleLabel;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _nickNameLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _phoneLabel;
}

- (UILabel *)isGuardLabel {
    if (!_isGuardLabel) {
        _isGuardLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _isGuardLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [self configLabelWithFont:14 textColor:[UIColor titleTextColor]];
    }
    return _priceLabel;
}

- (UILabel *)configLabelWithFont:(CGFloat)font textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *image = [[UIImage imageNamed:@"bt_green_default"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        UIImage *selectedImage = [[UIImage imageNamed:@"bt_green_selected"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
        [button setTitle:@"立即支付" forState:UIControlStateNormal];
        _button = button;
    }
    return _button;
}

- (UIButton *)leftNavigationButton {
    if (!_leftNavigationButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        _leftNavigationButton = button;
    }
    return _leftNavigationButton;
}

@end
