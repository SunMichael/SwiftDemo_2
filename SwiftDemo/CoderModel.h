//
//  CoderModel.h
//  SwiftDemo
//
//  Created by keyrun on 15-2-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>


//在oc中使用swift 需要写PRODUCT NAME -swift.h ，在swift中使用oc 需要在生产的bridging-Header中写



@interface CoderModel : NSObject

@property (nonatomic ,strong) NSString* name;
@property (nonatomic ,assign) int age ;

//@property (nonatomic ,strong) MyNewClass *swiftObj;

-(id)initCoderModelWithName:(NSString *)name andAge:(int)age;

@end
