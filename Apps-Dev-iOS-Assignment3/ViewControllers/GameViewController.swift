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

        let shapeView = Apps_Dev_iOS_Assignment3.ShapeView()
        shapeView.shapeType = randomShapeType
        shapeView.color = randomColor

        return shapeView
    }
    
    @IBAction func clickCheckAnswer(_ sender: UIButton) {
        timer.invalidate()
       
        let selectedColor = colourDropDown.title(for: .normal) ?? ""
            let selectedShape = shapeDropDown.title(for: .normal) ?? ""

            let correctColor = currentShape.color.colorName ?? "Unknown"
            let correctShape = currentShape.shapeType.description

            let isCorrect = selectedColor == correctColor && selectedShape == correctShape

            let message = isCorrect ? "Correct!" : "Incorrect!"

            let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                if isCorrect {
                    // Create an instance of the ResultsViewController
                    let resultsViewController = self?.storyboard?.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
                    self?.navigationController?.pushViewController(resultsViewController, animated: true)
                    resultsViewController.navigationItem.setHidesBackButton(true, animated: true)
                }
            }))
            present(alert, animated: true, completion: nil)
        
    }
    
    func countdown() {
        remainingTime -= 1
        timerLabel.text = "Time: \(remainingTime)"
        if remainingTime <= 5 {
            timerLabel.textColor = .red
        }
        if remainingTime == 0 {
            timer.invalidate()
            
            let vc = storyboard?.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
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
                 self.updateButtonInteraction() // Update button interaction state
             }
         
         // ...

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
        case .blue:
            return "Blue"
        case .yellow:
            return "Yellow"
        case .purple:
            return "Purple"
        case .orange:
            return "Orange"
        default:
            return nil
        }
    }
}
