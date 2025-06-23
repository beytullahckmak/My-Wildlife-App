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
    
    func showAlert (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toBackApp", sender: nil)
            
        }catch{
            showAlert(title: "HATA!!!", message: "Çıkış Işlemi Başarısız!")
        }
    }
    
}
