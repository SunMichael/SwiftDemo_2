//
//  StudentClass.swift
//  SwiftDemo
//
//  Created by keyrun on 15-1-22.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

public class Student: NSObject {
    var age: Int!
    var name: NSString!
    let level: Int!
    var block: funcBlcok2?        //block 代理使用
    var aString: NSString = "asss"
    
    override init() {
        self.level = 20
    }
    
    func studentMethod(){
        block!("GGG")
        
        println(" print method")
    }
    
}

public func StudentFuncOne(stringName: NSString) ->NSString{

    return stringName.stringByAppendingString("AAAA")
}



class Counter  {
    var count = 0
//    var  shareCounter = Counter()
    func increment() {
        count++
    }
    func incrementBy(#amount: Int ,numberOfTimes: Int){   //在参数名前加# 会将局部名称转成外部名称
        count += amount * numberOfTimes
    }
    func reset() {
        count = 0
    }

    class func ShareCounter() {
         println("This is a ClassMethod ")
        
    }
}


class Food {
    var name: String
    init(name:String) {
        self.name = name
    }
    convenience init(){       //便利构造器
        self.init(name:"unNamed")
    }
}


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String ,quantity: Int){
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name ,quantity :1)
    }
}


//MARK: 闭包的定义
class SomeClass {
    let someProperty: String = {        //使用闭包设置默认值 注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
        return "AAAA"
    }()
    
    
    var str:String {
        return "JobDeer"
    }
    
    var string:String {
        get{
            return "Seven"
        }
        set{
            println("set ok")
        }
    }
    
    // 可以在闭包中定义参数，返回值，闭包后括号执行 ，并在括号内传值
    var string2 = {
        (arg1:String ,arg2:String) ->String in
        return arg1 + arg2
    }("Job","Deer")
    
}



struct Checkboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10{
            for j in 1...10{
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
        }
       return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int ,column: Int) ->Bool{
        return boardColors[row * 10 + column]
    }
}


enum ExampleEnum: Int{          //A = 0, B = 1 ,D = 6
    case A , B, C = 5, D
}


extension Double {
    var km: Double {              //只读计算属性
        return self * 1_000.0
    }
    var m: Double{
        return self
    }
    var cm: Double {
        return self / 100.0
    }
    var mm: Double {
        get{
            return self / 1_000.0
        }
    }
}


func sayHello( str1: String = "Hello",str2: String,str3: String){   //swift支持函数参数有默认值
    println(str1 + str2 + str3)
}

func sayHello2(str1: String,str2: String,str3: String = "World"){  //默认参数都是需要外部标签的，如果没有指定外部标签，那么 Swift 会默认自动加上同名的标签
    println(str1 + str2 + str3)
}

func testForDefaultValue(){
//    sayHello( str2: "", str3:"World")
//    sayHello2("Hello", str2: "")
//    输出都是Hello World  目前的xcode不支持 省略带默认值的参数
}


struct RegexHelper {
    let regex: NSRegularExpression?
    init(pattern: String) {
        var error: NSError?
        regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive, error: &error)
    }
    func match(input: String) ->Bool {
        let length = count(input)      //swift 获取String的长度方法 
        if let matches = regex?.matchesInString(input, options: nil, range: NSMakeRange(0, input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))) {
            
            return matches.count > 0
        }else{
            return false
        }
        
    }
}






