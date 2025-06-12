//
//  ViewController.swift
//  My_Wildlife
//
//  Created by Beytullah Cakmak on 3.06.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageText: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func signinButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "toLoginPage", sender: nil)
    }
    @IBAction func registerButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterPage", sender: nil)
    }
    

}

