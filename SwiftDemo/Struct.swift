//
//  Struct.swift
//  SwiftDemo
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

//结构体

struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double){
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
}
// 2个构造器 将参数转成摄氏度温度值  存在属性中
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)

struct Color {
    let red , green, blue : Double
    init(red: Double, green: Double ,blue : Double){
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double){
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)


class DataImporter {
    var fileName: String = "data.text"
    var strig: Character = "a"
}
class DataManager {
    lazy var importer = DataImporter()      //延迟属性
    var data = [String]()
}

 let manager = DataManager()
func test(){
    manager.data.append("some data")     //属性 importer 还没被创建
    println("\(manager.importer.fileName)")    //属性被创建
}


struct Point {
    var x = 0.0 , y = 0.0
}
struct Size {
    var width = 0.0 , height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {          //计算属性:计算属性不直接存储值，而是提供一个 getter 来获取值，一个可选的 setter 来间接设置其他属性或变量的值
        get {
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
//        set(newCenter) {
//            origin.x = newCenter.x
//            origin.y = newCenter.y
//        }
        set {
            origin.x = newValue.x
            origin.y = newValue.y
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 10.0), size: Size(width: 5.0, height: 10.0))
let center = square.center


protocol FullyNamed {
    var fullName: String {
        get
    }
}

class Starship: FullyNamed {
    var fullName: String{     //实现协议的fullyName属性
        return "Name"
    }
}

protocol Togglable {
    mutating func toggle()        //突变方法:能在方法或函数内部改变实例类型的方法称为突变方法
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

//var lightSwitch = OnOffSwitch.Off
//lightSwitch.toggle()

//**********可选协议 前面要加@objc 而且只能被类继承
@objc protocol CounterDataSource2 {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int{
        get
    }
}



/// @brief 属性监听
class MyTestClass {
    let oneYearInSecond: NSTimeInterval = 365 * 24 * 60 * 60
    var date: NSDate{
        
        // willSet 和 didSet 分别用 newValue 和 oldValue
        
        willSet {
            println("即将将日期从 \(date) 改成 \(newValue)")
        }
        didSet {
            if date.timeIntervalSinceNow > oneYearInSecond {
                println(" 设定的时间太晚了 ")
                date = NSDate().dateByAddingTimeInterval(oneYearInSecond)
            }
            println(" 已经将日期从 \(oldValue) 改成 \(date)")
        }
    }
    init() {
        date = NSDate()
    }
}
/// @brief 在子类的重载属性中我们是可以对父类的属性任意地添加属性观察的，而不用在意父类中到底是存储属性还是计算属性
class SimClass {
    var number : Int {
        get {
            println(" get ")
            return 1
        }
        set {
            println(" set ")
        }
    }
}

class SimClass2: SimClass {
    override var number: Int {
        willSet {
            println(" willSet ")
        }
        didSet {
            println(" didSet ")
        }
    }
}
