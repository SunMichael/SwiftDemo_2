//
//  UnSafePointer.swift
//  SwiftDemo
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

//MARK     GCD与延迟执行
typealias Task = (cancel : Bool) ->()

func delay(time: NSTimeInterval ,task:() -> ()) ->Task{
    func dispatch_later(block: ()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
    var closure: dispatch_block_t? = task
    var reslut: Task?
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false){
                dispatch_async(dispatch_get_main_queue(), internalClosure)
            }
        }
        closure = nil
        reslut = nil
    }
    reslut = delayedClosure
    dispatch_later { () -> () in
        if let delayedClosure = reslut {
            delayedClosure(cancel: false)
        }
    }
    return reslut!
}

func cancel(task : Task?) {
    task?(cancel: true)
    let tt = delay(2, { () -> () in
        println("  write something")
    })
}

/*
func methodOrigin(const int *num){
    println("%d", *num)
}
*/
//MARK 如果C中是const 指针，swift中对应的则是UnsafePointer ，如果是普通的可变指针则是UnsafeMutablePointer
//MARK 上面是C中的写法 。对于其他的 C 中基础类型，在 Swift 中对应的类型都遵循统一的命名规则：在前面加上一个字母 C 并将原来的第一个字母大写：比如 int，bool 和 char 的对应类型分别是 CInt，CBool 和 CChar。

func method(num : UnsafePointer<CInt>){
     println(num.memory)       //使用 memory 属性来读取相应内存中存储的内容。
}

func testForMethod(){
    var a : CInt = 123
    method(&a)                 //输出123
}

let arr = NSArray(object: "meow")
let strasd = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), CFString.self)


//柯里化函数 步骤
/*
注解： 这里为什么能使用参数a,b,c?
利用闭包的值捕获特性，即使这些值作用域不在了，也可以捕获到他们的值。
闭包会自动判断捕获的值是值拷贝还是值引用，如果修改了，就是值引用，否则值拷贝。
注意只有在闭包中才可以，a,b,c都在闭包中。
*/
func addNumbers(a: Int) ->(b: Int) ->(c: Int) ->Int {
    return {(b: Int) ->(c: Int) ->Int in
        return {(c: Int) ->Int in
            return a + b + c
        }
    }
}
//组装界面   使用柯里化函数将模块组装起来 实现界面组装
protocol CombineUI {
    func combine(top: () ->())(bottom: () ->())
}
class UI: CombineUI {
    func combine(top: () -> ())(bottom: () -> ()) {
        top()
        bottom()
    }
}

class Currying {
    func add(a: Int ,b: Int, c: Int) -> Int{
        println("\(a) + \(b) + \(c)")
        return a + b + c
    }
    
    func add(a: Int) ->(b: Int) ->(c: Int) ->Int{
        return {(b: Int) ->(c: Int) ->Int in
            return {(c: Int) ->Int in
                return a + b + c
            }
        }
    }
    
    func addCur(a: Int)(b: Int)(c: Int) ->Int{
        println("\(a) + \(b) + \(c)")
        return a + b + c
    }
}

func testForCurry(){
    var curryInstance = Currying()
    var r: Int = curryInstance.add(10)(b: 20)(c: 30)
    let functionB = curryInstance.add(10)
    let functionC = functionB(b: 20)
    let sumNumber = functionC(c: 30)
    
    let test = "hello"
    let interval = "a"..."z"
    for c in test {
        if interval.contains(String(c)) {
            println("\(c) 是小写字母")
        }
    }
    
    for i in 1...10 {
        println( " \(i)  ")
    }
    
}









