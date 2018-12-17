//
//  LQScanViewController.m
//  LQIDCardORC
//
//  Created by Mini-LuoQiang on 2018/12/5.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import "LQScanViewController.h"
#import "LQScanManager.h"
#import "LQCardRectTool.h"

@interface LQScanViewController ()

@property (nonatomic, strong)LQScanManager *scanManager;
// 是否打开手电筒
@property (nonatomic,assign,getter = isTorchOn) BOOL torchOn;
@property (nonatomic,assign) BOOL isHaveCamera;

@end

@implementation LQScanViewController

- (instancetype)initWithType:(LQScaningType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isHaveCamera) {
        [self.scanManager doSomethingWhenWillDisappear];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isHaveCamera) {
        self.torchOn = NO;
        [self.scanManager doSomethingWhenWillAppear];
    }else
    {
        [self showAlert];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContant];
}

- (void)initContant {
    self.view.backgroundColor = [UIColor blackColor];
    BOOL flag = NO;
    if (self.type == LQScanTypeIDCard) {
        self.title = @"扫描身份证";
        flag = [self.scanManager configIDScanManager];
    }else{
        self.title = @"扫描银行卡";
        flag = [self.scanManager configBankScanManager];
    }
    
    self.scanManager.sessionPreset = AVCaptureSessionPreset1280x720;
    
    if (flag) {
        self.isHaveCamera = YES;
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:view atIndex:0];
        
        AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.scanManager.captureSession];
        preLayer.frame = [UIScreen mainScreen].bounds;
        
        preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [view.layer addSublayer:preLayer];
        [self.scanManager startSession];
        
        __weak __typeof(self) weakSelf = self;
        CGFloat width = [UIScreen mainScreen].bounds.size.width/375.0f;
        // 添加自定义的扫描界面（中间有一个镂空窗口和来回移动的扫描线）
        LQScaningView * scaningView = [[LQScaningView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width - 60*width, 400*width)];
        scaningView.center = self.view.center;
        scaningView.scanType = self.type;
        [self.view addSubview:scaningView];
        scaningView.turnOnOrOffClick = ^(BOOL isSelectState)
        {
            [weakSelf turnOnOrOffTorch];
        };
        self.scanManager.finish = ^(NSMutableDictionary * info, UIImage *image) {
            if (weakSelf.finish) {
                [weakSelf close];
                weakSelf.finish(info , image);
            }
        };
    }
    else {
        NSLog(@"打开相机失败");
    }
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"idcard_back" inBundle:[LQCardRectTool getImageBundle] compatibleWithTraitCollection:nil];
    [closeBtn setImage:image forState:UIControlStateNormal];
    CGFloat closeBtnWidth = 40;
    CGFloat closeBtnHeight = closeBtnWidth;
    CGRect viewFrame = self.view.frame;
    closeBtn.frame = (CGRect){CGRectGetMaxX(viewFrame) - closeBtnWidth-16, CGRectGetMaxY(viewFrame) - closeBtnHeight-16, closeBtnWidth, closeBtnHeight};
    
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeBtn];
}

- (void)showAlert {
    
}

#pragma mark - 打开／关闭手电筒
-(void)turnOnOrOffTorch {
    self.torchOn = !self.isTorchOn;
    
    if (self.isTorchOn)
    {
        [self.scanManager setTorchMode:AVCaptureTorchModeOn];
    }
    else
    {
        [self.scanManager setTorchMode:AVCaptureTorchModeOff];
    }
}
- (LQScanManager *)scanManager {
    if (!_scanManager) {
        _scanManager = [[LQScanManager alloc] init];
    }
    return _scanManager;
}

#pragma mark 绑定“关闭按钮”的方法
-(void)close {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
