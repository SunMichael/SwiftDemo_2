//
//  CoderModel.m
//  SwiftDemo
//
//  Created by keyrun on 15-2-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import "CoderModel.h"

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
