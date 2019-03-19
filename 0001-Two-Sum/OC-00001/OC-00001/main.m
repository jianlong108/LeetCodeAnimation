//
//  main.m
//  OC-00001
//
//  Created by wangjianlong on 2019/3/19.
//  Copyright © 2019 wangjianlong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 
 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
 
 */

NSMutableArray* twoSum(NSArray <NSNumber *>*a,int target)
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    [a enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int offset = target - obj.intValue;
        NSNumber *tmp = [dic objectForKey:@(offset)];
        if (tmp) {
            *stop = YES;
            [arr addObject:@(idx)];
            [arr addObject:tmp];
        }
        [dic setObject:@(idx) forKey:obj];
    }];
    return arr;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *arr = twoSum(@[@0,@4,@2,@0],6);
        if (arr.count > 0) {
            NSLog(@"%d,%d",[arr[0] intValue],[arr[1] intValue]);
        } else {
            NSLog(@"vaild input");
        }
    }
    return 0;
}
