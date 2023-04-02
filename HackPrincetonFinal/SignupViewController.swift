//
//  SignupViewController.swift
//  HackPrincetonFinal
//
//  Created by Owen Yang on 4/1/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class SignupViewController: UIViewController {
    
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var lastField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var pass1Field: UITextField!
    @IBOutlet weak var pass2Field: UITextField!
    
    var db: Firestore!
    var email: String!
    var password: String!

    @IBAction func signup(_ sender: UIButton) {
        guard let first = firstField.text, !first.isEmpty else {
            errorMsg.text = "Please fill out all fields."
            errorMsg.isHidden = false
            return
        }
        guard let last = lastField.text, !last.isEmpty else {
            errorMsg.text = "Please fill out all fields."
            errorMsg.isHidden = false
            return
        }
        guard let emailVar = emailField.text, !emailVar.isEmpty else {
            errorMsg.text = "Please fill out all fields."
            errorMsg.isHidden = false
            return
        }
        guard let phone = phoneField.text, !phone.isEmpty else {
            errorMsg.text = "Please fill out all fields."
            errorMsg.isHidden = false
            return
        }
        guard let pass1 = pass1Field.text, !pass1.isEmpty else {
            errorMsg.text = "Please set a password."
            errorMsg.isHidden = false
            return
        }
        guard let pass2 = pass2Field.text, !pass2.isEmpty else {
            errorMsg.text = "Please confirm your password."
            errorMsg.isHidden = false
            return
        }
        if !(phone.count==10) || !phone.allSatisfy({ character in character.isWholeNumber }) {
            errorMsg.text = "Invalid phone number."
            errorMsg.isHidden = false
            return
        }
        if pass1 != pass2 {
            errorMsg.text = "Passwords do not match."
            errorMsg.isHidden = false
            return
        }
        if pass1.count < 6 || pass1.count > 20 {
            errorMsg.text = "Password must be between 6 and 20 characters"
            errorMsg.isHidden = false
            return
        }
        if emailTaken(email: emailVar) { return }
        createUser(email: emailVar, firstname: first, lastname: last, phone: phone, password: pass1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        emailField.text = email
        pass1Field.text = password
    }
    
    func createUser(email: String, firstname: String, lastname: String, phone: String, password: String) {
        let user = User(email: email, phone: phone, firstname: firstname, lastname: lastname, preferences: [])
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print("\(err)")
                self.errorMsg.text = "An error occurred."
                self.errorMsg.isHidden = false
                return
            } else {
                self.addUser(user: user)
                UserPrefs.user = user
                self.performSegue(withIdentifier: "createSuccess", sender: self)
            }
        }
    }
    
    private func addUser(user: User) {
        // Add a new document with a generated ID
       
        let docRef = db.collection("Users").document(user.email)

        do {
            try docRef.setData(from: user)
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    private func emailTaken(email: String) -> Bool {
        let docRef = db.collection("Users").document(email)
        var emailTaken = false
        docRef.getDocument() { (querySnapshot, err) in
            if querySnapshot!.exists {
                emailTaken = true
                self.errorMsg.text = "Email already in use!"
                self.errorMsg.isHidden = false
            }
        }
        return emailTaken
    }
}
