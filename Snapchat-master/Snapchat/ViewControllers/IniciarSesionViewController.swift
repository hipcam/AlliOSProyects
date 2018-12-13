//
//  ViewController.swift
//  Snapchat
//
//  Created by Jordan Revata Cuela on 24/10/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user , error) in
            print("Intentamos iniciar sesión")
            if(error != nil){
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    
                    print("Intentamos crear un usuario")
                    if error != nil {
                        print("tenemos el siguiente error: \(error)")
                    }else{
                        print("El usuario fue creado exitosamente")
                        FIRDatabase.database().reference().child("users").child((user?.uid)!).child("email").setValue(user?.uid)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
        
    }
    


}

