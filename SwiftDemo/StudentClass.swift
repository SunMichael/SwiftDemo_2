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
    
    var aString: NSString = "asss"
    
    override init() {
        self.level = 20
    }
    
    func studentMethod(){
        println(" print method")
    }
    
}

public func StudentFuncOne(stringName: NSString) ->NSString{

    return stringName.stringByAppendingString("AAAA")
}



class Counter  {
    var count = 0
    var  shareCounter = Counter()
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



class SomeClass {
    let someProperty: String = {        //使用闭包设置默认值 注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
        return "AAAA"
    }()
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




















