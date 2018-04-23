//
//  ProfileViewController.swift
//  VwAppPassengers
//
//  Created by Suriel Asael on 18/04/18.
//  Copyright © 2018 Suriel Asael. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController{
    
    
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelUserProfile: UILabel!
    
    @IBAction func buttonLogout(_ sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "nombre"){
            //setting the name to label
            labelUserProfile.text = name
        }else{
            //send back to login view controller
        }
        let foto = defaultValues.string(forKey: "fotografia")
        let URL_IMAGE = URL(string: "http://10.50.115.206:8000/api/get-image-user/"+foto!)
        
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        self.imageProfile.image = image
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

