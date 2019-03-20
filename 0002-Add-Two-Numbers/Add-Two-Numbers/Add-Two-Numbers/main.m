//
//  main.m
//  Add-Two-Numbers
//
//  Created by wangjianlong on 2019/3/19.
//  Copyright © 2019 wangjianlong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
 
 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
 
 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 
 示例：
 
 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
 输出：7 -> 0 -> 8
 原因：342 + 465 = 807
 */
@interface ListNode : NSObject
@property (nonatomic, assign) int value;
@property (nonatomic, assign) ListNode *next;

+(instancetype)nodeWithValue:(int)value;

@end
@implementation ListNode

+(instancetype)nodeWithValue:(int)value
{
    ListNode *node = [[ListNode alloc]init];
    
    node.value = value;
    node.next = NULL;
    return node;
}

- (void)dealloc
{
    [super dealloc];
    NSLog(@"dealloc == %d",self.value);
}

@end

int getlength(ListNode *node)
{
    ListNode *tmp = node;
    int length = 0;
    while (tmp) {
        length ++;
        tmp = tmp.next;
    };
    
    return length;
}


//time(n) , space(1)
ListNode * addTwoNums(ListNode *n1,ListNode*n2)
{
    if (n1 == nil) {
        return n2;
    }
    if (n2 == nil) {
        return n1;
    }
    ListNode *l1 = n1;
    ListNode *l2 = n2;
    int len1 = getlength(l1);
    int len2 = getlength(l2);
    
    ListNode *tmpL1 = len1 > len2 ? n1 :n2;
    ListNode *tmpL2 = len1 > len2 ? n2 :n1;
    ListNode *pre = nil;
    //进位数
    int carr = 0;
    while (tmpL1) {
        int a = tmpL1.value;
        int b = tmpL2 ? tmpL2.value : 0;
        tmpL1.value = (a + b + carr) % 10;
        carr = (a + b + carr) / 10;
        
        pre = tmpL1;
        tmpL1 = tmpL1.next;
        tmpL2 = tmpL2 ? tmpL2.next : nil;
    }
    pre.next = carr ? [ListNode nodeWithValue:carr] : nil;
    return len1 > len2 ? n1 : n2;
}

//生成链表
void creatLinkListHead(ListNode *l,int *n,int len)
{
    ListNode *head = l;
    ListNode *tmp;
    for (int i=0; i<len; i++) {
        tmp = [ListNode nodeWithValue:n[i]];
        head.next = tmp;
        head = tmp;
    }
    
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a[3] = {2,4,3};
        int b[3] = {5,6,4};
        
        //再生成链表的时候，使用尾插和头插，会产生两种不同的结果。
        
        ListNode *l1 = [ListNode nodeWithValue:3];
        creatLinkListHead(l1, a,3);
//        while (l1.next) {
//            NSLog(@"%d",l1.next.value);
//            l1 = l1.next;
//        }
        
        ListNode *l2 = [ListNode nodeWithValue:3];
        creatLinkListHead(l2, b,3);
        
//        while (l2.next) {
//            NSLog(@"%d",l2.next.value);
//            l2 = l2.next;
//        }
        
        ListNode *n = addTwoNums(l1.next, l2.next);
        ListNode *temp = nil;
        while (n) {
            NSLog(@"%d",n.value);
            temp = n;
            n = n.next;
            [temp release];
        }
    
    
    }
    return 0;
}

