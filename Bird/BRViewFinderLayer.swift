//
//  BRViewFinderLayer.swift
//  Bird
//
//  Created by Justin Wells on 6/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BRViewFinderLayer : CAShapeLayer {

    var innerPath = UIBezierPath()
    var squarePath = UIBezierPath()
    var frameLayer = CAShapeLayer()
    
    override init() {
        super.init()
        //Setup Layer
        self.setupLayer()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayer(){
        //Add Square ViewFinder
        innerPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let viewWidth = self.frame.width
        let viewHeight = self.frame.height-64
        squarePath = UIBezierPath(rect: CGRect(x: viewWidth*0.25, y: (viewHeight/2)-(viewWidth*0.25), width: viewWidth*0.5, height: viewWidth*0.5))
        innerPath.append(squarePath)
        innerPath.usesEvenOddFillRule = true
        
        self.path = innerPath.cgPath
        self.fillRule = kCAFillRuleEvenOdd
        self.fillColor = UIColor.black.cgColor
        self.opacity = 0.8
        
        self.setupViewRectangle()
    }
    
    func setupViewRectangle(){
        let viewWidth = self.frame.width
        let viewHeight = self.frame.height-64
        let frameX = viewWidth*0.25
        let frameY = (viewHeight/2)-(viewWidth*0.25)
        let frameW = viewWidth*0.5
        let frameH = viewWidth*0.5
        
        //Design Frame Angle Paths
        let framePath = UIBezierPath()
        //TopLeftFrameAngle
        framePath.move(to: CGPoint(x: frameX-2, y: frameY-2))
        framePath.addLine(to: CGPoint(x: frameX-2, y: frameY+48))
        framePath.move(to: CGPoint(x: frameX-2, y: frameY-2))
        framePath.addLine(to: CGPoint(x: frameX+48, y: frameY-2))
        //TopRightFrameAngle
        framePath.move(to: CGPoint(x: frameX+frameW+2, y: frameY-2))
        framePath.addLine(to: CGPoint(x: frameX+frameW+2, y: frameY+48))
        framePath.move(to: CGPoint(x: frameX+frameW+2, y: frameY-2))
        framePath.addLine(to: CGPoint(x: frameX+frameW-48, y: frameY-2))
        //BottomRightFrameAngle
        framePath.move(to: CGPoint(x: frameX+frameW+2, y: frameY+frameH+2))
        framePath.addLine(to: CGPoint(x: frameX+frameW-48, y: frameY+frameH+2))
        framePath.move(to: CGPoint(x: frameX+frameW+2, y: frameY+frameH+2))
        framePath.addLine(to: CGPoint(x: frameX+frameW+2, y: frameY+frameH-48))
        //BottomLeftFrameAngle
        framePath.move(to: CGPoint(x: frameX-2, y: frameY+frameH+2))
        framePath.addLine(to: CGPoint(x: frameX+48, y: frameY+frameH+2))
        framePath.move(to: CGPoint(x: frameX-2, y: frameY+frameH+2))
        framePath.addLine(to: CGPoint(x: frameX-2, y: frameY+frameH-48))
        
        //design path in layer
        frameLayer.path = framePath.cgPath
        frameLayer.strokeColor = UIColor.white.cgColor
        frameLayer.isOpaque = true
        frameLayer.lineWidth = 2.0
        
        self.addSublayer(frameLayer)
    }
    
    func showViewFinder(){
        self.frameLayer.isHidden = false
        self.fillRule = kCAFillRuleEvenOdd
    }
    
    func hideViewFinder(){
        self.frameLayer.isHidden = true
        self.fillRule = kCAFillRuleNonZero
    }
}
