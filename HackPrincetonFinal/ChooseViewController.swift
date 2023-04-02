//
//  ChooseViewController.swift
//  HackPrincetonFinal
//
//  Created by Fatima Asif on 4/1/23.
//

import UIKit

class ChooseViewController: UIViewController {
    
    var cause: String!
    var causeImage: String!
    
    @IBAction func updateOrgs(_ sender: UIButton) {
        UserPrefs.orgList = []
        switch sender.tag {
        case 0:
            cause = "community"
            break
        case 1:
            cause = "earth"
            break
        case 2:
            cause = "health"
            break
        case 3:
            cause = "animals"
            break
        default:
            cause = "earth"
            break
        }
        UserPrefs.getOrganizers(cause: cause) { () -> () in
            self.performSegue(withIdentifier: "causeSegue", sender: self)
        }
    }
    
    @IBAction func profile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="causeSegue" {
            let controller = segue.destination as! EnviViewController
            controller.imageName = cause
        }
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
