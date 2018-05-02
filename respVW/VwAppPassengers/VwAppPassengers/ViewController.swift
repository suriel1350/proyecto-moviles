//
//  ViewController.swift
//  VwAppPassengers
//
//  Created by Suriel Asael on 18/04/18.
//  Copyright © 2018 Suriel Asael. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let URL_USER_LOGIN = "http://10.50.118.81:8000/api/login"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard

    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonLog: UIButton!
    @IBAction func buttonLogin(_ sender: UIButton) {
        let parameters: Parameters=[
            "matricula":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        if (!(textFieldUserName.text == "") && !(textFieldPassword.text == "")) {
            Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        let resError = jsonData.value(forKey: "error") as! String
                        print(resError)
                        //if there is no error
                         if(resError == "false"){
                            let pass = self.textFieldPassword.text
                            //getting the user from response
                            let user = jsonData.value(forKey: "user") as! NSDictionary
                            
                            //getting user values
                            let userId = user.value(forKey: "id") as! Int
                            let matricula = user.value(forKey: "matricula") as! String
                            let userName = user.value(forKey: "nombre") as! String
                            let carrera = user.value(forKey: "carrera") as! String
                            let fotografia = user.value(forKey: "fotografia") as! String
                            
                            //saving user values to defaults
                            self.defaultValues.set(userId, forKey: "id")
                            self.defaultValues.set(userName, forKey: "nombre")
                            self.defaultValues.set(matricula, forKey: "matricula")
                            self.defaultValues.set(carrera, forKey: "carrera")
                            self.defaultValues.set(fotografia, forKey: "fotografia")
                            
                            self.defaultValues.set(pass, forKey: "password")
                            
                            //switching the screen
                            
                            self.performSegue(withIdentifier: "showProtected", sender: self)
                            
                            
                            
                        }else{
                            //error message in case of invalid credential
                            self.labelMessage.text = "Invalid username or password"
                        }
                    }
                    
            }
        }else{
            self.labelMessage.text = "Introduce tu nombre de usuario y password"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        //if user is already logged in switching to profile screen
        self.labelMessage.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

