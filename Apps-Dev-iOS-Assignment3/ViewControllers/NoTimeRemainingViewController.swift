//
//  NoTimeRemainingViewController.swift
//  Apps-Dev-iOS-Assignment3
//
//  Created by Joshua D on 16/5/2023.
//

import UIKit

class NoTimeRemainingViewController: UIViewController {
    let mainGame = GameViewController()
    
    @IBOutlet weak var levellabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        levellabel.text = "You have reached Level \(level)"
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var RestartLevel: UIButton!
    
    
    @IBAction func Restarting(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBOutlet weak var HomeOutlet: UIButton!
    

    @IBAction func ReturnHome(_ sender: Any) {
        level = 1
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
