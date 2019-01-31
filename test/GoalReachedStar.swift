//
//  GoalReachedStar.swift
//  test
//
//  Created by Анастасия Латыш on 29/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit
import CoreGraphics

class GoalReachedStar: UIView {

    var minLength: CGFloat {
        return min(bounds.width, bounds.height)
    }

    override func draw(_ rect: CGRect) {
        let rectStar = CGRect(x: 0, y: 0, width: minLength, height: minLength)
        let pathStar = starPathInRect(rect: rectStar)
        UIColor.yellow.setFill()
        pathStar.fill()
        
    }
    
    func starPathInRect(rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let starExtrusion:CGFloat = minLength/3
        
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        
        let pointsOnStar = 5
        
        var angle:CGFloat = -CGFloat(.pi / 2.0)
        let angleIncrement = CGFloat(.pi * 2.0 / Double(pointsOnStar))
        let radius = rect.width / 2.0
        
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
            let point = pointFrom(angle: angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle: angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            if firstPoint {
                firstPoint = false
                path.move(to: point)
            }
            
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            
            angle += angleIncrement
        }
        
        path.close()
        
        return path
    }
    
    func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
