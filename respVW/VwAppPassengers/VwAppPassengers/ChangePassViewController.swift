//
//  ProfileViewController.swift
//  VwAppPassengers
//
//  Created by Suriel Asael on 18/04/18.
//  Copyright © 2018 Suriel Asael. All rights reserved.
//

import UIKit
import Alamofire

class ChangePassViewController: UIViewController{
    
    let URL_USER_LOGIN = "http://10.50.118.81:8000/api/update-user/"
    var myOldPass: String = ""
    var carrera: String = ""
    var nombre: String = ""
    var id: String = ""
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var oldPassLabel: UITextField!
    @IBOutlet weak var newPassLabel: UITextField!
    
    @IBAction func buttonLogout(_ sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func buttonChange(_ sender: UIButton) {
        if !(oldPassLabel.text == ""){
            if !(newPassLabel.text == "") {
                if myOldPass == oldPassLabel.text{
                    let parameters: Parameters=[
                        "password":newPassLabel.text!,
                        "nombre":nombre,
                        "carrera":carrera
                    ]
                    
                    Alamofire.request(URL_USER_LOGIN+id, method: .put, parameters: parameters).responseJSON
                        {
                            response in
                            //printing response print(response)
                            
                            //getting the json value from the server
                            if let result = response.result.value {
                                let jsonData = result as! NSDictionary
                                let resError = jsonData.value(forKey: "error") as! String
                                print(resError)
                                //if there is no error
                                if(resError == "false"){
                                    //switching the screen
                                    //
                                    
                                    
                                    
                                    //getting user values
                                    
                                    let password = self.newPassLabel.text!
                                    
                                    //saving user values to defaults
                                    self.defaultValues.set(password, forKey: "password")
                                    
                                    self.showAlert(title: "Cambio hecho", message: "El password ha sido cambiado")
                                    self.performSegue(withIdentifier: "showPerfil", sender: self)
                                    
                                }else{
                                    //error message in case of invalid credential
                                        self.showAlert(title: "Error al cambiar Password", message: "Hubo un error con el servidor")
                                }
                            }
                            
                    }
                }else{
                    self.showAlert(title: "Debe coincidir el password", message: "El password anterior no es el mismo")
                }
            }else{
                self.showAlert(title: "Campo vacío", message: "Por favor rellena el campo nuevo password")
            }
        }else{
            self.showAlert(title: "Campo vacío", message: "Por favor rellena el campo password anterior")
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        
        if let pass = defaultValues.string(forKey: "password"){
            //setting the name to label
            myOldPass = pass
            carrera = defaultValues.string(forKey: "carrera")!
            nombre = defaultValues.string(forKey: "nombre")!
            id = defaultValues.string(forKey: "id")!
        }else{
            //send back to login view controller
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



