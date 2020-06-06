//
//  TimeDisplayView.swift
//  ios-clock
//
//  Created by user169339 on 6/6/20.
//

import UIKit

class AnalogStopWatch: UIView {
    
    var minute: Int = 0
    var second: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.setNeedsDisplay()
    }
    
    func updateDisplay(minutes: Int, seconds: Int) {
        self.minute = minutes
        self.second = seconds
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .black
        let radius = 0.4 * min(self.bounds.width, self.bounds.height)
        let center = CGPoint(x: 0.5 * self.bounds.width + self.bounds.minX, y: 0.5 * self.bounds.height + self.bounds.minY)
        
        let small = radius < 50
        
        for i in 0...11 {
            radiusDraw(center: center, outerRadius: radius, innerRadius: 0.75 * radius, sixtieths: CGFloat(i) * 5, color: UIColor.lightGray, lineWidth: 1)
        }
        
        radiusDraw(center: center, outerRadius: 0.8 * radius, innerRadius: 0, sixtieths: CGFloat(minute) + CGFloat(second) / 60, color: UIColor.darkGray, lineWidth: small ? 1.0 : 2.5)
        radiusDraw(center: center, outerRadius: 0.9 * radius, innerRadius: 0, sixtieths: CGFloat(second), color: UIColor.red, lineWidth: small ? 0.5 : 1.0)
    }
    
    func radiusDraw(center: CGPoint, outerRadius: CGFloat, innerRadius: CGFloat, sixtieths: CGFloat, color: UIColor, lineWidth: CGFloat) {
        let path = UIBezierPath()
        let angle = -(2 * sixtieths / 60 + 1) * CGFloat.pi
        path.move(to: CGPoint(x: center.x + innerRadius * sin(angle), y: center.y + innerRadius * cos(angle)))
        path.addLine(to: CGPoint(x: center.x + outerRadius * sin(angle), y: center.y + outerRadius * cos(angle)))
        color.setStroke()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.stroke()
    }
}

