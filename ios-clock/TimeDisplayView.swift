//
//  TimeDisplayView.swift
//  ios-clock
//
//  Created by user169339 on 6/6/20.
//

import UIKit

class TimeDisplayView: UIView {
    
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
    
    func radialMark(center: CGPoint, outerRadius: CGFloat, innerRadius: CGFloat, sixtieths: CGFloat, color: UIColor, lineWidth: CGFloat) {
        let path = UIBezierPath()
        let angle = -(2 * sixtieths / 60 + 1) * CGFloat.pi
        path.move(to: CGPoint(x: center.x + innerRadius * sin(angle), y: center.y + innerRadius * cos(angle)))
        path.addLine(to: CGPoint(x: center.x + outerRadius * sin(angle), y: center.y + outerRadius * cos(angle)))
        color.setStroke()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        let radius = 0.4 * min(self.bounds.width, self.bounds.height)
        let center = CGPoint(x: 0.5 * self.bounds.width + self.bounds.minX, y: 0.5 * self.bounds.height + self.bounds.minY)
        
        let small = radius < 50
        
        let background = UIBezierPath(ovalIn: CGRect(x: center.x - 1.0 * radius, y: center.y - 1.0 * radius, width: 2.0 * radius, height: 2.0 * radius))
        if let context = UIGraphicsGetCurrentContext() {
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [UIColor(red: 0.93, green: 0.93, blue: 0.682, alpha: 0.5).cgColor, UIColor(red: 0.79, green: 0.835, blue: 0.912, alpha: 0.5).cgColor] as CFArray, locations: nil)!
            background.addClip()
            context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: center.y - radius), end: CGPoint(x: 0, y: center.y + radius), options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        }
        
        for i in 0...11 {
            radialMark(center: center, outerRadius: radius, innerRadius: 0.75 * radius, sixtieths: CGFloat(i) * 5, color: UIColor.lightGray, lineWidth: 1)
        }
        
        let border = UIBezierPath(ovalIn: CGRect(x: center.x - 1.0 * radius, y: center.y - 1.0 * radius, width: 2.0 * radius, height: 2.0 * radius))
        UIColor(white: 0.3, alpha: 1).setStroke()
        border.lineWidth = small ? 1.0 : 6.0
        border.stroke()
        
        radialMark(center: center, outerRadius: 0.8 * radius, innerRadius: 0, sixtieths: CGFloat(minute) + CGFloat(second) / 60, color: UIColor.darkGray, lineWidth: small ? 1.0 : 2.5)
        radialMark(center: center, outerRadius: 0.9 * radius, innerRadius: 0, sixtieths: CGFloat(second), color: UIColor.red, lineWidth: small ? 0.5 : 1.0)
    }
}

