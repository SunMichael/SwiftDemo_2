//
//  PopAnimator.swift
//  SwiftDemo
//
//  Created by keyrun on 15-4-2.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

class PopAnimator: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return 1.0
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        
    }
    

}