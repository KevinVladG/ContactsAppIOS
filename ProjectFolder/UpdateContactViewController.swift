//
//  UpdateContactViewController.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class UpdateContactViewController: UIViewController {

    @IBOutlet weak var nameContactTF: UITextField!
    @IBOutlet weak var emailContactTF: UITextField!
    @IBOutlet weak var phoneContactTF: UITextField!
    @IBOutlet weak var phoneTypeSegmentController: UISegmentedControl!
    
    var updatedcontact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameContactTF.text = updatedcontact?.name
        emailContactTF.text = updatedcontact?.email
        phoneContactTF.text = updatedcontact?.phone
        
        (updatedcontact?.phoneType == "Cell") ? (phoneTypeSegmentController.selectedSegmentIndex = 0) : (print(""))
        (updatedcontact?.phoneType == "Home") ? (phoneTypeSegmentController.selectedSegmentIndex = 1) : (print(""))
        (updatedcontact?.phoneType == "Office") ? (phoneTypeSegmentController.selectedSegmentIndex = 2) : (print(""))

        // Do any additional setup after loading the view.
    }
    
    func updateContact(id:String, name:String, email:String, phone:String, type:String) {
       //update contact from the server here
        rootRef.child("Users/\(userID!)/Contacts/\(id)/").setValue(["Email": email, "Name": name, "Phone": phone, "Type": type], withCompletionBlock: { (error, dbRef) in
        })
    }
    
    @IBAction func updateContactBTN(_ sender: Any) {
        
        
        if (nameContactTF.text == "" || nameContactTF.text == nil){
            let alert = UIAlertController(title: "Missing Name", message: "Please enter a contact name.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (emailContactTF.text == "" || emailContactTF.text == nil){
            let alert = UIAlertController(title: "Missing Email", message: "Please enter a contact email.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (phoneContactTF.text == "" || phoneContactTF.text == nil){
            let alert = UIAlertController(title: "Missing Phone Number", message: "Please enter a contact phone number.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            updatedcontact?.name = nameContactTF.text
            updatedcontact?.email = emailContactTF.text
            updatedcontact?.phone = phoneContactTF.text
            updatedcontact?.phoneType = phoneTypeSegmentController.titleForSegment(at: phoneTypeSegmentController.selectedSegmentIndex)
            updateContact(id: (updatedcontact?.id)!, name: (updatedcontact?.name)!, email: (updatedcontact?.email)!, phone: (updatedcontact?.phone)!, type: (updatedcontact?.phoneType)!)
            NotificationCenter.default.post(name: Notification.Name("updatingContactDetails"), object: updatedcontact)
            HUD.flash(.success, delay: 0.25)
            self.performSegue(withIdentifier: "updatedetailsVC", sender: self)
    
        }
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
