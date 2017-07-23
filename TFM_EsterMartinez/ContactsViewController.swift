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
    var allUsers = [Usuario]()
    var currentUser: Usuario!
    var chatUser: Usuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.currentUser = appDelegate.currentUser
        
        databaseRef = FIRDatabase.database().reference()
        getUsersFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func chatPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "contact2chat", sender: self)
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
                
                if (!username.isEqual(to: (self.currentUser.nombre as String))) {
                    self.usuarios.append(username)

                    let user = Usuario()
                    user.nombre = userData?["nombre"] as! NSString
                    user.correo = userData?["correo"] as! NSString
                    user.foto = userData?["foto"] as! NSString
                    self.allUsers.append(user)
                }
            }
            
            self.namePicker.reloadAllComponents()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: UISearchResultsUpdating Conformance
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchString = searchBar.text {
            usuarios.removeAll()
            
            if !searchString.isEmpty {
                for user in allUsers {
                    let nombreForKey = user.nombre
                    let nombreRange = (nombreForKey?.localizedStandardContains(searchString))!
                    
                    let correoForKey = user.correo
                    let correoRange = (correoForKey?.localizedStandardContains(searchString))!
                    
                    if (nombreRange || correoRange) {
                        usuarios.append(user.nombre)
                    }
                }
            }
            else {
                for user in allUsers {
                    usuarios.append(user.nombre)
                }
            }
        }
        self.namePicker.reloadAllComponents()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
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
        let chatUserName = usuarios[chatUserSelected] as String
        
        var i = 0
        var enc = false
        while ((!enc) && (i < self.allUsers.count)) {
            let user = allUsers[i]
            if (user.nombre.isEqual(to: chatUserName)) {
                chatUser = user
                enc = true
            }
            
            i += 1
        }
    }
}
