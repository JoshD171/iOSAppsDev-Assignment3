//
//  GameViewController.swift
//  Apps-Dev-iOS-Assignment3
//
//  Created by Joshua D on 7/5/2023.
//

import iOSDropDown
import UIKit
var level = 1

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var LevelValue: UILabel!
    
    @IBOutlet weak var ShapeView: ShapeView!
    
    @IBOutlet weak var CheckForCorrectAnswer: UIButton!
    
    @IBOutlet weak var shapeDropDown: UIButton!
    
    
    @IBOutlet weak var colourDropDown: UIButton!
    
    
    @IBAction func colourChecker(_ sender: Any) {
    }
    
    
    @IBAction func shapeChecker(_ sender: Any) {
    }
    
    
    

    var timer = Timer()
    var remainingTime = 30
    var currentShape: ShapeView!
    var correctColour: UIColor = .red
    var correctShape: String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        setupShapeDropDown()
        setupColourDropDown()
        updateButtonInteraction()
        
        currentShape = generateRandomShape()
        currentShape.frame = ShapeView.bounds
        ShapeView.addSubview(currentShape)
        
        LevelValue.text = "Level \(level)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in self.countdown()
        }
    }
    
    private func generateRandomShape() -> ShapeView {
        let shapeTypes: [ShapeType] = [.circle, .square, .triangle, .pentagon, .hexagon]
        let colors: [UIColor] = [.red, .green, .yellow, .purple, .blue, .orange]

        let randomShapeType = shapeTypes.randomElement() ?? .circle
        let randomColor = colors.randomElement() ?? .red
        
        correctColour = randomColor
        correctShape = randomShapeType.rawValue

        let shapeView = Apps_Dev_iOS_Assignment3.ShapeView()
        shapeView.shapeType = randomShapeType
        shapeView.color = randomColor

        return shapeView
    }
    
    @IBAction func clickCheckAnswer(_ sender: UIButton) {
        let selectedColor = colourDropDown.title(for: .normal) ?? ""
            let selectedShape = shapeDropDown.title(for: .normal) ?? ""

            let isCorrectShape = selectedShape.lowercased() == correctShape.lowercased()
            let isCorrectColor = selectedColor.lowercased() == correctColour.colorName?.lowercased()

            var message = ""
            if isCorrectShape && isCorrectColor {
                message = "Correct!"
            } else {
                if !isCorrectShape && !isCorrectColor {
                    message = "Incorrect shape and incorrect color"
                } else if !isCorrectShape {
                    message = "Incorrect shape"
                } else {
                    message = "Incorrect color"
                }
            }

        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                if isCorrectShape && isCorrectColor {
                    let resultsViewController = self?.storyboard?.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
                    self?.navigationController?.pushViewController(resultsViewController, animated: true)
                    resultsViewController.navigationItem.setHidesBackButton(true, animated: true)
                }
                
            }))
            present(alert, animated: true, completion: nil)
        
        if remainingTime == 0 && !isCorrectShape && !isCorrectColor {
            showNoTimeRemainingViewController()
        }

            if isCorrectColor && isCorrectShape {
                timer.invalidate()

                // Generate a new random shape for the next level
                let nextShape = generateRandomShape()
                shapeDropDown.setTitle("", for: .normal)
                colourDropDown.setTitle("", for: .normal)

                // Update the button interaction state
                updateButtonInteraction()

                // Restart the timer for the next level
                self.remainingTime = 30
                timerLabel.text = "Time: \(remainingTime)"
                timerLabel.textColor = .black
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    self.countdown()
                }
            }
    }
    
    private func showNoTimeRemainingViewController() {
        let noTimeRemainingViewController = storyboard?.instantiateViewController(identifier: "NoTimeRemainingViewController") as! NoTimeRemainingViewController
        navigationController?.pushViewController(noTimeRemainingViewController, animated: true)
        noTimeRemainingViewController.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func countdown() {
        remainingTime -= 1
        timerLabel.text = "Time: \(remainingTime)"
        if remainingTime <= 5 {
            timerLabel.textColor = .red
        }
        if remainingTime == 0 {
            timer.invalidate()
            showNoTimeRemainingViewController()
        }
    }
    
    @IBAction func CheckDropDownSelected(_ sender: Any) {
    }
    
    
    @IBOutlet weak var DropDownView: UIView!
    
    func getColor(for title: String) -> UIColor {
        switch title {
        case "Red":
            return .red
        case "Green":
            return .green
        case "Yellow":
            return .yellow
        case "Purple":
            return .purple
        case "Blue":
            return .blue
        case "Orange":
            return .orange
        default:
            return .clear
        }
    }
    
    func updateButtonInteraction() {
        // Check if both shape and color are selected
        let isShapeSelected = shapeDropDown.title(for: .normal) != nil
        let isColorSelected = colourDropDown.title(for: .normal) != nil
        
        // Enable the button if both shape and color are selected
        CheckForCorrectAnswer.isEnabled = isShapeSelected && isColorSelected
    }
  
    func setupShapeDropDown() {
        let shapeButtonClosure = { [weak self] (action: UIAction) in
            guard let self = self else { return }
            self.shapeDropDown.setTitle(action.title, for: .normal)
            self.currentShape.shapeType = ShapeType(rawValue: action.title) ?? .circle // Update current shape type
//            print(self.currentShape.shapeType)
            self.updateButtonInteraction() // Update button interaction state
        }
        
        var menuItems: [UIAction] = []
        for shapeType in ShapeType.allCases {
            let action = UIAction(title: shapeType.rawValue, handler: shapeButtonClosure)
            menuItems.append(action)
        }
        
        shapeDropDown.menu = UIMenu(children: menuItems)
        shapeDropDown.showsMenuAsPrimaryAction = true
    }

     func setupColourDropDown() {
         let colourButtonClosure = { [weak self] (action: UIAction) in
                 guard let self = self else { return }
                 self.colourDropDown.setTitle(action.title, for: .normal)
                 self.currentShape.color = self.getColor(for: action.title) // Update current color
//             print(self.currentShape.color)
                 self.updateButtonInteraction() // Update button interaction state
             }
         

         colourDropDown.menu = UIMenu(children: [
             UIAction(title: "Red", handler: colourButtonClosure),
             UIAction(title: "Green", handler: colourButtonClosure),
             UIAction(title: "Yellow", handler: colourButtonClosure),
             UIAction(title: "Purple", handler: colourButtonClosure),
             UIAction(title: "Blue", handler: colourButtonClosure),
             UIAction(title: "Orange", handler: colourButtonClosure)
         ])
         colourDropDown.showsMenuAsPrimaryAction = true
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
    }

}

extension UIView {
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}

extension UIColor {
    var colorName: String? {
        switch self {
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .yellow:
            return "Yellow"
        case .purple:
            return "Purple"
        case .blue:
            return "Blue"
        case .orange:
            return "Orange"
        default:
            return nil
        }
    }
}
