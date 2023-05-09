//
//  ResultsViewController.swift
//  Apps-Dev-iOS-Assignment3
//
//  Created by Joshua D on 7/5/2023.
//

import UIKit

class ResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToNextLevel(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.level += 1
        vc.navigationItem.setHidesBackButton(true, animated: true)
    }
    @IBAction func returnToHome(_ sender: UIButton) {
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
