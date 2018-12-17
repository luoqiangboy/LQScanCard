//
//  LQIDCardViewController.m
//  LQScanCard
//
//  Created by Mini-LuoQiang on 2018/12/14.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import "LQIDCardViewController.h"
#import "LQScanViewController.h"
#import "LQScanManager.h"
#import "UIImage+LQExtend.h"

@interface LQIDCardViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic, copy) NSDictionary *dic;
@end

@implementation LQIDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)scanCard:(UIButton *)sender {
    BOOL flag = [self getAuthorizationStatus];
    if (!flag) {
        return;
    }
    LQScanViewController *vc = [[LQScanViewController alloc] initWithType:LQScaningTypeIDCard];
    vc.finish = ^(NSMutableDictionary * _Nonnull info, UIImage * _Nonnull image) {
        self.imageView.image = image;
        self.dic = [info copy];
        [self p_updateUI];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)p_updateUI {
    NSArray *allKeys = [self.dic allKeys];
    [allKeys enumerateObjectsUsingBlock:^(NSString *  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = self.labels[idx];
        label.text = [NSString stringWithFormat:@"%@: %@",key,self.dic[key]];
    }];
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
    LQScanManager *manager = [[LQScanManager alloc] init];
    manager.finish = ^(NSMutableDictionary * _Nonnull info, UIImage * _Nonnull image) {
        self.dic = [info copy];
        [self p_updateUI];
    };
    [manager parseIDScanImageBuffer:[UIImage pixelBufferFromCGImage:self.selectImage]];
}

@end
