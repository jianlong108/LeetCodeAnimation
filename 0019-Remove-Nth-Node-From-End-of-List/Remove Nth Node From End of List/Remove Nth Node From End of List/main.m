//
//  main.m
//  Remove Nth Node From End of List
//
//  Created by wangjianlong on 2019/3/20.
//  Copyright © 2019 wangjianlong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。
 
 示例：
 给定一个链表: 1->2->3->4->5, 和 n = 2.
 
 当删除了倒数第二个节点后，链表变为 1->2->3->5
 
 说明：
 给定的 n 保证是有效的。
 
 进阶：
 你能尝试使用一趟扫描实现吗？
 */


@interface ListNode : NSObject
@property (nonatomic, assign) int value;
@property (nonatomic, assign) ListNode *next;

+(instancetype)nodeWithValue:(int)value;

@end

//尾插
void creatLinkList(ListNode *h,int *n,int length)
{
    ListNode *tail = h;
    ListNode *temp;
    for (int i = 0; i < length; i++) {
        temp = [ListNode nodeWithValue:n[i]];
        tail.next = temp;
        tail = temp;
    }
}

//头插
void creatLinkListHead(ListNode *h,int *n,int length)
{
    ListNode *head = h;
    ListNode *temp;
    for (int i = 0; i < length; i++) {
        temp = [ListNode nodeWithValue:n[i]];
        temp.next = head.next;
        head.next = temp;
    }
    
}

//删除倒数第n个结点
ListNode * deleteLinkListNodeWithNthFromEnd(ListNode *h,NSUInteger n)
{
    if (lengthOfLinkList(h) < n) {
        return nil;
    }
    
    ListNode *dunmmyHead = [ListNode nodeWithValue:0];
    dunmmyHead.next = h;
    
    ListNode *p = dunmmyHead;
    ListNode *q = dunmmyHead;
    
    for (int i = 0; i< n+1; i++) {
        if (!q) {
            return nil;
        }
        
        q = q.next;
    }
    
    while (q) {
        q = q.next;
        p = p.next;
    }
    
    ListNode *delNode = p.next;
    p.next = delNode.next;
    [delNode release];
    
    ListNode *retNode = dunmmyHead.next;
    [dunmmyHead release];
    
    return retNode;
    
}

int lengthOfLinkList(ListNode *l)
{
    ListNode *tmp = l;
    int len = 0;
    while (tmp) {
        len++;
        tmp = tmp.next;
    }
    return len;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a[7] = {2,4,3,7,8,6,11};
        
        ListNode *l1 = [ListNode nodeWithValue:88];
        creatLinkList(l1, a,7);
        
        //使用临时指针，保持l1指针依然指向头结点
        ListNode *tmp = l1.next;
        while (tmp) {
            NSLog(@"%d",tmp.value);
            tmp = tmp.next;
        }
        NSLog(@"begin delete");
        
        l1 = deleteLinkListNodeWithNthFromEnd(l1, 2);
        ListNode *tmp1 = l1.next;
        while (tmp1) {
            NSLog(@"%d",tmp1.value);
            tmp1 = tmp1.next;
        }
        
        while (l1) {
            ListNode *tmp = l1;
            [tmp release];
            l1 = l1.next;
        }
    }
    return 0;
}




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
