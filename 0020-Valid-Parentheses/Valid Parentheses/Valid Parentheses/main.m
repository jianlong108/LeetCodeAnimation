//
//  main.m
//  Valid Parentheses
//
//  Created by wangjianlong on 2019/3/20.
//  Copyright © 2019 wangjianlong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
 
 有效字符串需满足：
 
 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 注意空字符串可被认为是有效字符串。
 
 示例 1:
 输入: "()"
 输出: true
 
 示例 2:
 输入: "()[]{}"
 输出: true
 
 示例 3:
 输入: "(]"
 输出: false
 
 示例 4:
 输入: "([)]"
 输出: false
 
 示例 5:
 输入: "{[]}"
 输出: true

 */


@interface StackNode : NSObject
{
    @public
    char c;
}
@property (nonatomic, strong) StackNode *next;
+ (instancetype)stackNodeWithChar:(char)c;

@end

@implementation StackNode

+ (instancetype)stackNodeWithChar:(char)c
{
    StackNode *node = [[self alloc]init];
    node->c = c;
    node.next = NULL;
    
    return node;
}

@end

@interface Stack : NSObject

@property (nonatomic, strong) StackNode *top;

@property (nonatomic, assign) NSUInteger count;

- (void)pushNode:(StackNode *)node;
- (StackNode *)pop;

@end

@implementation Stack

- (void)pushNode:(StackNode *)node
{
    StackNode *topNode = self.top;
    node.next = topNode;
    self.top = node;
    self.count ++;
}

- (StackNode *)pop
{
    StackNode *node = self.top;
    self.top = node.next;
    self.count --;
    return node;
}

@end


BOOL isVaildParentheses(NSString *s)
{
    if (s.length==0) {
        return NO;
    }
    Stack *stack = [Stack new];
    for (int i = 0; i < s.length; i++) {
        char c = [s characterAtIndex:i];
        if (c == '(' || c == '{' || c == '[') {
            StackNode *node = [StackNode stackNodeWithChar:c];
            [stack pushNode:node];
        } else {
            if (stack.count == 0) {
                return NO;
            }
            
            StackNode *top = stack.top;
            [stack pop];
            
            char match;
            if (c == ')') {
                match = '(';
            }else if (c == '}') {
                match = '{';
            } else {
                match = '[';
            }
            
            if (top->c != match){
                return NO;
            }
        }
    }
    
    if (stack.count != 0) {
        return NO;
    }
    
    return YES;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Stack *stack = [Stack new];
//        NSString *s = @"abc";
//        for (int i = 0; i < s.length; i++) {
//            char c = [s characterAtIndex:i];
//            StackNode *node = [StackNode stackNodeWithChar:c];
//            [stack pushNode:node];
//        }
//        NSLog(@"");
        NSLog(@"%d",isVaildParentheses(@"{[]}"));
        NSLog(@"%d",isVaildParentheses(@"{[])"));
        NSLog(@"%d",isVaildParentheses(@"{}[]()"));
        NSLog(@"%d",isVaildParentheses(@"{}[](}"));
    }
    return 0;
}
