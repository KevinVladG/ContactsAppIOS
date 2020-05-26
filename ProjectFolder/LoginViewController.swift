//
//  ViewController.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        let userEmail = EmailTextField.text
        let userPass = PasswordTextField.text
        
        let badEmailField = UIAlertController(title: "Invalid Field", message: "Please Enter Valid Email", preferredStyle: UIAlertController.Style.alert)
        badEmailField.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        let badPassField = UIAlertController(title: "Invalid Field", message: "Please Enter Valid Password", preferredStyle: UIAlertController.Style.alert)
        badPassField.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        
        (userEmail != nil && userEmail != "") ? ((userPass != nil && userPass != "") ? LogUserIn(email: userEmail!, password: userPass!) : (self.present(badPassField, animated: true, completion: nil)) ) : (self.present(badEmailField, animated: true, completion: nil))
    }
    
    func LogUserIn (email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                userID = Auth.auth().currentUser?.uid
                self.performSegue(withIdentifier: "LogInSuccess", sender: self)
            }
            else {
                print("The ERROR IS: \(error.debugDescription)")
                let SignInFailed = UIAlertController(title: "Sign In Failed", message: "Please Check Email or Password", preferredStyle: UIAlertController.Style.alert)
                       SignInFailed.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(SignInFailed, animated: true, completion: nil)
            }
            
        }
    }
    @IBAction func unwindLooginVC(unwindSegue: UIStoryboardSegue){
        EmailTextField.text = ""
        PasswordTextField.text = ""
    }
}

