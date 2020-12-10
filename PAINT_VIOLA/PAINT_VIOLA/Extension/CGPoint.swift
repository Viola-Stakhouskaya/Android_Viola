//
//  CGPoint.swift
//  Paint
//
//  Created by Viola Stakhouskaya on 12/9/20.
//

import CoreGraphics

extension CGPoint {//обозначает точку на экране
    func distance(to point: CGPoint) -> CGFloat {
        let xDist = x - point.x
        let yDist = y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}
