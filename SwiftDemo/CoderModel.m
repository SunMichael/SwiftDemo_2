//
//  CoderModel.m
//  SwiftDemo
//
//  Created by keyrun on 15-2-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import "CoderModel.h"
#import "SwiftDemo-swift.h"     //swift头文件注意 在objc头文件中可能会循环引用  最好放在.m文件中
@interface CoderModel()

@property (nonatomic ,strong) MyNewClass *swiftObj ;

@end

@implementation CoderModel

-(id)initCoderModelWithName:(NSString *)name andAge:(int)age{
    self = [super init];
    if (self) {
        self.name = name ;
        self.age = age ;
        self.swiftObj = nil;
    }
    return self ;
}
@end
