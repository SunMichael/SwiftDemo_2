//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by keyrun on 15-1-22.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //        self.window?.rootViewController = ViewController(nibName: nil, bundle: nil)
        let arr:Array=[1,2,3];
        var arr1:Array=arr;
        arr1[0]=5;
        print(" \(arr) , \(arr1) ")
        
        
        var arr3: [Int] = [2,1,5,4]
        for var i = 0 ; i < arr3.count ; i++ {
            for var j = i + 1 ; j < arr3.count; j++ {
            if arr3[i] > arr3[j] {
            let tmp = arr3[j]
            arr3[j] = arr3[i]
            arr3[i] = tmp
            }
            }
        }
        print(" arr =  \(arr3) ")
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: String) -> Bool {
        return true
    }
}

