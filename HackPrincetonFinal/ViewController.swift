//
//  ViewController.swift
//  HackPrincetonFinal
//
//  Created by Fatima Asif on 3/31/23.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    var db: Firestore!
    
    @IBAction func savePrefs(_ sender: UIButton) {
        guard let username = usernameField.text, !username.isEmpty else { return }
        guard let name = nameField.text, !name.isEmpty else { return }
        modifyUser(username: username, name: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
    }
    
    private func modifyUser(username: String, name: String) {
        // Add a new document with a generated ID

        db.collection("Users").document(username).setData([
            "name": name
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document for \(username) added")
            }
        }
    }
}
