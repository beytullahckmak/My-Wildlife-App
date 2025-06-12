//
//  ProfileViewController.swift
//  My_Wildlife
//
//  Created by Beytullah Cakmak on 3.06.2025.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toBackApp", sender: nil)
            
        }catch{
            print("Hata!!!")
        }
    }
    
}
