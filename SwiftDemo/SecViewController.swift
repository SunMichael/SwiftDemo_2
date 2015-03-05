//
//  SecViewController.swift
//  SwiftDemo
//
//  Created by keyrun on 15-2-28.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation
import UIKit
class SecViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate{  // swift中协议的遵循 用逗号
    
     var sImageView: UIImageView!
    var allData :NSMutableData = NSMutableData()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.cyanColor()
    }
    
    /*
    override init() {
        super.init()
        self.view.backgroundColor = UIColor.purpleColor()
    }
*/
    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        var backImage = UIImageView(image: UIImage(named: "icon"), highlightedImage: nil)
        backImage.frame = CGRectMake(100, 30, 100, 100)
        self.view .addSubview(backImage)
        backImage.userInteractionEnabled = true
        // attention: ui interaction default is no
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "goBackView:")
        tapGesture.numberOfTapsRequired = 1
        backImage .addGestureRecognizer(tapGesture)
        
        let string: NSString  = "asdsdd"
        println("test for extension  \(NSString.stringIsEmpty(string))")
        
        var cat = Cat()
        let num = cat.addTwoNumbers2(5)
        var num2 = num(10)
        num2 = num(15)
        println( "柯里化函数 num =\(num) num2 =\(num2) ")
        
        let width = UIScreen.mainScreen().bounds.width
        
        var sTableView = UITableView(frame: CGRectMake(0, 150, width, 300), style: UITableViewStyle.Plain)
        sTableView.delegate = self
        sTableView.dataSource = self
        self.view .addSubview(sTableView)
//        if sTableView == nil {  //判断对象不能是可选值
        
//        }
        
        //add a imageView
        sImageView = UIImageView(frame: CGRectMake(230, 30, 100, 100))

        self.view .addSubview(sImageView!)
        
        
        self.showOrHideNavPrompt()
        self.addSomething()
        self.queueGroup()
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), { () -> Void in
//            self.applyQueue()
//        })
        self.semaphore()
    }
    
    func showOrHideNavPrompt() {
        let delayInSeconds = 1.0
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, GlobalMainQueue) { () -> Void in
            let count = 3
            if count > 0 {
                println("执行延迟任务")
                self.sImageView = nil
            }
        }
    }
    func addSomething(){
        //第二个参数 指明队列并发还是串行 （DISPATCH_QUEUE_SERIAL）串行
        let concurrentQueue = dispatch_queue_create("com.keyrun.swift", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(concurrentQueue) { () -> Void in
            println(" First Step ")
            dispatch_async(GlobalMainQueue, { () -> Void in
                println(" Go back main queue update UI")
            })
        }
        dispatch_barrier_async(concurrentQueue, { () -> Void in   //先加入屏障队列中的任务先执行
            println("Second Step")
        })
    }
    
    func queueGroup(){
        let groupQueue = dispatch_group_create()       //创建调度组
        let globalQueue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        dispatch_group_enter(groupQueue)      //通知调度组开始
        dispatch_group_async(groupQueue, globalQueue) { () -> Void in
            println(" Group Queue 1")
        }
        dispatch_group_async(groupQueue, globalQueue) { () -> Void in
            println(" Group Queue 2")
        }
        dispatch_group_leave(groupQueue)
        dispatch_group_notify(groupQueue, globalQueue) { () -> Void in
            println(" Group Queue end")
        }
        dispatch_group_wait(groupQueue, DISPATCH_TIME_FOREVER)     //超时时间,group queue 执行完向下执行，wait可以用notify来代替，这样不会造成阻塞
        dispatch_async(GlobalMainQueue, { () -> Void in
            println(" Group Finished ")
        })
    }
    
    func applyQueue(){      //apply queue放在串行或者主队列中会造成阻塞  放到并行队列中使用最佳
        let groupQueue = dispatch_group_create()
        let globalQueue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        dispatch_apply(5, globalQueue) { (i) -> Void in
            dispatch_group_enter(groupQueue)
            println("Apply Queue \(i)")
            sleep(1)
            dispatch_group_leave(groupQueue)
        }
        dispatch_group_notify(groupQueue, GlobalMainQueue) { () -> Void in
            println(" Apply Queue Finished")
        }
        
    }
    
    func semaphore(){
        let semaphore = dispatch_semaphore_create(3)
        let globalQueue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        let groupQueue = dispatch_group_create()
        for var i = 0 ;i < 9; i++ {
            println(" semaphore  \(i) ")
            dispatch_group_async(groupQueue, globalQueue) { () -> Void in
                 sleep(2)
                println("semaphore sleep")
                dispatch_semaphore_signal(semaphore)
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        }
        dispatch_group_wait(groupQueue, DISPATCH_TIME_FOREVER)
        dispatch_async(GlobalMainQueue, { () -> Void in
            println(" Got semaphore ")
        })
    //以上代码理解: 先wait消耗信号量到0，等待signal释放可用信号，再执行循环,每批次执行4次循环增加4个新线程
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let string = "cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(string) as? UITableViewCell
        //此处要使用as?  代表可能有对象 会被转成uitableviewcell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: string)
        }
        cell.textLabel.text = "Title"
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sAlertView = UIAlertView(title: "Tips", message: "Clicked Cell", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        sAlertView .show()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        println(" AlertViewButtonTag = \(buttonIndex)")
        if buttonIndex == 1 {
            self.getImageFromService()
        }
    }
    func getImageFromService(){
        let url = NSURL(string: "http://t10.baidu.com/it/u=2380260024,2006255000&fm=58")
        
//        let data = NSData(contentsOfURL: url!)
//        sImageView?.image = UIImage(data: data!)
        
        let request = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadRevalidatingCacheData, timeoutInterval: 10)
        
        let webConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
//        webConnection?.scheduleInRunLoop(NSRunLoop .currentRunLoop(), forMode: NSRunLoopCommonModes)
        webConnection?.start()
        
        let timer = NSTimer(timeInterval: 10, target: self, selector: "requestTimeOut:", userInfo: nil, repeats: false)
    }
    
    func requestTimeOut(sender: NSTimer){
//        self.connection(<#connection: NSURLConnection#>, didFailWithError: <#NSError#>)
        println("请求超时")
        sender .invalidate()
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("请求失败")
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        allData.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var image: UIImage? = UIImage(data: allData)
        //block在swift中 循环引用的处理？？？？
//        let block = {[unowned self] () ->Void in
//            self.sImageView?.image = image
//        }
        //此处使用尾行闭包
        dispatch_async(dispatch_get_main_queue()) { [unowned self] () ->() in
            self.sImageView.image = image
        
        }
    println(" 是否是主线程 \(NSThread.isMainThread())")
//     NSObject .performSelectorOnMainThread("showImage", withObject: nil, waitUntilDone: false)
//     let thread = NSThread(target: self, selector: "showImage", object: nil)
//     thread .start()
     
    }
    
    func showImage(){
        sImageView?.image = UIImage(data: allData)
    }
    
    func goBackView(sender: UITapGestureRecognizer) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            let dic = NSDictionary(objectsAndKeys: "NOTIFICATION", "KEY" )
            NSNotificationCenter .defaultCenter() .postNotificationName("Change", object: nil, userInfo: dic)
        })
        
    }
}