//
//  Player.swift
//  SwiftDemo
//
//  Created by keyrun on 15-1-26.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

class Player {
    let playerName :String
    var tracker = LevelTracker()
    
    func completeLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceLevel(level + 1)
    }
    init(name:String){
        playerName = name
    }
    
    struct LevelTracker {
        static var hightestUnlockedLevel = 1
        static func unlockLevel(level: Int){
            if level > hightestUnlockedLevel {
                hightestUnlockedLevel = level
            }
        }
        static func levelIsUnlocked(level: Int) ->Bool {
            return level <= hightestUnlockedLevel
        }
        var currentLevel = 1
        mutating func advanceLevel(level: Int) ->Bool {
            if (LevelTracker.levelIsUnlocked(level)){
                currentLevel = level
                return true
            }else{
                return false
            }
        }
        
    }
    
}


struct Bank {
    static var coinsBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) ->Int{
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsBank)
        coinsBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receivedCoins(coins: Int){
        coinsBank += coins
    }
}

class  Player2 {
    var coinInPurse: Int
    init(coins: Int){
        coinInPurse = Bank.vendCoins(coins)
    }
    func winConus(coins: Int){
        coinInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receivedCoins(coinInPurse)          //析构函数
    }
}


// change there         inout 指写入读出参数  本身值能在函数使用中被改变
func swapTwoValues<T>(inout a:T , inout b:T){    //泛型函数 <T>占位类型  a，b参数类型要一致
    let temporary = a
    a = b
    b = temporary
}

struct IntStack : Container{           //将此例中的int 换成T 就是泛型版本 栈
    // IntStack 的原始实现
    var items = [Int]()
    mutating func push(item: Int){
        items.append(item)
    }
    mutating func pop() ->Int {
        return items.removeLast()
    }
    
    // 遵循Container协议的实现，将Int类型声明成 ItemType
    typealias ItemType = Int
    mutating func append(item: ItemType) {
        self.push(item)
    }
     var count: Int {
        return items.count
    }
    subscript(i :Int) ->Int{
        return items[i]
    }
}

func findStringIndex<T :Equatable>(array: [T] ,valueToFind: T) -> Int?{  //T 要遵循Equatable协议 此协议是实现了 == 和 != 比较的类型
    for (index ,value) in enumerate(array){
        if value == valueToFind {
            return index
        }
    }
    return nil
}


protocol Container {
    typealias ItemType     //声明关联类型
    mutating func append(item :ItemType)
     var count: Int {get}
    subscript(i: Int) -> ItemType{
        get
    }
}

// 类型约束
func allItemsMatch <C1: Container ,C2: Container where C1.ItemType == C2.ItemType ,C1.ItemType: Equatable> (someContainer: C1 , anotherContainer: C2) ->Bool {
    if someContainer.count != anotherContainer.count {
        return false
    }
    for i in 0 ..< someContainer.count {
        if someContainer[i] != anotherContainer[i]{
            return false
        }
    }
    return true
}
//C1和C2是容器的两个占位类型参数 遵循Container协议，C1的itemType 遵循Equatable协议，<> 表示占位参数类型


//  可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循, 可选值和可选方法都会返回一个可选值 当其不可执行的时候返回nil
@objc protocol CounterDataSource{
    optional func incrementForCount (count :Int) ->Int
    optional var fixedIncrement: Int {
        get
    }
}

@objc class counter{
    var count = 0
    var dataSource: CounterDataSource?
    func increment(){
        if let amount = dataSource?.incrementForCount!(count){
            count += amount
        }else if let amount = dataSource?.fixedIncrement{
            count += amount
        }
        
    }
}

class TowardsZeroSource: CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        }else if count < 0 {
            return 1
        }else {
            return -1
        }
    }
}


protocol Named {
    var name: String {
        get
    }
    
}
protocol Aged {
    var age: Int {
        get
    }
}
struct PersonP: Named ,Aged{
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol <Named ,Aged>){    //参数是一个 遵循named 和aged 约束的类型
    println("Happy birthday\(celebrator.name)")
}


// 权限设置  public 默认 private

public class SomePublicClass {
    public var somePubicProperty = 0
    var someInternalProperty = 0
    private func somePrivateMethod(){
        
    }
}

class SomeInternalClass {
    var someInternalProperty = 0
    private func somePrivateMethod(){
        
    }
}
private class SomePrivateClass{
    var somePrivateProperty = 0
    func somePrivateMethod(){
        
    }
}

struct TrackedString {
    private(set) var numberOfEdits = 0      // private(set)声明只能在定义该结构体的源文件中赋值
    var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
}


func addTwoNumbers(a: Int)(b: Int) ->Int{      //柯里化函数 参数单独用括号  一个函数传入一个Int然后输出作为另一个函数的输入，然后又返回一个Int
    return a + b
}

func addTwoNumbers2(a: Int) ->(Int -> Int){       // <---柯里化函数示例
    func addTheSecondNumber(b: Int) ->Int{
        return a + b
    }
    return addTheSecondNumber
}

// var number = addTwoNumbers(1)           柯里化函数的使用，在使用相同参数重复调用某个方法时会很方便，可以理解为将函数分段执行
// number(b: 4)

//MARK: Attention 初始化顺序，子类必须先初始化成员变量再调用父类的初始化方法
class Cat {
    var name: String
    init(){
        name = "cat"
    }
    func addTwoNumbers2(a: Int) ->(Int -> Int){       // <---柯里化函数示例
        func addTheSecondNumber(b: Int) ->Int{
            return a + b
        }
        return addTheSecondNumber
    }
    
    func stringAppend(s: String) ->(String -> String -> String){
        func appendString(a: String) -> (String -> String){
            func appendString2(b: String) -> String{
                return s + a + b
            }
            return appendString2
        }
        return appendString
    }
}
class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init()           //下面2步都可以省略，swift会隐式调用super.init
        name = "tiger"
    }
}
//MARK: 协议
protocol MyProtocol {          // 在enum和struct中还是使用static  class和protocol中使用class
    static func foo() ->String
}
struct MyStruct: MyProtocol {
    static func foo() -> String {
        return "MyStruct"
    }
}
enum MyEnum: MyProtocol{
    static func foo() -> String {
        return "MyEnum"
    }
}
class MyClass: MyProtocol {
    class func foo() -> String {
        return "MyClass"
    }
}

func fib(n: Int) -> Int{
    if n <= 1{
        return 1
    }else{
        return fib(n-1) + fib(n-2)
    }
}
/*
extension NSURL: StringLiteralConvertible {
    public class func convertFromStringLiteral(value: String) ->self {
        if let url = self(string: value){
            return url
        }
        fatalError("Bad URL")
    }
    public class func convertFromExtendedGraphemeClusterLiteral(value: String) ->self{
        return self(string: value)
    }
}
*/
/*
extension Array {
    subscript(input: [Int]) ->Slice<T>{
        get{
            var result = Slice<T>()
            for i in input{
                assert(i < self.count, result.append(self[i]))
            }
            return result
        }
    }
}
*/

extension NSString {
    class func stringIsEmpty(str: NSString) ->Bool{
        return str .isEqualToString("")
    }
}

@objc(MyNewClass)       //加objc(CLASSNAME) 由于类名是提供给oc使用所以一定是英文
class  MyNewClass {
    func method(number: Int) ->Int{
        return number + 1
    }
}

// swift 支持 class func 但暂不支持class var 或者 class let 可以使用结构体代替解决
class TeamClass {
    struct Constans {
        static let name = "TeamClass"
    }
    struct Variables {
        static var age = 0
    }
}


// TeamClass.Constans.name
// TeamClass.Variables.age




