//
//  BlockFile.swift
//  SwiftDemo
//
//  Created by keyrun on 15-2-3.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation
import UIKit
func testFunction(num1: Int ,num2: Int) ->Bool{
    return num1 > num2
}


// Swift 单例   目前swift还不支持储存式的 class let 和class var ,以下是单例的三种实现方式
class MyManager2 {
    class var sharedManager: MyManager2 {
        get{
            struct Static {                //使用一个结构体代替 存储属性的成员变量
                static var onceToken: dispatch_once_t = 0
                static var staticInstance: MyManager2?
            }
            dispatch_once(&Static.onceToken, { () -> Void in
                Static.staticInstance = MyManager2()
            })
            return Static.staticInstance!
        }
        
    }
}
class MyManager {
    class var sharedManager: MyManager {    //使用一个结构体来储存变量
        struct Static{
            static let sharedInstance: MyManager = MyManager()
        }
        return Static.sharedInstance
    }
}
class MyManager4 {
    class var sharedManager: MyManager4 {
        return Static.sharedInstance
    }
    struct Static {
        static let sharedInstance: MyManager4 = MyManager4()
    }
}

private let sharedInstance = MyManager3()
class MyManager3 {
    class var sharedManager: MyManager3 {
        return sharedInstance
    }
}


func someMethod() ->AnyObject {       //AnyObject 隐射 objc中的id  Any可以表示任意类型 包括函数类型
    return 1 > 2;
}

//显式地声明了需要 AnyObject，编译器认为我们需要的的是 Cocoa 类型而非原生类型，而帮我们进行了自动的转换 导入UIKit的同时导入了Foundation
//import UIKit

func testForAnyObject(){
    
    let swiftInt: Int = 1
    let swiftString: String = "miao"
    
    var array: [AnyObject] = []
    array.append(swiftInt)
    array.append(swiftString)
    
}

//MARK: typeslias Code标示

//使用typealias 给已有类型重新命名 ，使用//MARK:  来给代码分区间 这样在导航栏中会有标示
typealias Location = CGPoint
typealias Distance = Double

func distanceBetweenPoint(fromLocation: Location ,toLocation:Location) ->Distance{
    let x = Distance(fromLocation.x - toLocation.x)
    let y = Distance(fromLocation.y - toLocation.y)
    return sqrt(x * x + y * y)
}

//TODO: adsasd    会显示本身和说明
//FIXME: fix something      2者使用一样

func someButtonPressed(sender: AnyObject!){
    #if FREE_VERSION
        let width = BOUND.size.width
        #else
        
    #endif
}


//TODO: 生成一个参数可变的函数
func mySum(input: Int...) ->Int{
    return input.reduce(0, combine: +)
}

extension NSString {      //swift中nsstring 可变的不同类型参数的声明
    //    convenience init(format: NSString , _ args: CVarArgType...)
}


//MARK: convenice 修饰
//只要在子类中实现重写了父类 convenience 方法所需要的 init 方法的话，我们在子类中就也可以使用父类的 convenience 初始化方法了
class ClassA {
    let numA :Int
    init(num: Int){
        numA = num
    }
    convenience init?(bigNum: Bool){           //在init后面加？ 初始化失败后返回nil
        self.init(num: bigNum ? 10000 : 1)
    }
}

class ClassB: ClassA {
    let numB: Int
    override init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
}

//MARK:  组合protocol
protocol KittenLike {
    func meow() -> String
}
protocol DogLike{
    func bark() -> String
}
protocol TigerLike{
    func aou() -> String
}

class MysteryAnimal: KittenLike ,DogLike ,TigerLike {
    func meow() -> String {
        return "meow"
    }
    func bark() -> String {
        return "bark"
    }
    func aou() -> String {
        return "aou"
    }
}
// protocol组合可以用typealias命名
typealias PetLike = protocol<KittenLike ,TigerLike>


//当实现的不同协议中存在函数名一样的情况 ，在调用前进行类型转换区分
protocol pA {
    func bar() ->Int
}
protocol pB {
    func bar() ->String
}
class exampleClass:pA ,pB {
    func bar() -> Int {
        return 1
    }
    func bar() -> String {
        return "bar"
    }
}
let instance = exampleClass()
let num = (instance as pA).bar()
let str = (instance as pB).bar()


//MARK: class关键字在协议中的修饰时，在struct和enum中使用 static 而在class中使用 class
protocol TestProtocol{
    class func foo() ->String
}

struct TestStruct: TestProtocol{
    static func foo() -> String {
        return "foo"
    }
}

enum TestEnum: TestProtocol{
    static func foo() -> String {
        return "foo"
    }
}
class TestClass: TestProtocol {
    class func foo() -> String {
        return "foo"
    }
    
}

//MARK: 闭包捕获上下文, 函数和闭包都是引用类型
func makeIncrementor(forIncrement amount: Int) -> () ->Int {
    var runningTotal = 0
    func incrementor() -> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
func testForLastFunc(){
    
    let incrementByTen = makeIncrementor(forIncrement: 10)
    //此时的 incrementByTen是个无参数函数, 该函数指向每次调用都会加10的函数
    var valueNum = incrementByTen()
    //返回值是 10
    incrementByTen()
    //返回值是 20
    
}


func calculate(opr: String) -> (Int ,Int) ->Int{
    var reslut: (Int ,Int) ->Int
    switch (opr) {
    case "+" :
        reslut = {a,b in
            return a + b
        }
    default :
        reslut = {a ,b in
            return a - b
        }
    }
    return reslut
}

//MARK: 使用闭包返回值
let c1: Int = {(a:Int ,b:Int) -> Int in
    return a + b
}(5,5)


