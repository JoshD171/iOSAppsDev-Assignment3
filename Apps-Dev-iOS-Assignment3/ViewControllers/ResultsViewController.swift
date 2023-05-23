//
//  ResultsViewController.swift
//  Apps-Dev-iOS-Assignment3
//
//  Created by Joshua D on 7/5/2023.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    let mainGame = GameViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LevelNumber.text = "YOU PASSED LEVEL \(level)"

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var LevelNumber: UILabel!
    
    
    @IBAction func goToNextLevel(_ sender: UIButton) {
        // Return back to the game screen
        let vc = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(vc, animated: true)
        level += 1 // Increase the next level
        vc.navigationItem.setHidesBackButton(true, animated: true)
    }
    @IBAction func returnToHome(_ sender: UIButton) {
        // Return to the Main screen
        level = 1 // Reset the level
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var MoveToNextLevel: UIButton!
    
   
    
    @IBOutlet weak var GoBackHome: UIButton!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
