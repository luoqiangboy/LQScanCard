//
//  LQScanBase.h
//  LQIDCardORC
//
//  Created by Mini-LuoQiang on 2018/12/5.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    LQScanTypeBank,
    LQScanTypeIDCard,
} LQScanType;

NS_ASSUME_NONNULL_BEGIN

@interface LQScanBase : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) BOOL verify;

@property (nonatomic, assign) LQScanType scanType;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, copy) NSString *sessionPreset; // 图片质量

@property (nonatomic, assign) BOOL isInProcessing;

@property (nonatomic, assign) BOOL isHasResult;

//出流
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
//输入流
@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput;

// 能否切换前置后置
- (BOOL)canSwitchCameras;

- (AVCaptureDevice *)activeCamera;

- (AVCaptureDevice *)inactiveCamera;
// 闪关灯
- (AVCaptureFlashMode)flashMode;
// 有无手电筒
- (BOOL)cameraHasTorch;

- (AVCaptureTorchMode)torchMode;
// 能否调整焦距
- (BOOL)cameraSupportsTapToFocus;

@property (nonatomic,copy) void(^finish)(NSMutableDictionary *info,UIImage *image);

@end

NS_ASSUME_NONNULL_END

