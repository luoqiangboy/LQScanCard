//
//  LQBaseViewController.m
//  LQScanCard
//
//  Created by Mini-LuoQiang on 2018/12/14.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import "LQBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHPhotoLibrary.h>
#import "UIAlertController+LQExtend.h"
#import "LQImageCropper.h"
#import "UIImage+LQExtend.h"

@interface LQBaseViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,LQImageCropperDelegate>

@end

@implementation LQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)getAuthorizationStatus {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        [self showTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中\n允许访问相机"];
        return NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getAuthorizationStatus];
                });
            }
        }];
        return NO;
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self showTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中\n允许访问相册"];
        return NO;
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        NSInteger status = [PHPhotoLibrary authorizationStatus];
        if (status == 0) {
            return YES;
        }
        
        return status == 3;
        return NO;
    } else {
        return YES;
    }
}

- (void)showTitle:(NSString *)title message:(NSString *)message {
    [UIAlertController showAlertInViewController:self
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:@"了解"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@[@"去设置"]
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            if (buttonIndex == 2) {
                                                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                                    if (@available(iOS 10.0, *)) {
                                                        [[UIApplication sharedApplication] openURL:url options:@{}
                                                                                 completionHandler:^(BOOL success) {
                                                                                 }];
                                                    } else {
                                                        [[UIApplication sharedApplication] openURL:url];
                                                    }
                                                }
                                            }
                                        }];
}

- (void)choosePhoto {
    BOOL flag = [self getAuthorizationStatus];
    if (!flag) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 点击完成按钮的选取图片的回掉
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 获取编辑后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.selectImage = image;
    
    
    [picker dismissViewControllerAnimated:NO completion:^{
        // 这个部分代码 视情况而定
        if (@available(iOS 11.0, *)){
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }

    }];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        // 这个部分代码 视情况而定
        if (@available(iOS 11.0, *)){
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }];
}

-(void)lqImageCropping:(LQImageCropper *)cropping didCropImage:(UIImage *)image {
    self.selectImage = [self imageResize:image andResizeTo:CGSizeMake(640, 360)];
    [self updateUI];
}


-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize  {
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
