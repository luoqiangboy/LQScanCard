# LQScanCard
身份证、银行卡扫描Demo

```ruby
#import "LQScanViewController.h"
```
```ruby
typedef enum : NSUInteger {
LQScaningTypeBank, 
LQScaningTypeIDCard,
} LQScaningType;
```
```ruby
#import "LQScanViewController.h"
```
```ruby
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
```


```ruby
//创建VC
LQScanViewController *vc = [[LQScanViewController alloc] initWithType:LQScaningTypeIDCard];
vc.finish = ^(NSMutableDictionary * _Nonnull info, UIImage * _Nonnull image) {

};
[self presentViewController:vc animated:YES completion:nil];
```
