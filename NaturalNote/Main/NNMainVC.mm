//
//  NNMainVC.m
//  NaturalNote
//
//  Created by 李黎明 on 2018/7/3.
//  Copyright © 2018年 李黎明. All rights reserved.
//

#import "NNMainVC.h"
#import "NNLeftSlider.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <MLMenu/MLMenuView.h>
#import <AVFoundation/AVFoundation.h>
#import "lhScanQCodeViewController.h"
#import "NNLoginWeChatVC.h"
#import "MyLocation.h"
#import "GameInfoView.h"
#import "GameListRequest.h"
#import "GameResponse.h"
#import "GamePoint.h"
#import "EntryGameResponse.h"
#import "YWRoundGameAnnotationView.h"

@interface NNMainVC ()<BMKMapViewDelegate,BMKLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImg;
@property (weak, nonatomic) IBOutlet UIButton *lifeEngyValue;
@property (weak, nonatomic) IBOutlet UIButton *engyValue;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;

@property (nonatomic, strong) NSMutableArray *gamesA;
@property (nonatomic, strong) GameInfoView *gameInfoV;
@property (nonatomic, strong) EntryGameResponse *curEntryGame;
@property (nonatomic, assign) BOOL isGame;//是否游戏中
@property (nonatomic, strong) GameResponse *curGameRes;

//定位
@property(nonatomic, strong) BMKLocationManager *locationManager;
@end

@implementation NNMainVC

- (NSMutableArray *)gamesA{
    if (!_gamesA) {
        _gamesA = [NSMutableArray array];
    }
    return _gamesA;
}

- (GameInfoView *)gameInfoV{
    if (!_gameInfoV) {
        CGFloat addHwight = 0;
        if (KIsiPhoneX) {
            addHwight = 50;
        }
        _gameInfoV = [[GameInfoView alloc]initWithFrame:CGRectMake(15, ScreenHeight-125-20-addHwight, ScreenWidth- 30, 125)];
        _gameInfoV.backgroundColor = [UIColor whiteColor];
        _gameInfoV.layer.borderWidth = 1;
        _gameInfoV.layer.cornerRadius = 5;
        _gameInfoV.layer.borderColor = [UIColor whiteColor].CGColor;
        _gameInfoV.hidden = YES;
    }
    return _gameInfoV;
}

#pragma *******第一步：获取所有游戏点*********
- (void)getAllGames{
    self.gameInfoV.hidden = YES;
    [self.gamesA removeAllObjects];
    GameListRequest *request = [GameListRequest new];
    request.IsQueryAll = @"N";
    @weakify(self)
    [request startWithCompletionHandle:^(LXBaseRequest *request, id response, BOOL success) {
        @strongify(self)
        NSLog(@"Chllengeresponse = %@",response);
        NSArray *datas = response[@"games"];
        NSArray *sourceA = [GameResponse mj_objectArrayWithKeyValuesArray:datas];
        [self.gamesA addObjectsFromArray:sourceA];
        
        NSMutableArray *annotionA = [NSMutableArray array];
        __block BOOL hasGamePlaying = NO;
        [self.gamesA enumerateObjectsUsingBlock:^(GameResponse * curGame, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([curGame.gameStatus isEqualToString:@"PLAYING"]){
                hasGamePlaying = YES;
                self.curEntryGame  = (EntryGameResponse *)curGame;
                NSArray *refereeUserIdsA = [curGame.refereeUserIds componentsSeparatedByString:@","];
                if ([refereeUserIdsA containsObject:[UserValue shareInstance].userInfo.userUid]) {
                    [CommonUtility sharedManager].isCaipan = YES;
                }else{
                    [CommonUtility sharedManager].isCaipan = NO;
                }
            }
            GamePoint *annotation = [[GamePoint alloc]init];
            CLLocationCoordinate2D coor;
            annotation.title = curGame.gameName;
            coor.latitude = [curGame.latitude floatValue];
            coor.longitude = [curGame.longitude floatValue];
            annotation.coordinate = coor;
            annotation.curCha = curGame;
            [annotionA addObject:annotation];
        }];
        NSLog(@"annotionA = %@",annotionA);
        NSArray *anoA = self.mapView.annotations;
        [self.mapView removeAnnotations:anoA];
        [self.mapView addAnnotations:annotionA];
        [self.mapView showAnnotations:annotionA animated:YES];
//        self.isGame = NO;
        if (hasGamePlaying) {
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"温馨提示").setSubtitle(@"是否继续游戏?").setAlertType(AlertViewTypeAlert) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].settwoItemHorizontal(YES).setAnimationType(AlertAnimationTypeFade).setTintColor([UIColor groupTableViewBackgroundColor]).setBgViewEvent(NO).setSubtitleTextAligment(NSTextAlignmentLeft).setEffectType(AlertBgEffectTypeAlphaCover) ;
            } buttonArray:^NSArray<NSString *> *{
                return @[@"是",@"否"] ;
            } callback:^(EasyAlertView *showview , long index) {
                if (!index) {
//                    self.isStartGame = NO;
                    if ([CommonUtility sharedManager].isCaipan) {
//                        GameControlVC *vc = [[GameControlVC alloc] init];
//                        [vc setValue:self.curEntryGame.gameId forKey:@"gameID"];
//                        [vc setValue:self.curEntryGame.gameStatus forKey:@"gameStatus"];
//                        [vc setValue:self.curEntryGame.gameType forKey:@"gameType"];
//                        [vc setValue:self.curEntryGame.gameCode forKey:@"gameCode"];
//                        [vc setValue:[NSNumber numberWithInt:2] forKey:@"pushType"];
//                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
//                        self.isStartGame = YES;
//                        self.isGame = YES;
//                        NSString *gameType = [CommonUtility ReturnBlankString:self.curResponse.gameType];
//                        NSString *gameName = [CommonUtility ReturnBlankString:self.curResponse.gameName];
//                        NSString *gameAddr = [CommonUtility ReturnBlankString:self.curResponse.gameAddr];
//                        if (gameType.length == 0) {
//                            gameType = [CommonUtility ReturnBlankString:self.curEntryGame.gameType];
//                        }
//                        if (gameName.length == 0) {
//                            gameName = [CommonUtility ReturnBlankString:self.curEntryGame.gameName];
//                        }
//                        if (gameAddr.length == 0) {
//                            gameAddr = [CommonUtility ReturnBlankString:self.curEntryGame.gameName];
//                        }
//                        self.gameAddressLab.text = gameAddr;
//                        if ([gameType isEqualToString:@"ZLPK"]) {
//                            @weakify(self)
//                            NSString *message = [NSString stringWithFormat:@"欢迎来到%@,游戏即将开始，请等待裁判员指令！规则：找到目标并用手中的能量占领它，善用能量，可以抢夺目标也可以放弃，占领最多目标的小组获胜。。",gameName];
//                            [LXAlertManager showAlertViewWithTitle:nil message:message cancelButtonTitle:@"已了解" otherButtonTitles:nil dismissBlock:^(NSInteger index, NSInteger cancelIndex) {
//                                @strongify(self)
//                                [self getGameDetail];
//                            }];
//                        }else{
//                            if ([gameType isEqualToString:@"XSPA"]) {
//                                @weakify(self)
//                                NSString *message = [NSString stringWithFormat:@"欢迎来到%@,游戏即将开始，请等待裁判员指令！规则：按照数字顺序找到目标，对目标进行打卡，打卡完成可能会获得寻找boss的线索，打卡完成所有目标点，并成功找出boss者胜出。",gameName];
//                                [LXAlertManager showAlertViewWithTitle:nil message:message cancelButtonTitle:@"已了解" otherButtonTitles:nil dismissBlock:^(NSInteger index, NSInteger cancelIndex) {
//                                    @strongify(self)
//                                    [self getGameDetail];
//                                }];
//                            }else{
//                                @weakify(self)
//                                NSString *message = [NSString stringWithFormat:@"欢迎来到%@,游戏即将开始，请等待裁判员指令！规则：按照数字顺序找到目标，对目标进行打卡，速度快者获胜，找错目标将被罚时。",gameName];
//                                [LXAlertManager showAlertViewWithTitle:nil message:message cancelButtonTitle:@"已了解" otherButtonTitles:nil dismissBlock:^(NSInteger index, NSInteger cancelIndex) {
//                                    @strongify(self)
//                                    [self getGameDetail];
//                                }];
//                            }
//                        }
                    }
                }
            }];
        }
    }];
}

-(void)initLocation
{
    [_mapView setZoomLevel:21];
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    [_mapView updateLocationViewWithParam:displayParam];
    
    _locationManager = [[BMKLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.coordinateType = BMKLocationCoordinateTypeGCJ02;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = YES;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
    
    [_locationManager startUpdatingLocation];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.showsUserLocation = YES;
    
    if (!USERVALUE.userInfo.sessionId) {
        NNLoginWeChatVC *loginVC = [[NNLoginWeChatVC alloc]initWithNibName:@"NNLoginWeChatVC" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
    [self getGamePoints];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lifeEngyValue.layer.cornerRadius = 5;
    _lifeEngyValue.layer.borderColor = [UIColor colorWithHexRGB:0x80CC00 alpha:1].CGColor;
    _lifeEngyValue.layer.borderWidth = 1;
    
    _engyValue.layer.cornerRadius = 5;
    _engyValue.layer.borderColor = [UIColor colorWithHexRGB:0x4DB5FD alpha:1].CGColor;
    _engyValue.layer.borderWidth = 1;
    
    [self.view addSubview:self.gameInfoV];
    //开启地图定位
    [self initLocation];
}

#pragma mark - 获取游戏数据点
- (void)getGamePoints{
    //每次进入页面，当游戏点为空，或者已经已经登录成功，都获取一次所有游戏点数据
    if (self.gamesA.count ==0 ||[CommonUtility sharedManager].isLoginAgain) {
        [CommonUtility sharedManager].isLoginAgain = NO;
        [self getAllGames];
    }
}

- (IBAction)mapBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self.mapView setCenterCoordinate:[CommonUtility sharedManager].userCoordinate animated:YES];
            break;
        case 1:
            [self getAllGames];
            break;
        default:
            break;
    }
}


- (IBAction)mainNavItemAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case NNItemStyle_Left:
            // 展示个人中心
            [NNLeftSlider showWithRootViewController:self];
            break;
        case NNItemStyle_Search:
            
            break;
        case NNItemStyle_Scan:
            [self scanQRCodeToJoinGama];
            break;
        case NNItemStyle_Join:
            
            break;
        case NNItemStyle_More:
        {
            NSArray *titles = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收付款"];
            
            MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100 - 10, 0, 100, 44 * 4) WithTitles:titles WithImageNames:nil WithMenuViewOffsetTop:88 WithTriangleOffsetLeft:80 triangleColor:[UIColor whiteColor]];
//            [menuView setCoverViewBackgroundColor:[UIColor whiteColor]];
            menuView.separatorColor = [UIColor whiteColor];
            [menuView setMenuViewBackgroundColor:[UIColor whiteColor]];
            menuView.titleColor =  [UIColor blueColor];
            menuView.didSelectBlock = ^(NSInteger index) {
                NSLog(@"%zd",index);
            };
            [menuView showMenuEnterAnimation:MLAnimationStyleTop];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 调用相机进入扫描界面
- (void)entryQRScanVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc] initWithCallback:^(NSString *result) {
            if (result) {
                NSArray *array = [result componentsSeparatedByString:@":"];
                if (array.count != 0) {
                    if ([array[0]isEqualToString:@"groupcode"]) {
                        NSString *groupS = array[1];
                        NSArray *g_array = [groupS componentsSeparatedByString:@"="];
                        if (g_array.count>1) {
                            NSString *groupID = g_array[0];
                            NSString *zuheID = g_array[1];
                            //                                            [self getPlayGamePointsWithGameCode:groupID ZuheCode:zuheID JoinOrExit:@"JOIN" Type:1];
                        }
                    }else{
                        //集体定向游戏code
                        NSString *gameCode = array[1];
                        //                                        [self getPlayGamePointsWithGameCode:gameCode ZuheCode:@"" JoinOrExit:@"JOIN" Type:1];
                    }
                }
            }
        }];
        UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
        [self presentViewController:nVC animated:YES completion:nil];
    });
}

#pragma mark- 扫描二维码加入游戏
- (void)scanQRCodeToJoinGama{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [self entryQRScanVC];
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            [self entryQRScanVC];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"温馨提示").setSubtitle(@"请去-> [设置 - 隐私 - 相机 - 自然笔记] \n\n打开访问开关").setAlertType(AlertViewTypeAlert) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].settwoItemHorizontal(YES).setAnimationType(AlertAnimationTypeFade).setTintColor([UIColor groupTableViewBackgroundColor]).setBgViewEvent(NO).setSubtitleTextAligment(NSTextAlignmentLeft).setEffectType(AlertBgEffectTypeAlphaCover) ;
            } buttonArray:^NSArray<NSString *> *{
                return @[@"确定",@"取消"] ;
            } callback:^(EasyAlertView *showview , long index) {
                if (!index) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                }
            }];
            
        }
    } else {
        [EasyTextView showErrorText:@"未检测到您的摄像头" config:^EasyTextConfig *{
            return [EasyTextConfig shared].setStatusType(TextStatusTypeNavigation) ;
        }];
    }
}

#pragma mark - 百度地图API
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error
{
    if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
            MyLocation * loc = [[MyLocation alloc]initWithLocation:location.location withHeading:nil];
//            CLLocationCoordinate2D coor = location.location.coordinate;
            [CommonUtility sharedManager].userCoordinate =  loc.location.coordinate;
            [_mapView updateLocationData:loc];
        }
    }  
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //游戏点
    if ([annotation isKindOfClass:[GamePoint class]]) {
        GamePoint *curCreateP = (GamePoint *)annotation;
        //动画annotation
        NSString *AnnotationViewID = [NSString stringWithFormat:@"CreateAnnotation_%@",curCreateP.curCha.gameCode];
        YWRoundGameAnnotationView *annotationView = (YWRoundGameAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];;
        if (annotationView == nil) {
            annotationView = [[YWRoundGameAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            annotationView.canShowCallout = NO;
        }
        [annotationView showInfoWithPointInfo:curCreateP.curCha];
        return annotationView;
    }
    ////植物点
//    if ([annotation isKindOfClass:[PlayingPointAnnotation class]]) {
//        PlayingPointAnnotation *curPlayedP = (PlayingPointAnnotation *)annotation;
//        //        NSLog(@"55555555%d",curPlayedP.curCha.isSelected);
//        if (curPlayedP.curCha.isZLPK==1) {
//            if ([self.curOccupationData.pointId isEqualToString:curPlayedP.curCha.pointId]) {
//                curPlayedP.curCha.isSelected = YES;
//            }else{
//                curPlayedP.curCha.isSelected = NO;
//            }
//        }
//        NSString *mapRadomS = [NSString stringWithFormat:@"point_%@",curPlayedP.curCha.order];
//        if (curPlayedP.curCha.isZLPK==1) {
//            mapRadomS = [NSString stringWithFormat:@"point_%@",curPlayedP.curCha.groupCode];
//        }
//        YWRoundAnnotationView *newAnnotationView =(YWRoundAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:mapRadomS];
//        if (newAnnotationView==nil)
//        {
//            newAnnotationView=[[ YWRoundAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mapRadomS];
//            newAnnotationView.canShowCallout=NO;
//        }
//        [newAnnotationView showInfoWithPointInfo:curPlayedP.curCha];
//        return newAnnotationView;
//    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    if (!_isGame) {
        self.curGameRes = nil;
        if ([view.annotation isKindOfClass:[GamePoint class]]) {
            GamePoint *curCreateP = (GamePoint *)view.annotation;
            self.curGameRes = curCreateP.curCha;
        }
        if (self.curGameRes) {
            @weakify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                NSArray *refereeUserIdsA = [self.curGameRes.refereeUserIds componentsSeparatedByString:@","];
                if ([refereeUserIdsA containsObject:[UserValue shareInstance].userInfo.userUid]) {
                    [CommonUtility sharedManager].isCaipan = YES;
                }else{
                    [CommonUtility sharedManager].isCaipan = NO;
                }
                self.gameInfoV.hidden = NO;
                [self.gameInfoV.gamgeIcon sd_setImageWithURL:[NSURL URLWithString:self.curGameRes.gameImageUrl]];
                self.gameInfoV.gameNameLab.text = self.curGameRes.gameName;
                self.gameInfoV.gameContentLab.text = self.curGameRes.gameDesc;
                self.gameInfoV.gameDateLab.text = self.curGameRes.createDate;
                self.gameInfoV.gameAddressLab.text = self.curGameRes.gameAddr;
//                self.dakabtn.hidden = YES;
//                self.xiansuobtn.hidden = YES;
//                self.xiansuoDaka.hidden = YES;
            });
        }
    }else{
//        _gameingPoint = nil;
//        self.dakabtn.userInteractionEnabled = YES;
//        _dakabtn.hidden = NO;
//        //////植物点
//        if ([view.annotation isKindOfClass:[PlayingPointAnnotation class]]) {
//            PlayingPointAnnotation *curCreateP = (PlayingPointAnnotation *)view.annotation;
//            curCreateP.curCha.isSelected = YES;
//            _gameingPoint = curCreateP.curCha;
//            YWRoundAnnotationView *refV =  (YWRoundAnnotationView *)view;
//            [refV showInfoWithPointInfo:curCreateP.curCha];
//        }
//        if (_gameingPoint) {
//            if ([self.curEntryGame.gameType isEqualToString:@"JTDX"]) {
//                self.JTDXMessageView.hidden = NO;
//                self.ZLPKMessageView.hidden = YES;
//                self.XSPAMessageView.hidden = YES;
//                self.xiansuobtn.hidden = YES;
//                self.xiansuoDaka.hidden = YES;
//                self.dakabtn.hidden = NO;
//                [self.gamgeIcon sd_setImageWithURL:[NSURL URLWithString:_gameingPoint.plantFiristImg]];
//                self.gameNameLab.text = _gameingPoint.pointName;
//                self.gameContentLab.text = _gameingPoint.plantDesc;
//                self.gameDateLab.text = @"找到植物，点此打卡吧";
//            }else if([self.curEntryGame.gameType isEqualToString:@"GJZWDX"]){
//                self.JTDXMessageView.hidden = NO;
//                self.ZLPKMessageView.hidden = YES;
//                self.XSPAMessageView.hidden = YES;
//                self.xiansuobtn.hidden = YES;
//                self.xiansuoDaka.hidden = YES;
//                self.dakabtn.hidden = NO;
//                [self.gamgeIcon sd_setImageWithURL:[NSURL URLWithString:_gameingPoint.plantFiristImg]];
//                if (_gameingPoint.isFinished) {
//                    self.gameNameLab.text = _gameingPoint.pointName;
//                    self.gameContentLab.text = _gameingPoint.plantDesc;
//                }else{
//                    self.gameNameLab.text = @"";
//                    self.gameContentLab.text = @"";
//                }
//                self.gameDateLab.text = @"找到植物，点此打卡吧";
//            }else if([self.curEntryGame.gameType isEqualToString:@"ZLPK"]){
//                self.ZLPKMessageView.hidden = NO;
//                self.JTDXMessageView.hidden = YES;
//                self.XSPAMessageView.hidden = YES;
//                [self.zlpk_gamgeIcon sd_setImageWithURL:[NSURL URLWithString:_gameingPoint.plantFiristImg]];
//                self.zlpk_gameNameLab.text = _gameingPoint.pointName;
//                [self getPointOccupationData];
//                [self endQueryZLPKgamestatus];
//                [self ZLPKgamestatusQuery];
//            }else if([self.curEntryGame.gameType isEqualToString:@"XSPA"]){
//                if ([_gameingPoint.isEndPoint isEqualToString:@"Y"]) {
//                    self.JTDXMessageView.hidden = YES;
//                    self.ZLPKMessageView.hidden = YES;
//                    self.XSPAMessageView.hidden = NO;
//                }else{
//                    self.JTDXMessageView.hidden = NO;
//                    self.ZLPKMessageView.hidden = YES;
//                    self.XSPAMessageView.hidden = YES;
//                }
//
//                [self.gamgeIcon sd_setImageWithURL:[NSURL URLWithString:_gameingPoint.plantFiristImg]];
//                self.gameNameLab.text = _gameingPoint.pointName;
//                self.gameContentLab.text = _gameingPoint.plantDesc;
//                self.gameDateLab.text = @"找到植物，点此打卡吧";
//                self.XSPAContentLab.text = self.twoLineString;
//                self.xiansuobtn.hidden = NO;
//                self.xiansuoDaka.hidden = NO;
//                self.dakabtn.hidden = YES;
//                if (_gameingPoint.isFinished) {
//                    self.xiansuobtn.enabled = YES;
//                    self.xiansuobtn.backgroundColor = [UIColor colorWithHexRGB:0xffb400 alpha:1];
//                }else{
//                    self.xiansuobtn.enabled = NO;
//                    self.xiansuobtn.backgroundColor = [UIColor colorWithHexRGB:0x858585 alpha:1];
//                }
//            }
//        }
    }
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param view 取消选中的annotation view
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
//    if ([view.annotation isKindOfClass:[PlayingPointAnnotation class]]) {
//        PlayingPointAnnotation *curCreateP = (PlayingPointAnnotation *)view.annotation;
//        curCreateP.curCha.isSelected = NO;
//        YWRoundAnnotationView *refV =  (YWRoundAnnotationView *)view;
//        [refV showInfoWithPointInfo:curCreateP.curCha];
//    }
    //    self.JTDXMessageView.hidden = YES;
}

- (void)dealloc{
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
    self.gameInfoV = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
    self.gameInfoV = nil;
    
    [_locationManager stopUpdatingLocation];
    [_locationManager stopUpdatingHeading];
    _locationManager.delegate = nil;
}


@end
