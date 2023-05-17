import Foundation
import UIKit

enum ShapeType: String, CaseIterable {
    case circle
    case square
    case triangle
    case pentagon
    case hexagon
    
    var description: String {
        return rawValue.lowercased()
    }
}

class ShapeView: UIView {
    var shapeType: ShapeType = .circle
    var color: UIColor = .red

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
        
    }
    
    
    override func draw(_ rect: CGRect) {
        
        // Create shape dimension
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)

        switch shapeType {
        case .circle:
            context.addEllipse(in: CGRect(x: 75, y: 10, width: 150, height: 150))
        case .square:
            context.addRect(CGRect(x: 75, y: 10, width: 150, height: 150))
        case .triangle:
            context.move(to: CGPoint(x: 150, y: 0))
            context.addLine(to: CGPoint(x: 75, y: 125))
            context.addLine(to: CGPoint(x: 225, y: 125))
            context.closePath()
        case .pentagon:
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = min(rect.width, rect.height) / 2
            let angleIncrement = CGFloat.pi * 2 / 5
            context.move(to: CGPoint(x: center.x + radius * cos(0), y: center.y + radius * sin(0)))
            for i in 1..<5 {
                let angle = angleIncrement * CGFloat(i)
                context.addLine(to: CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle)))
            }
            context.closePath()
        case .hexagon:
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = min(rect.width, rect.height) / 2
            let angleIncrement = CGFloat.pi * 2 / 6
            context.move(to: CGPoint(x: center.x + radius * cos(0), y: center.y + radius * sin(0)))
            for i in 1..<6 {
                let angle = angleIncrement * CGFloat(i)
                context.addLine(to: CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle)))
            }
            context.closePath()
        }

        context.fillPath()
    }
    
}


