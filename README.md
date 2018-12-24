# LQScanCard
身份证、银行卡扫描Demo

```ruby
目前项目有需求需要做这个功能所以网上下了很多demo然后进行了一个代码优化整合而已。
一个扫描的速度还可以但是有部分银行卡扫描不上，具体什么原因网上搜了一下也不知道。
传图片识别目前还在研究中，主要是UIImage 转 CVImageBufferRef 然后规格钥匙1280 * 720
这个过程不清楚怎么弄，主要的问题有两个
1.是选中的图片尺寸是很大的 
2. 如何转成1280 * 720 的CVImageBufferRef
还有一个方式就是还有一个c语言的方法是传图片途径但是我还是没搞明白怎么传参
如果你清楚这个过程希望大家能一起讨论，后续搞明白后持续更新

##使用需要注意的地方

1.工程直接拖入LQScanCardORC文件即可
2.工程设置里面   Build Setting 里 Enable Bitcode  设置为 NO   和 Enable Testability  设置为NO 即可
3.选择真机即可（如果还是编译有问题请自行百度了）
```
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
