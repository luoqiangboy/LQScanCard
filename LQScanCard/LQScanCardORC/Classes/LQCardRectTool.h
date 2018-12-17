//
//  LQCardRectTool.h
//  Demo
//
//  Created by Mini-LuoQiang on 2018/12/6.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQCardRectTool : NSObject

@property (nonatomic, assign)CGRect subRect;

+ (CGRect)getEffectImageRect:(CGSize)size;
+ (CGRect)getGuideFrame:(CGRect)rect;

+ (int)docode:(unsigned char *)pbBuf len:(int)tLen;
+ (CGRect)getCorpCardRect:(int)width  height:(int)height guideRect:(CGRect)guideRect charCount:(int) charCount;

+ (char *)getNumbers;

+ (NSBundle *)getImageBundle;

@end

NS_ASSUME_NONNULL_END
