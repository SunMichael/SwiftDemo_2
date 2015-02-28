//
//  SecViewController.swift
//  SwiftDemo
//
//  Created by keyrun on 15-2-28.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation
import UIKit
class SecViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        backImage.frame = CGRectMake(100, 100, 100, 100)
        self.view .addSubview(backImage)
        backImage.userInteractionEnabled = true
        // attention: ui interaction default is no
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "goBackView:")
        tapGesture.numberOfTapsRequired = 1
        backImage .addGestureRecognizer(tapGesture)
    }
    func goBackView(sender: UITapGestureRecognizer) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            let dic = NSDictionary(objectsAndKeys: "NOTIFICATION", "KEY" )
            NSNotificationCenter .defaultCenter() .postNotificationName("Change", object: nil, userInfo: dic)
        })
        
    }
}