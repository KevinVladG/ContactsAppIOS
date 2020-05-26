//
//  ContactDetailsViewController.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactPhoneTypeLabel: UILabel!
    
    var detailContact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactNameLabel.text = detailContact?.name
        contactEmailLabel.text = detailContact?.email
        contactPhoneLabel.text = detailContact?.phone
        contactPhoneTypeLabel.text = detailContact?.phoneType
        NotificationCenter.default.addObserver(self, selector: #selector(updatingContact(notification:)), name: Notification.Name("updatingContactDetails"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func updatingContact(notification: Notification){
        let currentContact = notification.object! as! Contact
        contactNameLabel.text = currentContact.name
        contactEmailLabel.text = currentContact.email
        contactPhoneLabel.text = currentContact.phone
        contactPhoneTypeLabel.text = currentContact.phoneType
    }


    func deleteContact(id:String) {
        //delete that contact from server here
        rootRef.child("Users/\(userID!)/Contacts/\(id)/").setValue([:], withCompletionBlock: { (error, dbRef) in
        })
    }
    
    @IBAction func deleteBTN(_ sender: Any) {
        deleteContact(id: (detailContact?.id)!)
        HUD.flash(.success, delay: 0.25)
        //unwind
        self.performSegue(withIdentifier: "reloadContactList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateContact" {
            let destinationVC = segue.destination as! UpdateContactViewController
            destinationVC.updatedcontact = detailContact
        }
    }
    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
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
