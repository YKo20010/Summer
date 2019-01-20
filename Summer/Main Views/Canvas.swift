//
//  Canvas.swift
//  Summer
//
//  Created by Artesia Ko on 1/19/19.
//  Copyright © 2019 Yanlam. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    var strokeColor: UIColor = .black
    var strokeWidth: Float = 10
    var lines = [Line]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
    
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.width))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, width: strokeWidth, points: []))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
        
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        _ = lines.removeAll()
        setNeedsDisplay()
    }
    
    func changeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func changeWidth(size: Float) {
        self.strokeWidth = size
    }
    

}
