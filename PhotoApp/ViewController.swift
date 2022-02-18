//
//  ViewController.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 18.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextFeild: UITextField!
    
    @IBOutlet weak var passwordTestFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ToFeedVC", sender: nil)
        
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
    }
    
}

