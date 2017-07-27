//
//  ContactsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit
import Firebase

class ContactsViewController: UIViewController, UISearchResultsUpdating, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buttonChat: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namePicker: UIPickerView!
    
    var searchController: UISearchController!
    var databaseRef: FIRDatabaseReference!
    var usuarios = [NSString]()
    var allUsers = [NSString]()
    var currentUser: NSString!
    var chatUser: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        let defaults = UserDefaults.standard
        currentUser = defaults.string(forKey: nombreKey) as NSString!
        	
        databaseRef = FIRDatabase.database().reference()
        getUsersFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func chatPressed(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let estaLoggeado = defaults.bool(forKey: loggeadoKey)
        let inicioAuto = defaults.bool(forKey: iniciarAutomatKey)
        
        if (estaLoggeado) {
            performSegue(withIdentifier: "contact2chat", sender: self)
        }
        else if (inicioAuto) {
            defaults.set(true, forKey: loggeadoKey)
            defaults.synchronize()
            
            performSegue(withIdentifier: "contact2chat", sender: self)
        }
        else {
            let controller = UIAlertController(title: "You are not logged in", message:"This is required to chat", preferredStyle: .actionSheet)
            let yesAction = UIAlertAction(title: "Log In", style: .destructive, handler: { action in
                self.performSegue(withIdentifier: "contact2loginRegister", sender: self)
            })
            let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            })
            controller.addAction(yesAction)
            controller.addAction(noAction)
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func getUsersFromDatabase () {
        databaseRef.child("usuarios").observeSingleEvent(of: .value , with: {
            (snapshot) in
            //let userID = FIRAuth.auth()?.currentUser?.uid
            let register = snapshot.value as? NSDictionary
            let userIDs = register?.allKeys as? [NSString] ?? []
            for i in 0 ..< userIDs.count {
                let userData = register?.value(forKey: userIDs[i] as String) as? NSDictionary
                let username = userData?["nombre"] as! NSString
                
                if (!username.isEqual(to: (self.currentUser as String))) {
                    self.usuarios.append(username)
                    self.allUsers.append(username)
                }
            }
            
            self.namePicker.reloadAllComponents()
            
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: UISearchResultsUpdating Conformance
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchString = searchBar.text {
            usuarios.removeAll()
            
            if !searchString.isEmpty {
                for user in allUsers {
                    let nombreRange = (user.localizedStandardContains(searchString))
                    
                    if nombreRange {
                        usuarios.append(user)
                    }
                }
            }
            else {
                for user in allUsers {
                    usuarios.append(user)
                }
            }
        }
        self.namePicker.reloadAllComponents()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidEndEditing searchText: String) {
        self.resignFirstResponder()
    }

    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.usuarios.count
    }
    
    // MARK: Picker Delegate Methods
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.usuarios[row] as String
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let chatUserSelected = namePicker.selectedRow(inComponent: 0)
        let chatUserName = usuarios[chatUserSelected] as NSString
        
        let defaults = UserDefaults.standard
        let inicio = defaults.bool(forKey: iniciarAutomatKey)
        let loggeado = defaults.bool(forKey: loggeadoKey)

        if (inicio || loggeado) {
            let chatVC = segue.destination as! ChatViewController
            chatVC.usuario2 = chatUserName
        }
        else {
            let loginVC = segue.destination as! LoginRegisterViewController
            loginVC.parentVC = "contacts"
        }
        
        //listVC.parentVC = "settings"
        
        /*var i = 0
        var enc = false
        while ((!enc) && (i < self.allUsers.count)) {
            let user = allUsers[i]
            if (user.isEqual(to: chatUserName)) {
                chatUser = user
                enc = true
            }
            
            i += 1
        }*/
    }
}
