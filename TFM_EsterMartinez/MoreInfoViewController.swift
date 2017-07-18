//
//  MoreInfoViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://www.uji.es"
        let url = NSURL(string: urlString)!
        let request = URLRequest(url: url as URL)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
