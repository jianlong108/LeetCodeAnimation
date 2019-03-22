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
    return arr_m.copy;
}

//time(nlogn) space(1)

NSArray<NSNumber *>* merge(NSArray<NSNumber *> *left,NSArray<NSNumber *>*right)
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:left.count+right.count];
    while (left.count > 0 && right.count > 0) {
        if ([left[0] intValue] <= [right[0] intValue]) {
            [result addObject:left[0]];
            left = [left subarrayWithRange:NSMakeRange(1, left.count-1)];
        } else {
            [result addObject:right[0]];
            right = [right subarrayWithRange:NSMakeRange(1, right.count-1)];
        }
    }
    while (left.count > 0) {
        [result addObject:left[0]];
        left = [left subarrayWithRange:NSMakeRange(1, left.count-1)];
    }
    while (right.count > 0) {
        [result addObject:right[0]];
        right = [right subarrayWithRange:NSMakeRange(1, right.count-1)];
    }
    return result;
}
//归并算法
NSArray<NSNumber *>*MergeSort(NSArray<NSNumber *> *array)
{
    NSMutableArray *arr_m = array.mutableCopy;
    if (arr_m.count < 2) {
        return arr_m.copy;
    }
    
    int middle = (int)(arr_m.count / 2);
    NSArray *left = [arr_m subarrayWithRange:NSMakeRange(0, middle)];
    NSArray *right = [arr_m subarrayWithRange:NSMakeRange(middle, arr_m.count-middle)];
    
    return merge(MergeSort(left), MergeSort(right));
}

//快排
void swapFunc(NSMutableArray<NSNumber *> *arr,int i,int j)
{
    NSNumber *tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
    
}

int partition(NSMutableArray<NSNumber *> *arr,int left,int right)
{
    int partiton = left;
    int index = partiton + 1;
    for (int i = index; i <= right; i++) {
        if ([arr[i] intValue] < [arr[partiton] intValue]) {
            if (index != i) {
                swapFunc(arr, i, index);
            }
            
            index++;
        }
    }
    swapFunc(arr, partiton, index-1);
    return index - 1;
}

NSArray<NSNumber *>*sort(NSMutableArray<NSNumber *> *array,int left,int right)
{
    if (left < right) {
        //找到基准值
        int p = partition(array, left, right);
        //排列基准左边序列
        sort(array, left, p-1);
        //排列基准右边序列
        sort(array, p+1, right);
    }
    return array;
}

NSArray<NSNumber *>*QuickSort(NSArray<NSNumber *> *array)
{
    NSMutableArray *arr_m = array.mutableCopy;
    return sort(arr_m,0,(int)(arr_m.count-1));
}

void heapify(NSMutableArray<NSNumber *> *arr, int i, int len) {
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    int largest = i;
    if (left < len && arr[left] > arr[largest]) {
        largest = left;
    }
    if (right < len && arr[right] > arr[largest]) {
        largest = right;
    }
    if (largest != i) {
        swapFunc(arr, i, largest);
        heapify(arr, largest, len);
    }
}

void buildMaxHeap(NSMutableArray<NSNumber *> *arr, int len) {
    for (int i = (int)(len / 2); i >= 0; i--) {
        heapify(arr, i, len);
    }
}
NSArray<NSNumber *> * heapSort(NSArray<NSNumber *> *array) {
    // 对 arr 进行拷贝，不改变参数内容
    NSMutableArray *arr_m = array.mutableCopy;
    
    int len = (int)arr_m.count;
    buildMaxHeap(arr_m, len);
    for (int i = len - 1; i > 0; i--) {
        swapFunc(arr_m, 0, i);
        len--;
        heapify(arr_m, 0, len);
    }
    return arr_m;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSArray *a = bubbleSort(@[@(1),@(3),@(2),@(7),@(5)]);
//        NSLog(@"%@",a);
//
//        NSArray *b = SelectionSort(@[@(1),@(3),@(2),@(7),@(5)]);
//        NSLog(@"%@",b);
//
//        NSArray *c = InsertSort(@[@(2),@(5),@(3),@(7),@(1)]);
//        NSLog(@"%@",c);
//
//        NSArray *d = shellSort(@[@(8),@(9),@(1),@(7),@(2),@(3),@(5),@(4),@(6),@(0)]);
//        NSLog(@"%@",d);
//        NSArray *e = MergeSort(@[@(8),@(9),@(1),@(7),@(2),@(3),@(5),@(4),@(6),@(0)]);
//        NSLog(@"%@",e);
        
        
//        NSArray *f = QuickSort(@[@(8),@(9),@(1),@(7),@(2),@(3),@(5),@(4),@(6),@(0)]);
//        NSLog(@"%@",f);
        
        NSArray *g = heapSort(@[@(8),@(9),@(1),@(7),@(2),@(3),@(5),@(4),@(6),@(0)]);
        NSLog(@"%@",g);
    }
    return 0;
}
