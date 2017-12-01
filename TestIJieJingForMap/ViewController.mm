//
//  ViewController.m
//  TestIJieJingForMap
//
//  Created by tao song on 2017/8/31.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "ViewController.h"
#import "PanoShowViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton  *panoBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 400, 45)];
    
    [panoBtn setTitle:@"看街景" forState:UIControlStateNormal];
    [panoBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:panoBtn];
    
    [panoBtn addTarget:self action:@selector(jumpPanoSdk) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jumpPanoSdk{

    NSLog(@"=====jumpPanoSdk========");
    
    PanoShowViewController *psVC = [[PanoShowViewController alloc]init];
      [self.navigationController pushViewController:psVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
