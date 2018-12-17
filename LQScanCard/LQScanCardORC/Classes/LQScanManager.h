//
//  LQScanManager.h
//  LQIDCardORC
//
//  Created by Mini-LuoQiang on 2018/12/5.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import "LQScanBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQScanManager : LQScanBase

- (void)configIDScan;

- (BOOL)configOutPutAtQue:(dispatch_queue_t)queue;

- (BOOL)configInPutAtQue:(dispatch_queue_t)queue;

- (void)configConnection;


- (void)startSession;

- (void)stopSession;

- (void)resetConfig;

- (void)resetParams;

- (void)doSomethingWhenWillAppear;

- (void)doSomethingWhenWillDisappear;

- (void)parseBankImageBuffer:(CVImageBufferRef)imageBuffer;

- (void)parseIDScanImageBuffer:(CVImageBufferRef)imageBuffer;
//选择前置和后置
- (BOOL)switchCameras;
// 闪关灯
- (void)setFlashMode:(AVCaptureFlashMode)flashMode;
// 手电筒
- (void)setTorchMode:(AVCaptureTorchMode)torchMode;
// 焦距
- (void)focusAtPoint:(CGPoint)point;
// 曝光量
- (void)exposeAtPoint:(CGPoint)point;
//重置曝光
- (void)resetFocusAndExposureModes;




- (BOOL)configBankScanManager;

- (BOOL)configIDScanManager;

@end

NS_ASSUME_NONNULL_END
