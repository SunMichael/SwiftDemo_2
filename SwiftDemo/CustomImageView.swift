//
//  CustomImageView.swift
//  SwiftDemo
//
//  Created by keyrun on 15-4-1.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//


//From: http://www.raywenderlich.com/94302/implement-circular-image-loader-animation-cashapelayer
//CALayer动画
import Foundation

class CustomImageView: UIImageView {
    
    
    let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(self.progressIndicatorView)
        progressIndicatorView.frame = bounds
        progressIndicatorView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        let url = NSURL(string: "http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg")
        sd_setImageWithURL(url, placeholderImage: nil, options: SDWebImageOptions.CacheMemoryOnly, progress: {[weak self] (receivedSize, expectedSize) -> Void in
            println("receivedSize =\(receivedSize)  \(expectedSize)")
            self!.progressIndicatorView.progress = CGFloat(receivedSize) / CGFloat(expectedSize)
        }) {[weak self] (image, error, _, _) -> Void in
            self!.progressIndicatorView.reveal()
        }
    }
    
} 