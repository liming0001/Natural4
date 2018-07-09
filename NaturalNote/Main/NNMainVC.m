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

@interface NNMainVC ()<BMKMapViewDelegate,BMKLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImg;
@property (weak, nonatomic) IBOutlet UIButton *lifeEngyValue;
@property (weak, nonatomic) IBOutlet UIButton *engyValue;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;

//定位
@property(nonatomic, strong) BMKLocationManager *locationManager;
@end

@implementation NNMainVC

-(void)initLocation
{
    [_mapView setZoomLevel:21];
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [_mapView updateLocationViewWithParam:displayParam];
    
    _locationManager = [[BMKLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
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
//    _locService.delegate = self;
//    //每次进入页面，当游戏点为空，或者已经已经登录成功，都获取一次所有游戏点数据
//    if (self.gamesA.count ==0 ||[CommonUtility sharedManager].isLoginAgain) {
//        [CommonUtility sharedManager].isLoginAgain = NO;
//        [self getAllGames];
//    }
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
    
    //开启地图定位
    [self initLocation];
    
//    NNLoginWeChatVC *loginVC = [[NNLoginWeChatVC alloc]initWithNibName:@"NNLoginWeChatVC" bundle:nil];
//    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)mapBtnAction:(UIButton *)sender {
    
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
/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error
{
    
    NSLog(@"serial loc error = %@", error);
    
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error
{
    if (error)
    {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
            MyLocation * loc = [[MyLocation alloc]initWithLocation:location.location withHeading:nil];
            [_mapView updateLocationData:loc];
        }
    }  
}
/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"serial loc CLAuthorizationStatus = %d", status);
}

- (void)dealloc{
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
    
    [_locationManager stopUpdatingLocation];
    [_locationManager stopUpdatingHeading];
    _locationManager.delegate = nil;
}


@end
