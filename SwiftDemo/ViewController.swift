//
//  ViewController.swift
//  SwiftDemo
//
//  Created by keyrun on 15-1-22.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var aStudent :Student!   //声明其他类的变量 不用像oc那样引入h文件 直接写？
    
    let sNum:Int!     // Int8 ,Int32, Int 数据类型   Int默认根据编译器—> Int32 或者 Int64
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aNum = 10         //*** 常量只能被赋值一次
        var varOne: Int?        //加上？ varOne可以为nil
        var varTwo: Optional<Int>
        
        // 数组的声明 2种等价
        let someArray: [String] = ["AA" ,"NN"]
        let someArray2: Array<String> = ["MM" ,"UU"]
        
        
        aStudent = Student()
        aStudent.age = 15           //**** 等号2边都要空格
        aStudent.name = "Chris"
        aStudent.studentMethod()
        
        var food = Food()
        food = Food(name:"Apple")
        
        var quantityFood = RecipeIngredient(name: "Orange",quantity: 1)
//        quantityFood.name 
        
        print(aStudent)          //print 和 println的区别是 后者会换行
        
        var counter = Counter()
//        counter.incrementBy(5, numberOfTimes: 3)    //这里swift只是把第一个参数当成incrementBy的局部名称，numberOfTime是局部名称 也是外部名称
        counter.incrementBy(amount: 5, numberOfTimes: 3)  //这个是加了#后 变成外部名称
        
        
        let stringResult = self.functionForView("AAA", aNum: 123)
        println(stringResult)
        println(" hello ,\(aStudent.name)")       //占位输出   占位符的写法  \()   括号里面必须放常量和变量
        
        //        ------------------分割线----数组和字典-----------------
        var A = (aNum ,"SSS")            //元组变量 （）里面放整形或者字符串
        println(A)
        
        var (B,d) = A                 //定义匿名元组变量个数要和定义好的数量一致  可以用（_,d）取消不要的元素
        println("B = \(B),d = \(d)")
        println(A.0)       //访问元素用.
        
        
        var Dic = (first:"hello" ,second:"world")        //字典
        println( Dic.second )
        
        //        ------------------分割线----数据之间的转换-----------------
        var strA = "12345"
        var valueOne = strA.toInt()
        println("ValueOne = \(valueOne)")       //把字符串 转换为整形 其中转换失败值为nil
        
        var floutA = 1.23
        valueOne = Int(floutA)                 //将浮点数强转成整形
        var floutB = Float(valueOne!)
        println(floutB)
        
        var C :Int? = 10
        
        if (valueOne != nil) {          //if 语句使用 1.if +布尔值{}  2.if +可选值{}   3.if +let 常量 = 可选值{}
            println(valueOne)
        }
        
        if (C != nil) {
            println("C != nil")
        }
        
        if let floutB = C {            //将C的值赋给floutB 如果floutB为nil 就是假
            println(" floutB = \(floutB)")
        }else{
            println( "C is nil")
        }
        
        //        ------------------分割线-----字符串--------------------------
        //2种方式定义空字符串
        var strOne = ""
        var strTwo = String()
        
        //判断是否为空
        if strOne.isEmpty {
            println("strOne ==nil")
        }
        
        // \r 回车符  \n 换行符  \"双引号  \'单引号
        
        
        //多个字符串变量的拼接 用+ 。 字符串变量和常量 用+ 或 +=
        var str4 = "Hello"
        var str5 = "World"
        var str6 = str4 + str5
        println(" str6 == \(str6)")
        
        var str7 = "Swift"
        str7 += "Good"
        println(" str7 == \(str7)")
        
        //字符串和占位变量 组成新字符串
        var a = 3
        var strQ = "a ==\(a)"
        println("\(strQ)")
        
        //字符串的比较
        if strQ == str4 {
            println(" is same ")
        }
        
        if str6.hasPrefix("H"){
            if str6.hasSuffix("d"){
                
            }
        }
        
        //大小写转换
        var newStr = str6.uppercaseString
        var newStr2 = str6.lowercaseString
        
        println(newStr )
        
        
        //遍历字符串
        
        for temppp in str6 {
            println(temppp)
        }
        
        
        self.testForXunHuan()
        
        let birthdayPerson = PersonP(name: "jack",age: 21)
        wishHappyBirthday(birthdayPerson)
        
        let someObj = SomeInternalClass()
        someObj.someInternalProperty = 1
        
        var stringToEdit = TrackedString()
        stringToEdit.value = "this is first"
        stringToEdit.value += "this is second"
        println("stringEditsNumber = \(stringToEdit.numberOfEdits)")
        
    }
    
    func functionForView(str :NSString ,aNum: Int) ->NSString{
        let aaa : NSString = String(aNum) as NSString!
        return str.stringByAppendingString(String(aNum))
    }
    
    
    func testForXunHuan() {     //循环语句
        for var i = 0 ; i < 5 ; i++ {     //等号 大于 小于号 2边都要空格
            println(" i == \(i)")
        }
        
        //遍历整形序列
        var A = 1...8
        for temp in A{
            println(temp)
        }
        
        var B = 5
        while ( B < 10){
            B++
            println("B == \(B)")
        }
        
        var C = 3
        do {
            println(C)
            C++
        } while (C < 5)
        
        
        switch (C) {
        case 3 :
            println(" Dooooo ")
        default :
            println(" Default ")
        }
        
        switch (B) {
        case 1...4 :
            println(" exsit1 ")
        case 4...8 :
            println(" exsit2 ")
        default :
            println(" no exsit ")
        }
        
    }
    
    func testForArray() {
        var arr = ["hello" ,"world"]
        var arr1 :[String] = ["AAA" ,"CCC"]       //声明字符串数组
        println("arr1 == \(arr1)")
        
        var  str = [" hellow",11]
        println("str =\(str)")
        
        /*运行结果
        str =(
        " hellow",
        11
        )
        
        1：[" hellow",11] -->[] 变量值类型是字符串和整形，类型不一致，即不是数组
        2：结果(" hellow",11) 是一个不可变数组
        */
        
        //可变数组的追加 使用 append
        arr.append("OOOPP")
        
        arr1.insert("HHH", atIndex: 2)
        println("arr1 == \(arr1)")
        
        arr1.removeAtIndex(0)
        println("arr1 remove == \(arr1)")
        
        //定义空数组
        var arr3 = [Int]()
        arr3.append(1)
        println("arr3 ==\(arr3.isEmpty),\(arr3)")
        
        
        sayHello("Sun", value1: "OK")
    }
    
    func testForDictionary() {       // 字典的使用
        var dicOne :Dictionary<String ,Int> = ["H1":1 ,"H2":2]
        var dicTwo = ["He":"One" ,"hh":"Two"]        //[]中由key:value 组成
        dicOne.updateValue(3,forKey:"H1")
        
        println("dicOne == \(dicOne)")
        
        var temp = dicTwo["hh"]     //访问此key的值
        
        for (key,value) in dicTwo {       //变量字典
            println("Key ==\(key) and Value == \(value)")
        }
        
        var emptyDic = Dictionary <String ,String>()   //声明空字典
    }
    
    func sayHello(value:String ,value1:String) {
        var str = value + "" + value1
        println(str)
    }
    
    func turnBackString(value:String ,value1:String) ->(String){
        return value1 + value
    }
    
    func turnBackArray(value1:String ,value:String) ->(String ,String){    //返回元组
        
        //闭包的使用
        GetList([1,2,3,4], pre: { (s:Int) -> Bool in
            var value = s > 2
            return value
        })
        //pre闭包名？ （参数:类型）-> 返回值 in 执行方法 return 值
        
        
        // 对应闭包的三种简写
        GetList([1,2,3,4], {s in return s > 2})
        GetList([1,2,3,4], {s in s>2})
        GetList([1,2,3,4], {$0>2})
        
        
        return (value ,value1)
    }
    
    func GetList(arr:[Int] ,pre:(Int) ->Bool) ->[Int]{
        var tempArr = [Int]()
        for temp in arr {
            if pre(temp){
                tempArr.append(temp)
            }
        }
        FunctionOne { () -> () in
            
        }
        return tempArr
    }
    /*
    
    函数Getlist说明
    参数：
    1：第一个参数 整形集合变量
    2：第二参数，函数类型变量 参数为整形返回值布尔类型
    返回值
    整形集合
    
    */
    
    /*
    调用Getlist 说明
    第一个参数 整形数组 [1,2,3,4]
    第二个参数  闭包 来指向给 函数类型 。
    {(s) in return s>2} 闭包类型说明，参数为整形,返回值为布尔类型
    */
    
    /*
    闭包简写方法
    
    　　1；第一种简写 ：省略 参数类型和括号
    
    　　2:第二种简写 : 省略 参数类型和括号，return关键字
    
    　　3:第三种简写 ： 参数名称缩写 (用$0代表第一个参数，$1代表第二个参数)
    */
    
    
    //尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
    func FunctionOne(closure:() ->()){
        //参数为函数类型，函数类型，参数为空，返回值为空
    }
    
    
    
    //     ------------ 结构体 ------------
    struct NewStruct {
        var PointX = 10.0
        var PointY = 20.0
        var name:String
        init() {
            name = "USA"
        }
        init(Name:String ,valueX:Double ,valueY :Double){
            name = Name
            PointX = valueX
            PointY = valueY
        }
        
        func getName() ->String {      //结构体内方法 不能直接修改字段值
            return name
        }
        
        mutating func getChangedName() ->String {  //使用mutating（变异）关键字可以是字段在结构体方法内赋值 常量的值不能变
            return self.name + "NAME"
        }
        
        mutating func getNewSelf() ->NewStruct {
            self = NewStruct(Name: "Korea",valueX: 20.0,valueY: 30.0)
            return self                            //返回一个新的self实例
        }
    }
    
    func testForStruct(){
        var one = NewStruct()
        var two = NewStruct(Name: "CHN",valueX: 30.0,valueY: 50.0)
        //        one.PointX
        println("One == \(one) ,Two == \(two) ,Name ==\(two.getName())")
        
        var p = Point(x: 10.0 ,y: 20.0)
        var cp = CPoint()
        cp.XPoint = p
        println("x == \(cp.XPoint.x), y == \(cp.XPoint.y)")
        
        let manager = DataManager()
        manager.data.append("some data")
        // DataImporter 实例的 lazy importer 属性还没被创建
        println(manager.importer.fileName)    //此时被创建
        
        
        var playerOne: Player2? = Player2(coins: 100)
        println("A New Player has joined the game\(playerOne!.coinInPurse),\(Bank.coinsBank)")
        playerOne!.winConus(500)
        println(" player coins \(playerOne!.coinInPurse)")
        playerOne = nil
        // ?号代表可能存在nil  !代表一定存在
        
        
    }
    
    struct Point {
        var x = 0.0
        var y = 0.0
    }
    struct CPoint {
    
        var p = Point()
        var XPoint :Point {    //声明属性的 get set方法  计算属性
            get{
                return p
            }
            set(newPoint){        //这个是怎么判断newpoint是Point的呢 ？？？难道是XPoint:Point
                p.x = newPoint.x
                p.y = newPoint.y

            }
            /*     setter 的简写  newValue参数名
            set {
                p.x = newValue.x
                p.y = newValue.y
            }
            */
            /*        属性监视器
            willSet (newPoint){
                
            }
            didSet (newPoint){
                
            }
           */
        }
    }
    
    struct Cuboid {    //只有get 没有set的计算属性就是只读属性
    
        var width = 0.0 , height = 0.0 ,depth = 0.0
        var volume :Double {
            get {
                return width * height * depth
            }
        }
    }
    
    enum SomeEnumeration {
        static var storedTypeProperty = "some value"
        static var computerTypeProperty :Int{
            return 20
        }
    }
    
    
    class DataImporter {
        var fileName = "data.text"
    }
    class DataManager {
        lazy var importer = DataImporter()        //声明一个延迟属性
        var data = [String]()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

