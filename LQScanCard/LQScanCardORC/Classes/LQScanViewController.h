//
//  LQScanViewController.h
//  LQIDCardORC
//
//  Created by Mini-LuoQiang on 2018/12/5.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQScaningView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQScanViewController : UIViewController

@property (nonatomic, assign) LQScaningType type;


/**
 扫描成功block返回数据
 */
@property (nonatomic,copy) void(^finish)(NSMutableDictionary *info,UIImage *image);


/**
 初始化扫描VC

 @param type 扫描卡类型
 @return LQScanViewController
 */
- (instancetype)initWithType:(LQScaningType)type;

@end

NS_ASSUME_NONNULL_END
