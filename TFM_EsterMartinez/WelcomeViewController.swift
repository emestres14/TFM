//
//  WelcomeViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class WelcomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var buttonMoreInfo: UIButton!
    @IBOutlet weak var buttonMeetUs: UIButton!
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var logoUniversidad: UIImageView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 39.994677, longitude: -0.0691674)
        let center = CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapa.setRegion(region, animated: true)
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = initialLocation.coordinate
        newPin.title = "Universitat Jaume I"
        mapa.addAnnotation(newPin)
        mapa.selectAnnotation(newPin, animated: false)
        
        mapa.isZoomEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func moreInfoPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "welcome2moreInfo", sender: self)
    }
    
    
    @IBAction func meetUsPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "welcome2meetUs", sender: self)
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
