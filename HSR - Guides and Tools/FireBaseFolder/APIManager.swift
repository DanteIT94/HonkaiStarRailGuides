//
//  APIManager.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    static let shared = APIManager()
    
    private func configureFB() -> Firestore {
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }
    
    func getPost(collection: String, docName: String, completion: @escaping (Character?) -> Void) {
//        let dataBase = configureFB()
//        dataBase.collection(collection).document(docName).getDocument(completion: { (document, error) in
//            guard error == nil else { completion(nil); return }
//            let doc = Character(id: <#T##String#>, name: <#T##[String : String]#>, element: <#T##Element#>, specializationIconURL: <#T##String#>, characterIconURL: <#T##String#>)
//            completion(doc)
//        })
    }
    
    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")
        
        var image: UIImage = UIImage(named: "default_pic")!
        
        let fileRef = pathRef.child(picName + ".jpeg")
        fileRef.getData(maxSize: 1024*1024, completion: { data, error in
            guard error == nil else { completion(image); return }
            image = UIImage(data: data!)!
            completion(image)
        })
    }
}
