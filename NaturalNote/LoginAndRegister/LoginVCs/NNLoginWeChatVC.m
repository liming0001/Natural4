//
//  NNLoginWeChatVC.m
//  NaturalNote
//
//  Created by smarter on 2018/7/4.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import "NNLoginWeChatVC.h"
#import "WXApi.h"

@interface NNLoginWeChatVC ()
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *openid;
@end

@implementation NNLoginWeChatVC

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Wechat_Login_Notify object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedWeChatLoginMessage:) name:Wechat_Login_Notify object:nil];
}
- (IBAction)WeChatLoginAction:(id)sender {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = WXPacket_State ;//用于在OnResp中判断是哪个应用向微信发起的授权，这里填写的会在OnResp里面被微信返回
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

- (void)receivedWeChatLoginMessage:(NSNotification *)notification {
    NSArray *params = notification.object;
    if (params.count<2) {
        return;
    }
    [EasyLoadingView showLoadingText:@"微信登陆中..." config:^EasyLoadingConfig *{
        return [EasyLoadingConfig shared].setLoadingType(LoadingShowTypeIndicatorLeft);
    }];
    
    _openid = params[0];
    _access_token = params[1];
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",_access_token,_openid];
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (data) {
//            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic777 = %@",dic);
//            NSString *openid = [CommonUtility ReturnBlankString:dic[@"openid"]];
//            NSString *nickname = [CommonUtility ReturnBlankString:dic[@"nickname"]];
//            NSNumber *sex = dic[@"sex"];
//            NSString *headimgurl = [CommonUtility ReturnBlankString:dic[@"headimgurl"]];
//            NSString *unionid = [CommonUtility ReturnBlankString:dic[@"unionid"]];
//            WXLoginRequest *request = [WXLoginRequest new];
//            request.openid = openid;
//            request.nickname = nickname;
//            request.sex = sex;
//            request.headimgurl = headimgurl;
//            request.unionid = unionid;
//            request.registrationId = [CommonUtility sharedManager].registrationId;
//            [request startWithCompletionHandle:^(LXBaseRequest *request, id response, BOOL success) {
//                NSLog(@"loginresponse11===%@",response);
//                LoginResponse *data = [LoginResponse mj_objectWithKeyValues:response];
//                if ([response[@"success"]boolValue]) {
//                    USERVALUE.userInfo = data;
//                    NSString *phoneS = [CommonUtility ReturnBlankString:USERVALUE.userInfo.userPhoneNum];
//                    if (phoneS.length != 0) {
//                        [self saveUserInfo];
//                    }else{
//                        PhoneNumSetVC *VC = [[PhoneNumSetVC alloc]init];
//                        VC.didFinishedCallback = ^(NSString *phoneNumber) {
//                            USERVALUE.userInfo.userPhoneNum = phoneNumber;
//                            [self saveUserInfo];
//                        };
//                        [self.navigationController pushViewController:VC animated:YES];
//                    }
//                }else {
//                    [[ZLAlertCenter defaultCenter] postAlertWithMessage:data.desc];
//                }
//            }];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Wechat_Login_Notify object:nil];
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
