//
//  GameViewController.swift
//  Apps-Dev-iOS-Assignment3
//
//  Created by Joshua D on 7/5/2023.
//

import iOSDropDown
import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var LevelValue: UILabel!
    
    
    @IBOutlet weak var ShapeView: UIImageView!
    
    
    @IBOutlet weak var CheckForCorrectAnswer: UIButton!
    
    
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

}
