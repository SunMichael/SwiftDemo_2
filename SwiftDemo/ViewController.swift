//
//  ViewController.swift
//  SwiftDemo
//
//  Created by keyrun on 15-1-22.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    
    @IBOutlet weak var testTextField: UITextField!
    @IBOutlet weak var xibLabel: UILabel!
    
    @IBOutlet weak var viewForLayer: UIView!
    @IBOutlet weak var customImage: CustomImageView!
    
    let transition = PopAnimator()
    
    var aStudent :Student!   //声明其他类的变量 不用像oc那样引入h文件 直接写？
    
    let sNum:Int = 0     // Int8 ,Int32, Int 数据类型   Int默认根据编译器—> Int32 或者 Int64
    
    var label: UILabel!
    func changeLabelText(sender :NSNotification) {
        print("get notification ---\(sender)")
        label.text = "Make Change"
    }
    
    func showSomeUI() {
        
        NSNotificationCenter .defaultCenter() .addObserver(self, selector: "changeLabelText:", name: "Change", object: nil)
        
        let button: UIButton = UIButton(type: .Custom)      //枚举值和 结构体数据 的调用用点？
        button.frame = CGRectMake(100, 40, 100, 100)
        button.setImage(UIImage(named: "icon2"), forState: UIControlState.Normal)
        button.addTarget(self, action: "btnOnTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(button)
        
        
        label = UILabel(frame: CGRectMake(100, 150, 200, 30))
        label.text = "This is a label"
        label.textColor = UIColor.greenColor()
        label.font = UIFont.boldSystemFontOfSize(20.0)
        self.view .addSubview(label)
        
        self.title = "第一个界面"
        
        
    }
    func 方法(){
        
    }
    
    func btnOnTouched(btn: UIButton) {
//        btn.setImage(UIImage(named: "icon2"), forState: UIControlState.Normal)
        _ = SecViewController(nibName: nil, bundle: nil)
    
//        self .presentViewController(secView, animated: true) { () -> Void in
//            println(" presentView now .....")
//        }
//        let lineLayout = LineLayout()
//        let secView =  FlowCardController(collectionViewLayout: LineLayout())
        
//        self.navigationController?.pushViewController(secView, animated: true)
        clickedImage()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.brownColor()
        self.xibLabel?.text = "标签"
    }
    
    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        super.init(coder: aDecoder)
         super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSomeUI()
        
        
        let sharedInstance = MyManager4.sharedManager
        print(" 单例SharedInstance \(sharedInstance)")
        
        let sharedInstance2 = MyManager4.sharedManager
        print(" 2单例SharedInstance \(sharedInstance2)")
        
        
        let aNum = 10         //*** 常量只能被赋值一次

        
        // 数组的声明 2种等价
        _ = ["AA" ,"NN"]
        
        
        aStudent = Student()
        aStudent.age = 15           //**** 等号2边都要空格
        aStudent.name = "Chris"
        // block 是一个参数为string返回string的block类型
        // typealias (string) -> (string)
        aStudent.block = {(str: String) -> String in
            print(" Blcok Test Success ")
            return "FFF"
        }
        aStudent.studentMethod()
        
        var food = Food()
        food = Food(name:"Apple")
        
        _ = RecipeIngredient(name: "Orange",quantity: 1)
        //        quantityFood.name
        
        print(aStudent)          //print 和 println的区别是 后者会换行
        
        let counter = Counter()
        //        counter.incrementBy(5, numberOfTimes: 3)    //这里swift只是把第一个参数当成incrementBy的局部名称，numberOfTime是局部名称 也是外部名称
        counter.incrementBy(amount: 5, numberOfTimes: 3)  //这个是加了#后 变成外部名称
        
        
        let stringResult = self.functionForView("AAA", aNum: 123)
        print(stringResult)
        print(" hello ,\(aStudent.name)")       //占位输出   占位符的写法  \()   括号里面必须放常量和变量
        
        //        ------------------分割线----数组和字典-----------------
        let A = (aNum ,"SSS")            //元组变量 （）里面放整形或者字符串
        print(A)
        
        var (B,d) = A                 //定义匿名元组变量个数要和定义好的数量一致  可以用（_,d）取消不要的元素
        print("B = \(B),d = \(d)")
        print(A.0)       //访问元素用.
        
        
        _ = (first:"hello" ,second:"world")        //字典

        
        //        ------------------分割线----数据之间的转换-----------------
        let strA = "12345"
        var valueOne = Int(strA)   //把字符串 转换为整形 其中转换失败值为nil
        
        let floutA = 1.23
        valueOne = Int(floutA)                 //将浮点数强转成整形
        _ = Float(valueOne!)

        
        let C :Int? = 10
        
        if (valueOne != nil) {          //if 语句使用 1.if +布尔值{}  2.if +可选值{}   3.if +let 常量 = 可选值{}
            print(valueOne)
        }
        
        if (C != nil) {
            print("C != nil")
        }
        
        if let floutB = C {            //将C的值赋给floutB 如果floutB为nil 就是假
            print(" floutB = \(floutB)")
        }else{
            print( "C is nil")
        }
        
        //        ------------------分割线-----字符串--------------------------
        //2种方式定义空字符串
        let strOne = ""
        _ = String()
        
        //判断是否为空
        if strOne.isEmpty {
            print("strOne ==nil")
        }
        
        // \r 回车符  \n 换行符  \"双引号  \'单引号
        
        
        //多个字符串变量的拼接 用+ 。 字符串变量和常量 用+ 或 +=
        let str4 = "Hello"
        let str5 = "World"
        let str6 = str4 + str5
        print(" str6 == \(str6)")
        
        var str7 = "Swift"
        str7 += "Good"
        print(" str7 == \(str7)")
        
        //字符串和占位变量 组成新字符串
        let a = 3
        let strQ = "a ==\(a)"
        print("\(strQ)")
        
        //字符串的比较
        if strQ == str4 {
            print(" is same ")
        }
        
        if str6.hasPrefix("H"){
            if str6.hasSuffix("d"){
                
            }
        }
        
        //大小写转换
        let newStr = str6.uppercaseString
        _ = str6.lowercaseString
        
        print(newStr )
        
        
        //遍历字符串
        
//        for temppp in str6 {
//            println(temppp)
//        }
        
        
        self.testForXunHuan()
        
        let birthdayPerson = PersonP(name: "jack",age: 21)
        wishHappyBirthday(birthdayPerson)
        
        let someObj = SomeInternalClass()
        someObj.someInternalProperty = 1
        
        var stringToEdit = TrackedString()
        stringToEdit.value = "this is first"
        stringToEdit.value += "this is second"

        
        
        
//        CoderModel *coder = [CoderModel new] ;
       let coder = CoderModel(coderModelWithName: "Sun", andAge: 23)
       print("Coder == \(coder.name ),\(coder.age)")
        
        let fun1:(Int ,String) ->String = {(num: Int ,str:String) ->String in
            return String(num) + str
        }
        fun1(222,"KKKK")
        someTrailingBlick("Trailing Block", closure: fun1)
        someTrailingBlick2("Trailing Block2", fun1)
        
        _ = NSFileManager.defaultManager()
        _ = NSURL.fileURLWithPath("SwiftDemo/NoteFile")
        
        let mainBundle = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        _ = NSData(contentsOfFile: mainBundle!)

        

        
//        setUpLayer()
//        addSomeLayer()
//        replicatorLayer()

    }
    
    func functionForView(str :NSString ,aNum: Int) ->NSString{
        _ = String(aNum) as NSString!
        return str.stringByAppendingString(String(aNum))
    }
    
    
    func testForXunHuan() {     //循环语句
        for var i = 0 ; i < 5 ; i++ {     //等号 大于 小于号 2边都要空格
            print(" i == \(i)")
        }
        
        //遍历整形序列
        let A = 1...8
        for temp in A{
            print(temp)
        }
        
        var B = 5
        while ( B < 10){
            B++
            print("B == \(B)")
        }
        
        var C = 3
        repeat {
            print(C)
            C++
        } while (C < 5)
        
        
        switch (C) {
        case 3 :
            print(" Dooooo ")
        default :
            print(" Default ")
        }
        
        switch (B) {
        case 1...4 :
            print(" exsit1 ")
        case 4...8 :
            print(" exsit2 ")
        default :
            print(" no exsit ")
        }
        
    }
    
    func testForArray() {
        var arr = ["hello" ,"world"]
        var arr1 :[String] = ["AAA" ,"CCC"]       //声明字符串数组
        print("arr1 == \(arr1)")
        
        let  str = [" hellow",11]
        print("str =\(str)")
        
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
        print("arr1 == \(arr1)")
        
        arr1.removeAtIndex(0)
        print("arr1 remove == \(arr1)")
        
        //定义空数组
        var arr3 = [Int]()
        arr3.append(1)
        print("arr3 ==\(arr3.isEmpty),\(arr3)")
        
        
        sayHello("Sun", value1: "OK")
    }
    
    func testForDictionary() {       // 字典的使用
        var dicOne :Dictionary<String ,Int> = ["H1":1 ,"H2":2]
        var dicTwo = ["He":"One" ,"hh":"Two"]        //[]中由key:value 组成
        dicOne.updateValue(3,forKey:"H1")
        
        print("dicOne == \(dicOne)")
        
        _ = dicTwo["hh"]!    //访问此key的值
        
        for (key,value) in dicTwo {       //变量字典
            print("Key ==\(key) and Value == \(value)")
        }
        
        _ = Dictionary <String ,String>()   //声明空字典
    }
    
    func sayHello(value:String ,value1:String) {
        let str = value + "" + value1
        print(str)
    }
    
    func turnBackString(value:String ,value1:String) ->(String){
        return value1 + value
    }
    
    func turnBackArray(value1:String ,value:String) ->(String ,String){    //返回元组
        
        //闭包的使用
        GetList([1,2,3,4], pre: { (s:Int) -> Bool in
            let value = s > 2
            return value
        })
        
        
        //pre闭包名？ （参数:类型）-> 返回值 in 执行方法
        /*        闭包表达式语法
        { (parameters) -> returnType in
             statements
        }
        */
        
        
        // 对应闭包的三种简写
        GetList([1 ,2,3,4], pre: {s in return s > 2})
        GetList([1,2,3 ,4], pre: {s in s>2})
        GetList([1,2,3 ,4], pre: {$0>2})
        
        
        return (value ,value1)
    }
    
    func GetList(arr:[Int] ,pre:(Int) ->Bool) ->[Int]{
        var tempArr = [Int]()
        for temp in arr {
            if pre(temp){        //
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
        let one = NewStruct()
        let two = NewStruct(Name: "CHN",valueX: 30.0,valueY: 50.0)
        //        one.PointX
        print("One == \(one) ,Two == \(two) ,Name ==\(two.getName())")
        
        let p = Point(x: 10.0 ,y: 20.0)
        var cp = CPoint()
        cp.XPoint = p
        print("x == \(cp.XPoint.x), y == \(cp.XPoint.y)")
        
        let manager = DataManager()
        manager.data.append("some data")
        // DataImporter 实例的 lazy importer 属性还没被创建
        print(manager.importer.fileName)    //此时被创建
        
        
        var playerOne: Player2? = Player2(coins: 100)
        print("A New Player has joined the game\(playerOne!.coinInPurse),\(Bank.coinsBank)")
        playerOne!.winConus(500)
        print(" player coins \(playerOne!.coinInPurse)")
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
    
    func testFunction(){
        var nums = [1,9,2,8]
        func testF(num1: Int ,num2: Int) ->Bool{
            return num1 > num2
        }
        nums.sortInPlace(testF)
        print(nums)
        
        nums.sortInPlace({ (num1: Int, num2: Int) -> Bool in
            return num1 > num2
        })
        print(nums)
        
        nums.sortInPlace({ (num1, num2) -> Bool in
            return num1 > num2
        })
        
        nums.sortInPlace({$0 > $1})
        
        
        _ = MyNewClass.method
        // class func method 的版本
//        let f2: (Int ->Int) = MyNewClass.method
        _ = MyNewClass.method
        // func method 的柯里化版本
        
        // 获取随机数时要注意 arc4random产生的是uint32数字 在32位CPU环境中有一半机会转换时越界（uint 是有正负符号），使用以下方式
        let diceFaceCount: UInt32 = 6
        let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1     //产生一个0-5的随机数
        print(randomRoll)
        
        self.somenFunctionThatTakesAClosure { () -> () in
            
        }
        //不适用trailing闭包进行函数调用
        somenFunctionThatTakesAClosure(){
            //闭包主体
        }
        //使用trailing闭包进行函数调用
        somenFunctionThatTakesAClosure({
            //闭包主体
        })
        
    
    }
    
    func randomInRange(range :Range<Int>) ->Int{         //创建一个范围随机数
        let count = UInt32(range.endIndex - range.startIndex)
        return Int(arc4random_uniform(count)) + range.startIndex
    }
    
    
    //MARK: 尾行闭包是在函数扩号之外的闭包表达式，支持作为最后一个参数调用
    func somenFunctionThatTakesAClosure(closure:() ->()){
        //函数体部分
        print(" This is a trailing ")
        
    }
    
    func someTrailingBlick(str: String ,closure:(num22: Int,str2: String) ->String){   //第二个是函数参数，不能当变量使用
        let string = closure(num22: 111,str2: "TTTT")

        print("trailing str =\(str) closure =\(string)")

    }
    
    func someTrailingBlick2(str: String,_: (Int ,String) ->String){     //第2个参数为函数
        print("trailing str2 =\(str) ")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var l :CALayer {
        return viewForLayer.layer
    }
    //http://www.raywenderlich.com/90488/calayer-in-ios-with-swift-10-examples
    func setUpLayer(){
        l.backgroundColor = UIColor.blueColor().CGColor
        l.borderColor = UIColor.redColor().CGColor
        l.borderWidth = 100.0
        l.shadowOpacity = 0.7
        l.shadowRadius = 10.0
        l.contents = UIImage(named: "icon")?.CGImage
        l.contentsGravity = kCAGravityCenter
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchGestureRecoginzed:")
        viewForLayer.addGestureRecognizer(pinchGesture)
        
    }
    func pinchGestureRecoginzed(sender: UIPinchGestureRecognizer){
        let offset: CGFloat = sender.scale < 1 ? 5.0 : -5.0
        let oldFrame = l.frame
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPointMake(oldOrigin.x + offset, oldOrigin.y + offset)
        let newSize = CGSizeMake(oldFrame.width + (offset * -2.0), oldFrame.height + (offset * -2.0))
        let newFrame = CGRect(origin: newOrigin, size: newSize)
        if newFrame.width >= 100.0 && newFrame.width <= 300.0{
            l.borderWidth = offset
            l.cornerRadius += offset / 2.0
            l.frame = newFrame
        }
    }
    func addSomeLayer(){
        let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 300, 300)
        layer.contents = UIImage(named: "icon")?.CGImage
        layer.contentsGravity = kCAGravityCenter
        layer.magnificationFilter = kCAFilterLinear      //使用过滤器，过滤器在图像利用contentsGravity放大时发挥作用，可用于改变大小（缩放、比例缩放、填充比例缩放）和位置（中心、上、右上、右等等）。以上属性的改变没有动画效果
        layer.geometryFlipped = false       // 设置几何和阴影会上下颠倒
        layer.backgroundColor = UIColor(red: 11/255.0, green: 86/255.0, blue: 14/255.0, alpha: 1.0).CGColor
        layer.opacity = 1.0
        layer.hidden = false
        layer.masksToBounds = false
        layer.cornerRadius = 150.0
        layer.borderWidth = 12.0
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSizeMake(0, 3)
        layer.shadowRadius = 3.0
        l .addSublayer(layer)
    }
    
    func replicatorLayer(){     // CAReplicatorLayer 能够以特定的次数复制图层
        
        
        let view = UIView(frame: CGRectMake(175, 80, 250, 250))
        view.backgroundColor = UIColor.whiteColor()
        view.center = self.view.center
        self.view .addSubview(view)
        
        let replicatorLayer = CAReplicatorLayer()
//        replicatorLayer.frame  = CGRectMake(0, 0, 10,30)
        replicatorLayer.frame = view.bounds
        
        replicatorLayer.instanceCount = 30
        replicatorLayer.instanceDelay = CFTimeInterval(1 / 30)
        replicatorLayer.preservesDepth = false
        replicatorLayer.instanceColor = UIColor.whiteColor().CGColor
        
        replicatorLayer.instanceRedOffset = 0.0
        replicatorLayer.instanceGreenOffset = -0.5
        replicatorLayer.instanceBlueOffset = -0.5
        replicatorLayer.instanceAlphaOffset = 0.0
       
        view.layer.addSublayer(replicatorLayer)
       
        let angle = Float(M_PI * 2.0) / 30
        replicatorLayer.instanceTransform  = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        
        
        let instanceLayer = CALayer()
        let layerWidth: CGFloat = 10.0
        let midX = CGRectGetMidX(view.bounds) - layerWidth / 2.0
        instanceLayer.frame = CGRectMake(midX, 0.0, layerWidth, layerWidth * 3)
        instanceLayer.backgroundColor = UIColor.whiteColor().CGColor
        replicatorLayer.addSublayer(instanceLayer)
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.repeatCount = Float(Int.max)
        
        fadeAnimation.duration = CFTimeInterval(1)
        instanceLayer.opacity = 0.0
        instanceLayer.addAnimation(fadeAnimation, forKey: "FadeAnimation")
        
    }
    
    
//    func makeCustomPopAnimation(){
//        var tapGuest = UITapGestureRecognizer(target: self, action: "clickedImage")
//        customImage.userInteractionEnabled = true
//        customImage.addGestureRecognizer(tapGuest)
//    }
    
    func clickedImage(){       //makePopAnimation
        let popView = SecViewController(nibName: nil, bundle: nil)
        popView.transitioningDelegate = self

//       self.navigationController!.pushViewController(popView, animated: true)
        presentViewController(popView, animated: true, completion: nil)
        
        var numb1 = 10
        var numb2 = 20
        changeValues(&numb1, b: &numb2);
        print(" numb1 now = \(numb1) ,numb2 now = \(numb2)")
        
        join(string: "hello", toString: "world", withJoiner: ",")
        containsCharacter("hello", characterToFind: "h")

    }
    
    //intout 输入输出参数  参数在函数体内被改变  值会被替换
    func changeValues(inout a : Int ,inout b : Int){
        let temporary = a
        a = b
        b = temporary
    }
    
    // 希望函数使用者在调用函数时提供参数名字，就需要使用函数外部参数名 外部参数名写在局部参数名之前，用空格分隔。
    // 以下 string toString withJoiner 是外部参数名  以一种清晰的方式调用函数
    // withJoiner joiner: String = "-"  是给joiner赋予默认值
    func join(string s1: String, toString s2: String , withJoiner joiner: String = "-") -> String{
        return s1 + joiner + s2
    }
    //声明外部参数简单的方式 是在参数名前加#
    func containsCharacter(string : String , characterToFind : Character) -> Bool{
        for character1 in string.characters {
            if character1 == characterToFind {
                return true
            }
        }
        return false
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = customImage!.superview!.convertRect(customImage.frame, toView: nil)

        transition.presenting = true
        return transition
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       transition.presenting = false
        return transition
    }
}







