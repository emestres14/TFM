//
//  ContentsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tablaContenidos: UITableView!
    @IBOutlet weak var orderBy: UISegmentedControl!
    @IBOutlet weak var buttonAdd: UIButton!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "contentCell")
        return cell
    }
    
    @IBAction func orderByChanged(_ sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            // "Recent" is selected
        }
        else {
            // "Popular" is selected
        }
    }

    @IBAction func addPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "content2addContent", sender: self)
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
