//
//  ViewController.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 18.02.2022.
//

import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextFeild: UITextField!
    
    @IBOutlet weak var passwordTestFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if (emailTextFeild.text != "" && passwordTestFeild.text != "" ) {
            // TODO: kayıtolma işlemi
            Auth.auth().createUser(withEmail: emailTextFeild.text!, password: passwordTestFeild.text!) { (result, error) in
                if error != nil{
                    self.aletMessage(header: "Hata", message: error!.localizedDescription)
                }else {
                    self.performSegue(withIdentifier: "ToFeedVC", sender: nil)
                }
            }
            
        }else {
            aletMessage(header: "Hata", message: "Email ve Şifre giriniz")
        }
        
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        
        if(emailTextFeild.text != "" && passwordTestFeild.text != ""){
            
        
            Auth.auth().signIn(withEmail: emailTextFeild.text!, password: passwordTestFeild.text!) { (result, error) in
                if error != nil {
                    self.aletMessage(header: "Hata", message: error!.localizedDescription)
                }else {
                    self.performSegue(withIdentifier: "ToFeedVC", sender: nil)
                }
            }
            
        }else {
            aletMessage(header: "Hata", message: "Email ve Şifre giriniz")
        }
        
    }
    
    
    func aletMessage(header: String, message:String){
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

