//
//  SignUpViewController.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit
import FirebaseAuth
import PKHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPassTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        
        let userEmail = EmailTextField.text
        let userPassword = PasswordTextField.text
        let confirmUserPass = ConfirmPassTextField.text
        
        let emailAlert = UIAlertController(title: "Invalid Email", message: "Please enter a valid email \n (i.e. johndoe@mail.com)", preferredStyle: UIAlertController.Style.alert)
        emailAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        let PassAlert = UIAlertController(title: "Invalid Password", message: "Please enter a valid password \n (must be six charaters long)", preferredStyle: UIAlertController.Style.alert)
        PassAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        let PassNoMatchAlert = UIAlertController(title: "Passwords do not match", message: "Please confirm password", preferredStyle: UIAlertController.Style.alert)
        PassNoMatchAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        let SignUpFailed = UIAlertController(title: "Sign Up Failed", message: "Error Signing Up", preferredStyle: UIAlertController.Style.alert)
        SignUpFailed.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        
        (userEmail != nil && userEmail != "") ? (((userPassword != nil && userPassword != "")&&((confirmUserPass != nil)||(confirmUserPass != ""))) ? ((userPassword != confirmUserPass) ? (self.present(PassNoMatchAlert, animated: true, completion: nil)) : (((userEmail != nil) && (userPassword != nil)) ? (SignUpUser(email: userEmail!, password: userPassword!)) : (self.present(SignUpFailed, animated: true, completion: nil)))) : (self.present(PassAlert, animated: true, completion: nil))) : (self.present(emailAlert, animated: true, completion: nil))
        
    }
    
    func SignUpUser(email:String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if error == nil {
                HUD.flash(.success, delay: 0.25)
                userID = Auth.auth().currentUser?.uid
                self.performSegue(withIdentifier: "SignUpSuccess", sender: self)
                print("SignUp successful Email: \(email) and Password: \(password)")
            }
            else {
                let SignUpFailed = UIAlertController(title: "Sign Up Failed", message: "Error Signing Up", preferredStyle: UIAlertController.Style.alert)
                SignUpFailed.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(SignUpFailed, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func CancelSignUpBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
