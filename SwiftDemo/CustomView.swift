//
//  CustomView.swift
//  SwiftDemo
//
//  Created by keyrun on 15-4-3.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

class CircleProgressView: UIView {
    var trackLayer: CAShapeLayer!
    var trackPath: UIBezierPath!
    var progressLayer: CAShapeLayer!
    var pregressPath: UIBezierPath!
    
    var trackColor: UIColor?
    var progressColor: UIColor?
    var progress: CGFloat = 0.0
    var progressWidth :CGFloat = 0.0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        trackLayer = CAShapeLayer()
        layer.addSublayer(trackLayer)
        trackLayer.fillColor = nil
        trackLayer.frame = bounds
        
        progressLayer = CAShapeLayer()
        layer.addSublayer(progressLayer)
        progressLayer.fillColor = nil
        progressLayer.lineCap = kCALineCapRound
        progressLayer.frame = bounds
        
        progressWidth = 5.0
        
//        trackPath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - progressWidth/2 , startAngle: 0, endAngle: M_PI * 2, clockwise: true)
//        trackLayer.path = trackPath.CGPath
        
        
    }
    
    

    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}