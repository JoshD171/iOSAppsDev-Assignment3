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
    
    @IBOutlet weak var ShapeView: UIImageView!
    
    @IBOutlet weak var CheckForCorrectAnswer: UIButton!
    
    @IBOutlet var shapeData: [DropDown]!
    
    @IBOutlet var colourData: [DropDown]!
    
    @IBOutlet var shapeDropDown: DropDown!
    
    @IBOutlet var colourDropDown: DropDown!
    
    let options = Options()
    var timer = Timer()
    var remainingTime = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        LevelValue.text = "Level \(level)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in self.countdown()
        }
        
        
        shapeDropDown.optionArray = options.shapes
        shapeDropDown.optionIds = options.ids
        shapeDropDown.checkMarkEnabled = false
        shapeDropDown.semanticContentAttribute = .forceRightToLeft
        shapeDropDown.textColor = .red
        CheckForCorrectAnswer.isHidden = true
        
        colourDropDown.optionArray = options.colours
        colourDropDown.optionIds = options.ids
        colourDropDown.checkMarkEnabled = false
        colourDropDown.semanticContentAttribute = .forceRightToLeft
        colourDropDown.textColor = .red
        
        shapeDropDown.arrowSize = 10
        // Custom DropDown Data
        shapeData[0].optionArray = options.booleanData
        shapeData[2].optionArray = options.colours
        shapeData[3].optionArray = options.colours
        shapeData[4].optionArray = options.height
        shapeData[5].optionArray = options.height
        shapeData[6].optionArray = options.booleanData
        shapeData[0].isSearchEnable = false
        shapeData[2].isSearchEnable = false
        shapeData[3].isSearchEnable = false
        shapeData[4].isSearchEnable = false
        shapeData[5].isSearchEnable = false
        shapeData[6].isSearchEnable = false
        // Custom Dropdown didSelect

        shapeData[0].didSelect(completion: { selected, _, _ in
            self.shapeDropDown.isSearchEnable = Bool(selected)!
        })

        shapeData[2].didSelect(completion: { selected, _, _ in
            if #available(iOS 11.0, *) {
                self.shapeDropDown.selectedRowColor = UIColor(named: selected)!
            } else {
                // Fallback on earlier versions
            }
        })
        shapeData[3].didSelect(completion: { selected, _, _ in
            if #available(iOS 11.0, *) {
                self.shapeDropDown.rowBackgroundColor = UIColor(named: selected)!
            } else {
                // Fallback on earlier versions
            }
        })
        shapeData[4].didSelect(completion: { selected, _, _ in
            self.shapeDropDown.listHeight = CGFloat(Float(selected)!)
        })
        shapeData[5].didSelect(completion: { selected, _, _ in
            self.shapeDropDown.rowHeight = CGFloat(Float(selected)!)
        })
        shapeData[6].didSelect(completion: { selected, _, _ in
            self.shapeDropDown.hideOptionsWhenSelect = Bool(selected)!
        })
        
        colourDropDown.arrowSize = 10
        // Custom DropDown Data
        colourData[0].optionArray = options.booleanData
        colourData[2].optionArray = options.colours
        colourData[3].optionArray = options.colours
        colourData[4].optionArray = options.height
        colourData[5].optionArray = options.height
        colourData[6].optionArray = options.booleanData
        colourData[0].isSearchEnable = false
        colourData[2].isSearchEnable = false
        colourData[3].isSearchEnable = false
        colourData[4].isSearchEnable = false
        colourData[5].isSearchEnable = false
        colourData[6].isSearchEnable = false
        // Custom Dropdown didSelect

        colourData[0].didSelect(completion: { selected, _, _ in
            self.colourDropDown.isSearchEnable = Bool(selected)!
        })

        colourData[2].didSelect(completion: { selected, _, _ in
            if #available(iOS 11.0, *) {
                self.colourDropDown.selectedRowColor = UIColor(named: selected)!
            } else {
                // Fallback on earlier versions
            }
        })
        colourData[3].didSelect(completion: { selected, _, _ in
            if #available(iOS 11.0, *) {
                self.colourDropDown.rowBackgroundColor = UIColor(named: selected)!
            } else {
                // Fallback on earlier versions
            }
        })
        colourData[4].didSelect(completion: { selected, _, _ in
            self.colourDropDown.listHeight = CGFloat(Float(selected)!)
        })
        colourData[5].didSelect(completion: { selected, _, _ in
            self.colourDropDown.rowHeight = CGFloat(Float(selected)!)
        })
        colourData[6].didSelect(completion: { selected, _, _ in
            self.colourDropDown.hideOptionsWhenSelect = Bool(selected)!
        })

    }
    
    @IBAction func clickCheckAnswer(_ sender: UIButton) {
        timer.invalidate()
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
