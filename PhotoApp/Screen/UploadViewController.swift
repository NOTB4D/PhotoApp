//
//  UploadViewController.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 18.02.2022.
//

import UIKit
import Firebase


class UploadViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var infoTextField: UITextField!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true,completion: nil)
    }
    
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let storage = Storage.storage()
        let storageRefrance = storage.reference()
        
        let mediaFolder = storageRefrance.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRefrance = mediaFolder.child("\(uuid).jpg")
            
            imageRefrance.putData(data, metadata: nil) { (storagemetadata, error) in
                if error != nil{
                    self.aletMessage(header: "Hata", message: error!.localizedDescription)
                }else {
                    imageRefrance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            if let imageUrl = imageUrl {
                                let firestorePost = ["imageUrl":imageUrl, "command": self.infoTextField.text!, "email": Auth.auth().currentUser!.email , "date": FieldValue.serverTimestamp()] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error != nil{
                                        self.aletMessage(header: "Hata", message: error?.localizedDescription ?? "Hata Aldınız, Tekrar Deneyiniz")
                                    }else {
                                        
                                        self.selectionLabel.isHidden = false
                                        self.imageView.image = nil
                                        self.infoTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    func aletMessage(header: String, message:String){
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension UploadViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.selectionLabel.isHidden = true
    }
}
extension UploadViewController:  UINavigationControllerDelegate{
    
    
}
