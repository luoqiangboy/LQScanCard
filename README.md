# LQScanCard
身份证、银行卡扫描Demo

目前项目有需求需要做这个功能所以网上下了很多demo然后进行了一个代码优化整合而已。
一个扫描的速度还可以但是有部分银行卡扫描不上，具体什么原因网上搜了一下也不知道。
传图片识别目前还在研究中，主要是UIImage 转 CVImageBufferRef 然后规格钥匙1280 * 720
这个过程不清楚怎么弄，主要的问题有两个1.是选中的图片尺寸是很大的 2. 如何转成1280 * 720 的CVImageBufferRef
如果你清楚这个过程希望大家能一起讨论
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
