//
//  ContentDetailsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit

class ContentDetailsViewController: UIViewController {

    @IBOutlet weak var imageContentType: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var content: UITextView!
    
    @IBOutlet weak var commentsTable: UITableView!
    
    //@IBOutlet weak var starRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var imagen = UIImage(named: "add-star")
        imagen = imagen?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: imagen, style: .done, target: self, action:#selector(self.modifyFavourites(sender:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func modifyFavourites (sender: UIBarButtonItem) {
        var imagen = UIImage(named: "add-star-selected")
        imagen = imagen?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: imagen, style: .done, target: self, action:#selector(self.modifyFavourites(sender:)))
    }
    
}
