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
import Firebase

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
        
        /*
        var interval = Double()
        var date = NSDate()
        date = NSDate(timeIntervalSince1970: interval)
        print(date)
        interval = date.timeIntervalSince1970
        var date2 = NSDate()
        let intre2 = date2.timeIntervalSince1970
        print(NSDate(timeIntervalSince1970: intre2))
        print("1")
 */
        
        /*FIRAuth.auth()?.createUser((withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error == nil {
                print("You have successfully signed up")
                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.present(vc!, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
       */
        
        /*
        let usuario = "emartine"
        let cadena = "usuarios/" + usuario
        
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child(cadena).observeSingleEvent(of: .value , with: {
            (snapshot) in
            //let userID = FIRAuth.auth()?.currentUser?.uid
            let register = snapshot.value as? NSDictionary
            let userIDs = register?.allKeys as? [NSString] ?? []
            if (userIDs.count > 0) {
                let user = register?["contrasenya"] as! NSString
                print(user)
            }
            else {
                // Ese usuario no existe ==> mostrar alerta
            }
            
            })
        { (error) in
            print(error.localizedDescription)
        }
 */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
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
