import Foundation
import UIKit

enum ShapeType: String, CaseIterable {
    case circle
    case square
    case triangle
    case pentagon
    case hexagon
    
    var description: String {
            return rawValue
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
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)

        switch shapeType {
        case .circle:
            context.addEllipse(in: rect)
        case .square:
            context.addRect(rect)
        case .triangle:
            context.move(to: CGPoint(x: rect.midX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
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
