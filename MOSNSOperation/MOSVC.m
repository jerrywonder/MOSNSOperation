//
//  MOSVC.m
//  MOSNSOperation
//
//  Created by mac on 15/5/1.
//  Copyright (c) 2015年 JerryWonder. All rights reserved.
//

//第三种开线程的方法 nsoperation 比gcd效率低一些
//于是柯皓然选择了nsoblock 和 gcd混用 队列用nsopqueue

//NSOperation mix GCD to manage threads

#import "MOSVC.h"
#import "UIColor+Colours.h"
@interface MOSVC ()

@end

@implementation MOSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColorWithAlpha:1];
    [self openThread];
    
}
#pragma mark - 开线程
-(void)openThread{
    //创建线程 creat threads
    
    NSOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<10; i++) {
            [NSThread sleepForTimeInterval:i*0.1];
            NSLog(@"♦️1 - %d",i);
            //back to main thread , use GCD because it is
            //very efficient in translate
            dispatch_async(dispatch_get_main_queue(), ^{
                self.view.backgroundColor = [UIColor randomColorWithAlpha:1];
            });
        }
    }];

    NSOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<10; i++) {
            [NSThread sleepForTimeInterval:i*0.1];
            NSLog(@"♥️2 - %d",i);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.view.backgroundColor = [UIColor randomColorWithAlpha:1];
            });
        }
    }];
    //creat a queue , the default queue is runing the same time
    NSOperationQueue * opPaidui = [[NSOperationQueue alloc]init];
    //设置只有一条线程 （串行）
    //set the max concurrent op to 1
    //and it will be runing like queue up to check in
    [opPaidui setMaxConcurrentOperationCount:1];
    //设置线程之间的关系 op1依赖于op2 所以op2 先执行
    //why i use nsoperation is becasuse i can set
    //one thread depends to another thread to control theirs relation
    [op1 addDependency:op2];
    [opPaidui addOperation:op1];
    [opPaidui addOperation:op2];

//PS:you also can use this method to creat thread
    NSOperation * op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(openThreads:) object:nil];
    NSLog(@"just don't want a yellow warning %@",op3);
}

-(void)openThreads:(NSOperation *) op {


}

@end
