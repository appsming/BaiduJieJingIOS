//
//  PanoShowViewController.m
//  TestIJieJingForMap
//
//  Created by tao song on 2017/8/31.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "PanoShowViewController.h"

#import <BaiduPanoSDK/BaiduPanoramaView.h>
#import <BaiduPanoSDK/BaiduPanoUtils.h>
#import "PanoFpsLabel.h"

@interface PanoShowViewController ()<BaiduPanoramaViewDelegate>
@property(strong, nonatomic) PanoFpsLabel *fpsLabel;// 是否掉帧
@property(strong, nonatomic) BaiduPanoramaView  *panoramaView;
@end

@implementation PanoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self customPanoView];
    [self customPanoFPSLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)dealloc {
    [self.panoramaView removeFromSuperview];
    self.panoramaView.delegate = nil;
    self.panoramaView = nil;
}

- (void)customPanoView {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth([self getFixedScreenFrame]), CGRectGetHeight([self getFixedScreenFrame]));
    
    // key 为在百度LBS平台上统一申请的接入密钥ak 字符串
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:frame key:@"QMrtAI8klYhMBrI9Sq7B5Wmk8oQRUeGo"];
    // 为全景设定一个代理
    self.panoramaView.delegate = self;
    [self.view addSubview:self.panoramaView];
    // 设定全景的清晰度， 默认为middle
    [self.panoramaView setPanoramaImageLevel:ImageDefinitionLow];
    
    [self.panoramaView setPanoramaWithLon:116.413467 lat:39.916706]; // 北京

    
}


- (void)customPanoFPSLabel {
    _fpsLabel = [ PanoFpsLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.frame = CGRectMake(20.0f, self.view.frame.size.height-40, 60.0f, 25.0f);
    [self.view addSubview:_fpsLabel];
}


#pragma mark - panorama view delegate

- (void)panoramaWillLoad:(BaiduPanoramaView *)panoramaView {
    
}

- (void)panoramaDidLoad:(BaiduPanoramaView *)panoramaView descreption:(NSString *)jsonStr {
       NSLog(@"=======panoramaDidLoad========%@",jsonStr);
}


- (void)panoramaLoadFailed:(BaiduPanoramaView *)panoramaView error:(NSError *)error {
    
       NSLog(@"=======panoramaLoadFailed==%ld======%@",error.code,error.userInfo);
    
    if (error.code == 102) {
        
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"此处暂无街景！" preferredStyle:UIAlertControllerStyleAlert];
     
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
           [self.navigationController  popViewControllerAnimated:YES];
    
            NSLog(@"==============");
        }];
        [alertController addAction:okAction];
        
     
        
      [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
}

- (void)panoramaView:(BaiduPanoramaView *)panoramaView overlayClicked:(NSString *)overlayId {
    
       NSLog(@"=======overlayClicked========%@",overlayId);
}

- (void)panoramaView:(BaiduPanoramaView *)panoramaView didReceivedMessage:(NSDictionary *)dict {
    
    NSLog(@"=======didReceivedMessage========%@",dict);
    
}






//获取设备bound方法
- (BOOL)isPortrait {
    UIInterfaceOrientation orientation = [self getStatusBarOritation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    }
    return NO;
}
- (UIInterfaceOrientation)getStatusBarOritation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    return orientation;
}
- (CGRect)getFixedScreenFrame {
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
#ifdef NSFoundationVersionNumber_iOS_7_1
    if(![self isPortrait]&& (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)) {
        mainScreenFrame = CGRectMake(0, 0, mainScreenFrame.size.height, mainScreenFrame.size.width);
    }
#endif
    return mainScreenFrame;
}


@end
