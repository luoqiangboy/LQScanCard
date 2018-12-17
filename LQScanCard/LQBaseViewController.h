//
//  LQBaseViewController.h
//  LQScanCard
//
//  Created by Mini-LuoQiang on 2018/12/14.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQBaseViewController : UIViewController

@property (nonatomic, strong) UIImage *selectImage;

- (BOOL)getAuthorizationStatus;

- (void)choosePhoto;
- (void)updateUI;

@end

NS_ASSUME_NONNULL_END
