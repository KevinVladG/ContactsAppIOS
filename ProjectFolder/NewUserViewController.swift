//
//  NewUserViewController.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import PKHUD

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var newContactNameTF: UITextField!
    @IBOutlet weak var newContactEmailTF: UITextField!
    @IBOutlet weak var newContactPhoneTF: UITextField!
    @IBOutlet weak var newContactPhoneTypeSeg: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelBTN(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewContactBTN(_ sender: Any) {
        if (newContactNameTF.text == "" || newContactNameTF.text == nil){
            let alert = UIAlertController(title: "Missing Name", message: "Please enter a contact name.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (newContactEmailTF.text == "" || newContactEmailTF.text == nil){
            let alert = UIAlertController(title: "Missing Email", message: "Please enter a contact email.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (newContactPhoneTF.text == "" || newContactPhoneTF.text == nil){
            let alert = UIAlertController(title: "Missing Phone Number", message: "Please enter a contact phone number.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            //add user to database
            createContacts(userID: userID!, name: newContactNameTF.text!, email: newContactEmailTF.text!, phone: newContactPhoneTF.text!, type: newContactPhoneTypeSeg.titleForSegment(at: newContactPhoneTypeSeg.selectedSegmentIndex)!)
            //confirm that user is now in the data base
            HUD.flash(.success, delay: 0.25)
            //reset user field so user can add more contacts
            newContactNameTF.text = ""
            newContactEmailTF.text = ""
            newContactPhoneTF.text = ""
            newContactPhoneTypeSeg.selectedSegmentIndex = 1
            self.performSegue(withIdentifier: "reloadnewcontact", sender: self)
        }
    }
    
    func createContacts(userID:String, name:String, email:String, phone:String, type:String) {
        //create new contact here
        rootRef.child("Users/\(userID)/Contacts").childByAutoId().setValue(["Name": name, "Email": email, "Phone": phone, "Type": type])
    }
    
    
    // MARK: - Navigation
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
