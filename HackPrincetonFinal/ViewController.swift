//
//  ViewController.swift
//  HackPrincetonFinal
//
//  Created by Fatima Asif on 3/31/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    // var userProfile: User!
    // var orgList: [Organizer]!
    // var count = 0
    /*
    @IBAction func savePrefs(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty else { return }
        guard let name = nameField.text, !name.isEmpty else { return }
        if checkUser(email: email) {
            modifyUser(email: email, name: name)
        } else {
            count += 1
        }
        getUser(email: email)
    }
    */
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty else { return }
        guard let password = passField.text, !password.isEmpty else { return }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err = error {
                let autherror = err as NSError
                print("ERROR: \(autherror)")
                self.errorMsg.text = "Invalid email or password!"
                self.errorMsg.isHidden = false
            } else {
                UserPrefs.getUser(email: email) { () -> () in self.performSegue(withIdentifier: "homeSegue", sender: self)
                }
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backSegue", sender: self)
    }
    /*
    @IBAction func signup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signupSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "signupSegue" {
            let controller = segue.destination as! SignupViewController
            controller.email = self.emailField.text
            controller.password = self.passField.text
        }
        if segue.identifier == "homeSegue" {
            let controller = segue.destination as! AccountViewController
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // orgList = []
        // getUser(email: "tigershark22")
        // print(userProfile.name)
    }
    /*
    private func checkUser(email: String) -> Bool {
        let docRef = db.collection("Users").document(email)
    
    @IBAction func logInButton(_ sender: Any) {
        self.nameText = textField.text!
        performSegue(withIdentifier: "name", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var vc = segue.destination as! AccountViewController
        vc.finalName = self.nameText
    }
    
    
    private func checkUser(username: String) -> Bool {
        let docRef = db.collection("Users").document(username)
        docRef.getDocument() { (querySnapshot, err) in
            if querySnapshot!.exists {
                self.errorMsg.isHidden = false
                self.errorMsg.text = "email already taken! (\(self.count))"
            }
        }
        return self.errorMsg.isHidden
    }
    
    private func modifyUser(email: String, name: String) {
        // Add a new document with a generated ID
        let user = User(email: email, fname: name, lname: name, preferences: [])
        let docRef = db.collection("Users").document(email)

        do {
            try docRef.setData(from: user)
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    
    private func getUser(email: String) {
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                self.userProfile = user
                print("User: \(user)")
                self.getOrganizers(cause: user.preferences[0])
            case .failure(let error):
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error: \(error)")
            }
        }

    }
    
    private func getOrganizers(cause: String) {
        let causeDocs = db.collection("Organizations").whereField("causes", arrayContains: cause)
        causeDocs.getDocuments() { (querySnapshot, error) in
                if let err = error {
                    print("ERROR: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            try self.orgList.append(document.data(as: Organizer.self))
                        } catch {
                            print("ERROR: \(error)")
                        }
                    }
                    
                    print(self.orgList!)
                }
            }

    }*/
}

//@IBAction func logButton_ (_ sender: Any){
//
//}
