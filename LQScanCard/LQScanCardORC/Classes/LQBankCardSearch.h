//
//  LQBankCardSearch.h
//  LQIDCardORC
//
//  Created by Mini-LuoQiang on 2018/12/5.
//  Copyright © 2018年 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQBankCardSearch : NSObject
/**
 *  查询是哪个银行
 *
 *  @param numbers 获取的numbers
 *  @param nCount  数组个数
 *
 *  @return 所属银行
 */
+ (NSString *)getBankNameByBin:(char *)numbers count:(int)nCount;

@end

NS_ASSUME_NONNULL_END
