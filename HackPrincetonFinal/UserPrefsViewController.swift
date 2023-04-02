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

class UserPrefs {

    static var db: Firestore = Firestore.firestore()
    static var user: User!
    static var orgList: [Organizer] = []
    
    static func getUser(email: String, completion: @escaping () -> ()) {
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                UserPrefs.user = user
                print("User: \(user)")
            case .failure(let error):
                print("Error: \(error)")
            }
            completion()
        }
    }
    
    static func getOrganizers(cause: String, completion: @escaping () -> ()) {
        print(cause)
        let causeDocs = db.collection("Organizations").whereField("cause", isEqualTo: cause)//.order(by: "stars", descending: true)
        causeDocs.getDocuments() { (querySnapshot, error) in
            if let err = error {
                print("ERROR: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try UserPrefs.orgList.append(document.data(as: Organizer.self))
                    } catch {
                        print("ERROR: \(error)")
                    }
                }
            }
            completion()
        }
    }
}
