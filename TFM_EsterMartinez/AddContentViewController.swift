//
//  AddContentViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleContent: UITextField!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentBox: UITextView!
    
    
    @IBOutlet weak var contentType: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func addPressed(_ sender: AnyObject) {
    }
    
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
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
