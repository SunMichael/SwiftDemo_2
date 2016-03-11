//
//  CircularLoaderView.swift
//  SwiftDemo
//
//  Created by keyrun on 15-4-1.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import UIKit

//MARK
/*
CAShapeLayer有着几点很重要:

1. 它依附于一个给定的path,必须给与path,而且,即使path不完整也会自动首尾相接

2. strokeStart以及strokeEnd代表着在这个path中所占用的百分比

3. CAShapeLayer动画仅仅限于沿着边缘的动画效果,它实现不了填充效果
*/
class CircularLoaderView: UIView {

    
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    var progress:CGFloat {
        get{
            return circlePathLayer.strokeEnd
        }
        set{
            if (newValue > 1){
                circlePathLayer.strokeEnd = 1
            }else if (newValue < 0){
                circlePathLayer.strokeEnd = 0
            }else{
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().CGPath
    }
    
    func configure(){
        progress = 0
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        circlePathLayer.strokeColor = UIColor.redColor().CGColor
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.whiteColor()
    }
    func circleFrame() ->CGRect{
        var circleFrame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }
    func circlePath() -> UIBezierPath{
        return UIBezierPath(ovalInRect: circleFrame())    //传入一个矩形  返回一个内切圆或椭圆
    }
    
    func reveal(){
        backgroundColor = UIColor.clearColor()
        progress = 1
        circlePathLayer.removeAnimationForKey("strokeEnd")
        circlePathLayer.removeFromSuperlayer()
        superview?.layer.mask = circlePathLayer        //
        
        
        let center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        let finalRadius = sqrt(center.x * center.x + center.y * center.y)
        let radiusInset = finalRadius - circleRadius
        let outerRect = CGRectInset(circleFrame(), -radiusInset, -radiusInset)
        let toPath = UIBezierPath(ovalInRect:  outerRect).CGPath
        
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth

        //MARK: Set lineWidth and path to their final values this prevents them from jumping back to their original values when the animation completes. Wrapping this in a CATransaction with kCATransactionDisableActions set to true disables the layer’s implicit animations. ———————— 好像可有可无
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2 * finalRadius
        circlePathLayer.path = toPath
        CATransaction.commit()
        
        
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2 * finalRadius
       
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 10
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
    }
    
    override func animationDidStop(anim: CAAnimatio!, finished flag: Bool) {
        superview?.layer.mask = nil
    }
}








