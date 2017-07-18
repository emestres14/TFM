//
//  MeetUsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 12/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit

private let reuseIdentifier = "meetCell"

class MeetUsViewController: UICollectionViewController {
    
    let imageList: [String] = ["http://www.tollaga.com/master/service.php?id=01", "http://www.tollaga.com/master/service.php?id=02&latency=2", "http://www.tollaga.com/master/service.php?id=03&latency=10", "http://www.tollaga.com/master/service.php?id=04&latency=5", "http://www.tollaga.com/master/service.php?id=05&latency=1", "http://www.tollaga.com/master/service.php?id=06&latency=20", "http://www.tollaga.com/master/service.php?id=07&latency=0"]
    
    private var images = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< imageList.count {
            images.append(UIImageView())
        }
        
        loadImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MeetUsViewCell
        
        if (images[indexPath.row].image == nil) {
            cell.activityProcess.startAnimating()
            cell.backgroundColor = UIColor.lightGray
            cell.imageContent?.image = nil
        }
        else {
            cell.activityProcess.stopAnimating()
            cell.imageContent?.image = images[indexPath.row].image!
        }
    
        return cell
    }
    
    func refresh() {
        self.collectionView?.reloadData()
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(link: URL, indice: Int) {
        getDataFromUrl(url: link) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.images[indice].image = UIImage(data: data)
                self.refresh()
            }
        }
    }
    
    func loadImages() {
        let queue = DispatchQueue.global(qos: .default)
        
        for i in 0 ..< self.imageList.count {
            let imageLink = URL(string: self.imageList[i])
            queue.async {
                self.downloadImage(link: imageLink!, indice: i)
            }
        }
    }
}
