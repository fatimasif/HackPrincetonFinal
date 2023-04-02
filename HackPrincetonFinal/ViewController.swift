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

class ViewController: UIViewController {
    @IBOutlet weak var textField:
        UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    var db: Firestore!
    var userProfile: User!
    var orgList: [Organizer]!
    var count = 0
    
    @IBAction func savePrefs(_ sender: UIButton) {
        guard let username = usernameField.text, !username.isEmpty else { return }
        guard let name = nameField.text, !name.isEmpty else { return }
        if checkUser(username: username) {
            modifyUser(username: username, name: name)
        } else {
            count += 1
        }
        getUser(username: username)
    }
    
    var nameText=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        orgList = []
        // getUser(username: "tigershark22")
        // print(userProfile.name)
    }
    
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
            }
        }
        return self.errorMsg.isHidden
    }
    
    private func modifyUser(username: String, name: String) {
        // Add a new document with a generated ID
        let user = User(username: username, name: name, preferences: ["animals"])
        let docRef = db.collection("Users").document(username)

        do {
            try docRef.setData(from: user)
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    private func getUser(username: String) {
        let docRef = db.collection("Users").document(username)
        
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

    }
}

//@IBAction func logButton_ (_ sender: Any){
//
//}
