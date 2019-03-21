//
//  main.m
//  Ten Sort
//
//  Created by wangjianlong on 2019/3/20.
//  Copyright © 2019 wangjianlong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 1. 冒泡排序
 1.1 算法步骤
 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 
 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。这步做完后，最后的元素会是最大的数。
 
 针对所有的元素重复以上的步骤，除了最后一个。
 
 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 */

//time(n^2) space(1)
NSArray<NSNumber *>* bubbleSort(NSArray<NSNumber *> *array)
{
    NSMutableArray *arr_m = array.mutableCopy;
    
    //降序
    for (int i = 0; i < array.count; i++) {
        for (int j = i; j < array.count; j++) {
            if ([arr_m[i] intValue] < [arr_m[j] intValue]) {
                NSNumber *tmp = arr_m[j];
                arr_m[j] = arr_m[i];
                arr_m[i] = tmp;
            }
        }
    }
    
    
    return arr_m.copy;
}

/*选择排序
 算法步骤
    首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置
 
    再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 
    重复第二步，直到所有元素均排序完毕。
 */
//time(n^2) space(1)
NSArray<NSNumber *>* SelectionSort(NSArray<NSNumber *> *array)
{
    NSMutableArray *arr_m = array.mutableCopy;
    for (int i = 0; i < array.count; i++) {
        int min = i;
        for (int j = i+1; j < array.count; j++) {
            if ([arr_m[min] intValue] > [arr_m[j] intValue]) {
                min = j;
            }
        }
        if (min != i) {
            NSNumber *tmp = arr_m[min];
            arr_m[min] = arr_m[i];
            arr_m[i] = tmp;
        }
    }
    return arr_m.copy;
}

/*
 插入排序
 3.1 算法步骤
 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。
 
 从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。（如果待插入的元素与有序序列中的某个元素相等，则将待插入元素插入到相等元素的后面。）
 
 */
//time(n^2) space(1)
NSArray<NSNumber *>*InsertSort(NSArray<NSNumber *> *array)
{
    NSMutableArray *arr_m = array.mutableCopy;
    
    for (int i = 1; i < array.count; i++) {
        
        //记录要插入的数据
        NSNumber *tmp = arr_m[i];
        // 从已经排序的序列最右边的开始比较，在已经排序的序列中找到比其小的数
        int j = i;
        while (j > 0 && j < arr_m.count && [tmp intValue] < [arr_m[j - 1] intValue]) {
            arr_m[j] = arr_m[j-1];
            j--;
        }
        if (j!=i) {
            arr_m[j] = tmp;
        }
    }
    
    return arr_m.copy;
}

//time(nlogn) space(1)
NSArray<NSNumber *>*shellSort(NSArray<NSNumber *> *array)
{
    NSMutableArray *arr_m = array.mutableCopy;
    
    int gap =1;
    while (gap < arr_m.count) {
        gap = 3*gap + 1;
    }
    
    while (gap > 0) {
        for (int i = gap; i < array.count; i++) {
            NSNumber *tmp = arr_m[i];
            int j = i - gap;
            while (j>= 0 && [arr_m[j] intValue] > tmp.intValue) {
                arr_m[j+gap] = arr_m[j];
                j -= gap;
            }
            arr_m[j+gap] = tmp;
        }
        gap = (int)(gap/3);
    }
    
    for (int i = 1; i < array.count; i++) {
        
        //记录要插入的数据
        NSNumber *tmp = arr_m[i];
        // 从已经排序的序列最右边的开始比较，在已经排序的序列中找到比其小的数
        int j = i;
        while (j > 0 && j < arr_m.count && [tmp intValue] < [arr_m[j - 1] intValue]) {
            arr_m[j] = arr_m[j-1];
            j--;
        }
        if (j!=i) {
            arr_m[j] = tmp;
        }
    }
    
    return arr_m.copy;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *a = bubbleSort(@[@(1),@(3),@(2),@(7),@(5)]);
        NSLog(@"%@",a);
        
        NSArray *b = SelectionSort(@[@(1),@(3),@(2),@(7),@(5)]);
        NSLog(@"%@",b);
        
        NSArray *c = InsertSort(@[@(2),@(5),@(3),@(7),@(1)]);
        NSLog(@"%@",c);
        
        NSArray *d = shellSort(@[@(8),@(9),@(1),@(7),@(2),@(3),@(5),@(4),@(6),@(0)]);
        NSLog(@"%@",d);
        
    }
    return 0;
}
