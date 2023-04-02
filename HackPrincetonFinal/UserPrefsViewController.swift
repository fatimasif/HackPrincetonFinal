//
//  UserPrefsViewController.swift
//  HackPrincetonFinal
//
//  Created by Owen Yang on 4/1/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class UserPrefsViewController: UIViewController {

    var db: Firestore!
    static var user: User!
    var orgList: [Organizer]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        orgList=[]
    }
    
    func signin(email: String, password: String) -> Bool {
        var loginSuccess = false
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err = error {
                let autherror = err as NSError
                print("ERROR: \(autherror)")
            } else {
                loginSuccess = true
            }
        }
        return loginSuccess
    }
    
    private func getUser(email: String) {
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                UserPrefsViewController.user = user
                print("User: \(user)")
            case .failure(let error):
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
