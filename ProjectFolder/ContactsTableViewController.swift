//
//  ContactsTableViewController.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit
import Firebase
import PKHUD


class ContactsTableViewController: UITableViewController {
    
    @IBOutlet var mainTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //custom cell decleration
        let CellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        mainTable.register(CellNib, forCellReuseIdentifier: "MyCell")
        
        //get data for table from firebase
        rootRef.child("Users/\(userID!)/Contacts").observe(.value, with: { (snapshot) in
            // Get user value
            if snapshot.value != nil{
                numContacts.removeAll()
                for item in snapshot.children{
                    let value = item as! DataSnapshot
                    let contactID =  value.key
                    let contactName = value.childSnapshot(forPath: "Name").value as! String
                    let contactEmail = value.childSnapshot(forPath: "Email").value as! String
                    let contactPhone = value.childSnapshot(forPath: "Phone").value as! String
                    let contactType = value.childSnapshot(forPath: "Type").value as! String
                    let user = Contact(id: contactID, name: contactName , email: contactEmail, phone: contactPhone, phoneType: contactType)
                    numContacts.append(user)
                }
                self.mainTable.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        //refresh table if needed
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func LogOutUserBtn(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "LogOutSuccess", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
    @objc func refresh(sender:AnyObject)
    {
        // Updating data here.
        rootRef.child("Users/\(userID!)/Contacts").observe(.value, with: { (snapshot) in
            // Get user value
            if snapshot.value != nil{
              numContacts.removeAll()
                for item in snapshot.children{
                    let value = item as! DataSnapshot
                    let contactID =  value.key
                    let contactName = value.childSnapshot(forPath: "Name").value as! String
                    let contactEmail = value.childSnapshot(forPath: "Email").value as! String
                    let contactPhone = value.childSnapshot(forPath: "Phone").value as! String
                    let contactType = value.childSnapshot(forPath: "Type").value as! String
                    let user = Contact(id: contactID, name: contactName , email: contactEmail, phone: contactPhone, phoneType: contactType)
                    numContacts.append(user)
                }
                self.mainTable.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        self.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numContacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
        let users = numContacts[indexPath.row]
            
        cell.cellNameLabel.text = users.name
        cell.cellEmailLabel.text = users.email
        cell.cellPhonenumLabel.text = users.phone
        cell.cellPhonetypeLabel.text = "(\(users.phoneType!))"
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewSelectedContact", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSelectedContact" {
            let indexPath = mainTable.indexPathForSelectedRow!
            self.tableView.deselectRow(at: indexPath, animated: true)
            let data = numContacts[indexPath.row]
            let destinationVC = segue.destination as! ContactDetailsViewController
            destinationVC.detailContact = data
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let user = numContacts[indexPath.row]
            deleteContact(id: user.id!)
            numContacts.remove(at: indexPath.row)
            mainTable.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UITableViewController: customTVCellDelegate {
    func deleteContact(id:String) {
        //delete contact from server here
        rootRef.child("Users/\(userID!)/Contacts/\(id)/").setValue([:], withCompletionBlock: { (error, dbRef) in
        })
    }
    func deleteBTNClicked(cell: UITableViewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        let user = numContacts[indexPath!.row]
        numContacts.remove(at: indexPath!.row)
        deleteContact(id: user.id!)
        tableView.deleteRows(at: [indexPath!], with: .fade)
        tableView.endUpdates()
    }
}
