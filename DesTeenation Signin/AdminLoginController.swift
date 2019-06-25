//
//  AdminLoginViewController.swift
//  DesTeenation Signin
//
//  Created by Sachem Library on 6/28/17.
//  Copyright © 2017 Sachem Library. All rights reserved.
//

import Foundation
import UIKit
class AdminLoginController: UIViewController, UITextFieldDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
   
    @IBOutlet weak var adminPassword: UITextField!

    
    @IBAction func adminLogin(_ sender: Any) {
        
        if(adminPassword.text=="Sachem5024")
        {
            self.performSegue(withIdentifier:"adminLoginSuccess",sender: nil)
        }
            
        else{
            let alertController = UIAlertController(title: "Error", message: "Invalid Password.",preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
        }
        
    }
    
    
}
