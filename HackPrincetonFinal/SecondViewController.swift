//
//  SecondViewController.swift
//  HackPrincetonFinal
//
//  Created by Fatima Asif on 4/1/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBAction func signupPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signupPressed", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
