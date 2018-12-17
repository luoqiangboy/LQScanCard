//
//  LQScaningView.h
//  LQIDCardORC
//
//  Created by Mini-LuoQiang on 2018/12/5.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LQScaningTypeBank, 
    LQScaningTypeIDCard,
} LQScaningType;

@interface LQScaningView : UIView

@property (nonatomic, assign) LQScaningType scanType;

@property (nonatomic,copy)void (^turnOnOrOffClick)(BOOL isSelectState);

@end

NS_ASSUME_NONNULL_END
