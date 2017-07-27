//
//  RegisterViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nombreTxtField: UITextField!
    @IBOutlet weak var usuarioTxtField: UITextField!
    @IBOutlet weak var contrasenyaTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var parentVC: NSString!
    var userChat: NSString!
    
    var databaseRef: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        self.navigationItem.hidesBackButton = true
        
        contrasenyaTxtField.isSecureTextEntry = true
        databaseRef = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        let nombre = nombreTxtField.text
        let usuario = usuarioTxtField.text
        let contrasenya = contrasenyaTxtField.text
        let correo = emailTxtField.text
        let inicioAuto = rememberSwitch.isOn
        
        if (nombre!.isEqual("") || usuario!.isEqual("") || contrasenya!.isEqual("") || correo!.isEqual("")) {
            let controller = UIAlertController(title: "All fields are requiered", message:"Please, fill in the blank fields", preferredStyle: .actionSheet)
            let yesAction = UIAlertAction(title: "OK", style: .destructive, handler: { action in
            })
            
            controller.addAction(yesAction)
            self.present(controller, animated: true, completion: nil)
        }
        else {
            // Comprobamos si ya existe ese usuario
            databaseRef.child("usuarios/" + usuario!).observeSingleEvent(of: .value , with: {
                (snapshot) in
                //let userID = FIRAuth.auth()?.currentUser?.uid
                let register = snapshot.value as? NSDictionary
                let userIDs = register?.allKeys as? [NSString] ?? []
                if (userIDs.count > 0) {
                    // El usuario ya existe
                    let controller = UIAlertController(title: "This user already exists", message:"Please, introduce a different user", preferredStyle: .actionSheet)
                    let yesAction = UIAlertAction(title: "OK", style: .destructive, handler: { action in
                    })
                    
                    controller.addAction(yesAction)
                    self.present(controller, animated: true, completion: nil)
                }
                else {
                    let defaults = UserDefaults.standard
                    defaults.set(usuario, forKey: usuarioKey)
                    defaults.set(contrasenya, forKey: contrasenyaKey)
                    defaults.set(nombre, forKey: nombreKey)
                    defaults.set(inicioAuto, forKey: iniciarAutomatKey)
                    defaults.set(true, forKey: loggeadoKey)
                    defaults.synchronize()
                    
                    // Creamos al usuario nuevo
                    
                    // Ahora vamos a nuestro destino
                    if (self.parentVC.isEqual(to: "contents")) {
                        self.performSegue(withIdentifier: "register2addContents", sender: nil)
                    }
                    else if (self.parentVC.isEqual(to: "comments")) {
                        self.performSegue(withIdentifier: "register2addComments", sender: nil)
                    }
                    else if (self.parentVC.isEqual(to: "settings")) {
                        self.performSegue(withIdentifier: "register2settings", sender: nil)
                    }
                    else {
                        self.performSegue(withIdentifier: "register2chat", sender: nil)
                    }
                    
                }
            })
            { (error) in
                print(error.localizedDescription)
            }
            
        }

    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (self.parentVC.isEqual(to: "contents")) {
        }
        else if (parentVC.isEqual(to: "comments")) {
        }
        else if (parentVC.isEqual(to: "contacts")) {
            let chatVC = segue.destination as! ChatViewController
            chatVC.usuario2 = self.userChat
        }
        else {
            let registerVC = segue.destination as! RegisterViewController
            registerVC.parentVC = self.parentVC
            registerVC.userChat = self.userChat
        }
    }

}
