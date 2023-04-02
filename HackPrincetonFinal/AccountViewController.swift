//
//  AccountViewController.swift
//  HackPrincetonFinal
//
//  Created by Fatima Asif on 4/1/23.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minLabel1: UILabel!
    @IBOutlet weak var minLabel2: UILabel!
    @IBOutlet weak var minLabel3: UILabel!
    @IBOutlet weak var minLabel4: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = UserPrefs.user.firstname + " " + UserPrefs.user.lastname
        for i in [minLabel1, minLabel2, minLabel3, minLabel4] {
            let total = UserPrefs.user.minutes[i!.tag]
            i!.text = String(total/60) + " h " + String(total%60) + " m "
        }
        

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
