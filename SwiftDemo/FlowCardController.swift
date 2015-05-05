//
//  FlowCardController.swift
//  SwiftDemo
//
//  Created by keyrun on 15-3-17.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation
import UIKit
class FlowCardController: UICollectionViewController ,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    var cellCount: Int = 30
    
    override func viewDidLoad() {
         //[someClass class]  == someClass.self
        self.collectionView!.registerClass(CCell.self, forCellWithReuseIdentifier: "MYcell")
        var tapGesture = UITapGestureRecognizer(target: self, action: "addOrDeleteItem:")
        self.collectionView!.addGestureRecognizer(tapGesture)
        
        
        let contact = ("http://onevcat.com","onev@onevcat.com")
        let mailRegex = ~/"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let siteRegex = ~/"^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        switch contact {
        case (siteRegex , mailRegex):
            println("同时拥有有效网站和有效")
        case (_ ,mailRegex):
            println("只有有效邮箱")
        case (siteRegex ,_):
            println("只有有效网站")
        default:
            println("都没有")
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: CCell = collectionView.dequeueReusableCellWithReuseIdentifier("MYcell", forIndexPath: indexPath) as! CCell
        cell.label.text = String( indexPath.row)
        return cell
    }
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    func addOrDeleteItem(sender: UITapGestureRecognizer){
        if (sender.state == UIGestureRecognizerState.Ended ){
            let point = sender.locationInView(self.collectionView)
            let index = self.collectionView!.indexPathForItemAtPoint(point)
            if (index != nil)  {
                self.cellCount = self.cellCount - 1

                self.collectionView!.performBatchUpdates({ () -> Void in
                    println("collectionView Updates")
//                    self.collectionView.deleteItemsAtIndexPaths([index])
                }, completion: { (Bool) -> Void in
                    println("Updates finished")
                })
            }
        }
    }

    
    
}


class CCell: UICollectionViewCell {
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(30.0)
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.blackColor()
        contentView.addSubview(label)
        contentView.layer.borderWidth = CGFloat(2.0)
        contentView.layer.borderColor = UIColor.whiteColor().CGColor
        
    }


    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}

class LineLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.itemSize  = CGSizeMake(ITEM_SIZE, ITEM_SIZE)
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.sectionInset = UIEdgeInsetsMake(200, 0, 200, 0)
        self.minimumLineSpacing = 50
    }
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var array = super.layoutAttributesForElementsInRect(rect)!
        var visibleRect = CGRectNull
        visibleRect.origin = self.collectionView!.contentOffset
        visibleRect.size = self.collectionView!.bounds.size
        
        for attributes in array {
            if CGRectIntersectsRect(attributes.frame, rect){
                var distance = CGRectGetMidX(visibleRect) - attributes.center.x
                var nomalizedDistance = Float(distance) / Float(ACTIVE_DISTANCE)
                if (abs(Int(distance)) < ACTIVE_DISTANCE) {
//                    var zoom  = (1.0 - abs(nomalizedDistance)) * Float(ZOOM_FACTOR) + 1.0
                    
//                    attributes.transform3D = CATransform3DMakeScale(1.0, 1.0, 1.0)
//                    attributes.transform3D = CATransform3DMakeScale(1.0, 1.0, 1.0)
                }
                
            }
        }
        return array
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = MAXFLOAT
        var horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView!.bounds) / 2)
        var targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView!.bounds.width, self.collectionView!.bounds.height)
        let array = super.layoutAttributesForElementsInRect(targetRect)
        
        for layout in array! {
            var itemHorizontalCenter = layout.center.x
            if abs(itemHorizontalCenter - horizontalCenter) < abs(horizontalCenter) {
                offsetAdjustment = Float(itemHorizontalCenter) - Float( horizontalCenter)
            }
        }
        return CGPointMake(CGFloat(Float(proposedContentOffset.x ) + Float(offsetAdjustment)), proposedContentOffset.y)
    }
    
    
    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}


/*

//MARK: CricleLayout

class CircleLayout : UICollectionViewLayout {
    
    var cellCount: Int = 0
    var center: CGPoint = CGPointZero
    var radius: Float = 0.0
    override func prepareLayout() {
        super.prepareLayout()
        let size = self.collectionView?.frame.size
        cellCount = self.collectionView!.numberOfItemsInSection(0)
        radius = Float(min(size!.width, size!.height)) / 2.5
        center = CGPointMake(size!.width / 2.0, size!.height / 2.0)
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        return self.collectionView!.frame.size
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath)
        attributes.alpha = 0.0
        attributes.center = CGPointMake(center.x, center.y)
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0)
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.size = CGSizeMake(70, 70)
//        indexPath.item
//        let centerX = Float(center.x) + Float( radius * cosf(2 * Int(indexPath.item) * M_PI / cellCount))
//        let centerY = Float(center.y) + radius * sinf(2 * indexPath.item * M_PI / Float(cellCount))
        return attributes
    }
    
     
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


*/













