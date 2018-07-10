//
//  WXLoginRequest.h
//  NaturalNote
//
//  Created by 李黎明 on 2017/10/26.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "LXBaseRequest.h"

@interface WXLoginRequest : LXBaseRequest

@property (nonatomic, strong) NSString *openid;       //昵称    ●    可以是手机或者昵称
@property (nonatomic, strong) NSString *nickname;   //密码    ●
@property (nonatomic, strong) NSNumber *sex;   //极光推送ID    ●
@property (nonatomic, strong) NSString *headimgurl;       //昵称    ●    可以是手机或者昵称
@property (nonatomic, strong) NSString *unionid;   //密码    ●
@property (nonatomic, strong) NSString *registrationId;   //极光推送ID    ●

@end

@interface WXLoginResponse : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *userUid;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *userPhoneNum;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *useType; //STUDENT  学生 TEACHER  老师 PARENT   家长
@property (nonatomic, strong) NSString *userScore;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSArray *camps;

@end
