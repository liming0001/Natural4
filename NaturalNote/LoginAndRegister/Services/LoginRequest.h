//
//  LoginRequest.h
//  NaturalNote
//
//  Created by Liu on 16/9/18.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "LXBaseRequest.h"

@interface LoginRequest : LXBaseRequest

@property (nonatomic, strong) NSString *nickName;       //昵称	●	可以是手机或者昵称
@property (nonatomic, strong) NSString *userPassword;   //密码	●
@property (nonatomic, strong) NSString *registrationId;   //极光推送ID	●

@end

@class CampsObject;
@interface LoginResponse : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userUid;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *userPhoneNum;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *useType; //STUDENT  学生 TEACHER  老师 PARENT   家长
@property (nonatomic, strong) NSString *userScore;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSArray *camps;

@end

@interface CampsObject : NSObject

@property (nonatomic, strong) NSString *campeId;    //活动id
@property (nonatomic, strong) NSString *campeName;  //活动名称

@end
