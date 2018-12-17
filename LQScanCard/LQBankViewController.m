//
//  LQBankViewController.m
//  LQScanCard
//
//  Created by Mini-LuoQiang on 2018/12/14.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import "LQBankViewController.h"
#import "LQScanViewController.h"
#import "LQScanManager.h"
#import "UIImage+LQExtend.h"

@interface LQBankViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *NumberTextField;
@property (nonatomic, copy) NSDictionary *dic;

@end

@implementation LQBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)scanBank:(UIButton *)sender {
    BOOL flag = [self getAuthorizationStatus];
    if (!flag) {
        return;
    }
    LQScanViewController *vc = [[LQScanViewController alloc] initWithType:LQScaningTypeBank];
    vc.finish = ^(NSMutableDictionary * _Nonnull info, UIImage * _Nonnull image) {
        self.imageView.image = image;
        self.dic = [info copy];
        self.bankNameTextField.text = [info objectForKey:@"bankName"];
        self.NumberTextField.text = [info objectForKey:@"bankNumber"];
    };
     [self presentViewController:vc animated:YES completion:nil];
}



- (IBAction)ChoosePhoto:(UIButton *)sender {
    [self choosePhoto];
}

- (void)updateUI {
    self.imageView.image = self.selectImage;
    if (!self.selectImage) {
        return;
    }
    // 进行图片解析
//    LQScanManager *manager = [[LQScanManager alloc] init];
//    manager.finish = ^(NSMutableDictionary * _Nonnull info, UIImage * _Nonnull image) {
//        self.dic = [info copy];
//        self.bankNameTextField.text = [info objectForKey:@"bankName"];
//        self.NumberTextField.text = [info objectForKey:@"bankNumber"];
//    };
//    [manager parseBankImageBuffer:[UIImage pixelBufferFromCGImage:self.selectImage]];
}


@end
