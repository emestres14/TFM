//
//  ContactsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UISearchResultsUpdating, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buttonChat: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namePicker: UIPickerView!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func chatPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "contact2chat", sender: self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }

    // MARK:-
    // MARK: Picker Data Source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
        Int) -> String? {
        return nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
