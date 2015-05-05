//
//  Utils.swift
//  SwiftDemo
//
//  Created by keyrun on 15-3-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

var GlobalMainQueue: dispatch_queue_t {
   return dispatch_get_main_queue()
}

var GlobalUserInteractiveQueue: dispatch_queue_t {
   return dispatch_get_global_queue((Int)(QOS_CLASS_USER_INTERACTIVE.value), 0)
}

var GlobalUserInitiatedQueue: dispatch_queue_t {
   return dispatch_get_global_queue((Int)(QOS_CLASS_USER_INITIATED.value), 0)
}

var GlobalUtilityQueue: dispatch_queue_t {
   return dispatch_get_global_queue((Int)(QOS_CLASS_UTILITY.value), 0)
}

var GlobalBackgroundQueue: dispatch_queue_t {
   return dispatch_get_global_queue((Int)(QOS_CLASS_BACKGROUND.value), 0)
}


enum Result {
    case Error(NSError)
    case Value(NSDictionary)
    init (error: NSError? , dictionary :NSDictionary){
        if (error != nil) {
            self = Result.Error(error!)
        }else{
            self = Result.Value(dictionary)
        }
    }
}

prefix operator ~/ {}           //定义一个运算符
prefix func ~/(pattern: String) -> NSRegularExpression{
    return NSRegularExpression(pattern: pattern, options: nil, error: nil)!
}

func ~=(pattern: NSRegularExpression, input: String) ->Bool{      //重载 模式匹配 ~= 操作符
    return pattern.numberOfMatchesInString(input, options: nil, range: NSRange(location: 0, length: input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))) > 0
}





