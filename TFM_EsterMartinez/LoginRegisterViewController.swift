//
//  LoginRegisterViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit
import Firebase

class LoginRegisterViewController: UIViewController {

    @IBOutlet weak var usuarioTxtField: UITextField!
    @IBOutlet weak var contrasenyaTxtField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var autoStart: UISwitch!
    
    var parentVC: NSString!
    var userChat: NSString!
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contrasenyaTxtField.isSecureTextEntry = true
        
        databaseRef = FIRDatabase.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "loginRegister2register", sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        let usuario = "usuarios/" + usuarioTxtField.text!
        let inicioAutomatico = autoStart.isOn
        
        databaseRef.child(usuario).observeSingleEvent(of: .value , with: {
            (snapshot) in
            //let userID = FIRAuth.auth()?.currentUser?.uid
            let register = snapshot.value as? NSDictionary
            let userIDs = register?.allKeys as? [NSString] ?? []
            if (userIDs.count > 0) {
                let passwd = register?["contrasenya"] as! NSString
                if (passwd.isEqual(to: self.contrasenyaTxtField.text! as String)) {
                    // Usuario y contrasenya coinciden ==> hacemos el login correspondiente
                    
                    // Recogemos la informacion y actualizamos el fichero defaults
                    let nombre = register?["nombre"]
                    let correo = register?["correo"]
                    
                    let defaults = UserDefaults.standard
                    
                    defaults.set(nombre, forKey: nombreKey)
                    defaults.set(usuario, forKey: usuarioKey)
                    defaults.set(passwd, forKey: contrasenyaKey)
                    defaults.set(correo, forKey: contrasenyaKey)
                   
                    defaults.set(inicioAutomatico, forKey: iniciarAutomatKey)
                    defaults.set(true, forKey: loggeadoKey)
                    
                    defaults.synchronize()
                    
                    if (self.parentVC.isEqual(to: "contents")) {
                        self.performSegue(withIdentifier: "login2addContents", sender: nil)
                    }
                    else if (self.parentVC.isEqual(to: "comments")) {
                        self.performSegue(withIdentifier: "login2addComments", sender: nil)
                    }
                    else if (self.parentVC.isEqual(to: "settings")) {
                        self.performSegue(withIdentifier: "login2settings", sender: nil)
                    }
                    else {
                        self.performSegue(withIdentifier: "login2chat", sender: nil)
                    }
                }
                else {
                    // La contrasenya introducida no coincide con la del usuaria ==> mostrar alerta
                    let controller = UIAlertController(title: "The password is not correct", message:"Please, try again", preferredStyle: .actionSheet)
                    let yesAction = UIAlertAction(title: "OK", style: .destructive, handler: { action in })
                    let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    controller.addAction(yesAction)
                    controller.addAction(noAction)
                    
                    self.present(controller, animated: true, completion: nil)
                }
            }
            else {
                // Ese usuario no existe ==> mostrar alerta
                let controller = UIAlertController(title: "The user is not valid", message:"Please, try again", preferredStyle: .actionSheet)
                let yesAction = UIAlertAction(title: "OK", style: .destructive, handler: { action in })
                let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                controller.addAction(yesAction)
                controller.addAction(noAction)
                
                self.present(controller, animated: true, completion: nil)
            }
            
            })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func refreshFields() {
        let defaults = UserDefaults.standard
        let inicio = defaults.bool(forKey: iniciarAutomatKey)
        
        usuarioTxtField.text = defaults.string(forKey: usuarioKey)
        contrasenyaTxtField.text = defaults.string(forKey: contrasenyaKey)
        
        if (inicio) {
            if (parentVC.isEqual(to: "contents")) {
                self.performSegue(withIdentifier: "login2addContents", sender: nil)
            }
            else if (parentVC.isEqual(to: "comments")) {
                self.performSegue(withIdentifier: "login2addComments", sender: nil)
            }
            else if (parentVC.isEqual(to: "settings")) {
                self.performSegue(withIdentifier: "login2settings", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "login2chat", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        refreshFields()
    }
    
    func applicationWillEnterForeground(notification:NSNotification) {
        let defaults = UserDefaults.standard
        let inicio = defaults.bool(forKey: iniciarAutomatKey)
        
        if (!inicio) {
            defaults.set("", forKey: usuarioKey)
            defaults.set("", forKey: contrasenyaKey)
        }
        
        defaults.synchronize()
        refreshFields()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Navigation
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

