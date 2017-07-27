//
//  SetSettingsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit
import Firebase

class SetSettingsViewController: UIViewController {

    @IBOutlet weak var nombreTxtField: UITextField!
    @IBOutlet weak var usuarioTxtField: UITextField!
    @IBOutlet weak var contrasenyaTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    @IBOutlet weak var updateButton: UIButton!
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        
        contrasenyaTxtField.isSecureTextEntry = true
        usuarioTxtField.isUserInteractionEnabled = false
        
        refreshFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func updatePressed(_ sender: AnyObject) {
        let nombre = nombreTxtField.text

        let contrasenya = contrasenyaTxtField.text
        let correo = emailTxtField.text
        let inicioAutomatico = rememberSwitch.isOn
        
        let defaults = UserDefaults.standard
        let usuario = defaults.string(forKey: usuarioKey)
        
        if (!nombre!.isEqual(defaults.string(forKey: nombreKey))) {
            defaults.set(nombre, forKey: nombreKey)
            databaseRef.child("usuarios/" + usuario! + "/nombre").setValue(nombre)
        }
        
        if (!contrasenya!.isEqual(defaults.string(forKey: contrasenyaKey))) {
            defaults.set(contrasenya, forKey: contrasenyaKey)
            databaseRef.child("usuarios/" + usuario! + "/contrasenya").setValue(contrasenya)
        }
        
        if (!correo!.isEqual(defaults.string(forKey: contrasenyaKey))) {
            defaults.set(correo, forKey: contrasenyaKey)
            databaseRef.child("usuarios/" + usuario! + "/correo").setValue(contrasenya)
        }
        
        
        if (defaults.bool(forKey: iniciarAutomatKey) != inicioAutomatico) {
            defaults.set(inicioAutomatico, forKey: iniciarAutomatKey)
        }

        /*
         if (!usuario.isEqual(to: defaults.string(forKey: usuarioKey))) {
         defaults.set(usuario, forKey: usuarioKey)
         databaseRef.child("usuarios/" + usrLogin + "/usuario").setValue(usuario)
         }
         */

        defaults.synchronize()
    }
    
    func refreshFields() {
        let defaults = UserDefaults.standard
        let estaLoggeado = defaults.bool(forKey: loggeadoKey)
        let inicioAuto = defaults.bool(forKey: iniciarAutomatKey)
        
        if (!estaLoggeado && !inicioAuto) {
            let controller = UIAlertController(title: "You are not logged in", message:"", preferredStyle: .actionSheet)
            let yesAction = UIAlertAction(title: "Log In", style: .destructive, handler: { action in
                self.performSegue(withIdentifier: "settings2loginRegister", sender: self)
            })
            let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                self.performSegue(withIdentifier: "settings2home", sender: self)
            })
            controller.addAction(yesAction)
            controller.addAction(noAction)
            
            self.present(controller, animated: true, completion: nil)
        }
        else {
            nombreTxtField.text = defaults.string(forKey: nombreKey)
            usuarioTxtField.text = defaults.string(forKey: usuarioKey)
            contrasenyaTxtField.text = defaults.string(forKey: contrasenyaKey)
            emailTxtField.text = defaults.string(forKey: correoKey)
            rememberSwitch.setOn(inicioAuto, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
    }
    
    func applicationWillEnterForeground(notification:NSNotification) {
        let defaults = UserDefaults.standard
        let inicio = defaults.bool(forKey: iniciarAutomatKey)
        let estaLoggeado = defaults.bool(forKey: loggeadoKey)
        
        if (!inicio && !estaLoggeado) {
            defaults.set("", forKey: usuarioKey)
            defaults.set("", forKey: contrasenyaKey)
            defaults.set("", forKey: nombreKey)
            defaults.set(false, forKey: loggeadoKey)
        }
        
        defaults.synchronize()
        refreshFields()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listVC = segue.destination as! LoginRegisterViewController
        listVC.parentVC = "settings"
    }
}
