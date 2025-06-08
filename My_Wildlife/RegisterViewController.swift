//
//  RegisterViewController.swift
//  My_Wildlife
//
//  Created by Beytullah Cakmak on 3.06.2025.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textSurname: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func registerButtonClick(_ sender: Any) {
        if (textName.text?.isEmpty)! || (textSurname.text?.isEmpty)! || (textEmail.text?.isEmpty)!  || (textPassword.text?.isEmpty)! {
            
            showAlert(title: "HATA!", message: "Lütfen tüm alanları doldurunuz.")
        }
        else{
            Auth.auth().createUser(withEmail: textEmail.text!, password: textPassword.text!) { authResult, error in
                
                if error != nil {
                    self.showAlert(title: "HATA!", message: error!.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: "toLoginPagefromRegister", sender: nil)
                }
            }
            
        }
    }
    
    

}
