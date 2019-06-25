//
//  ViewController.swift
//  DesTeenation Signin
//
//  Created by Sachem Library on 6/28/17.
//  Copyright © 2017 Sachem Library. All rights reserved.
//

import UIKit
var teensArray = [Teen]()

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @objc func timeLabel()
    {
        let dateLabel = Date()
        let labelOutput = DateFormatter()
        labelOutput.locale = Locale(identifier:"en_US")
        labelOutput.dateFormat = "h:mm:ss a"
        currentTimeLabel.text = labelOutput.string(from: dateLabel)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.timeLabel), userInfo: nil, repeats: true)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func loginAttempt(_ sender: Any) {
        
        teensArray = Teen.loadTeensFromDefaults()
        
        let date = Date()
        let timeOutput = DateFormatter()
        let dateOutputFormat = DateFormatter()
        let totalDate = DateFormatter()
        dateOutputFormat.locale = Locale(identifier: "en_US")
        timeOutput.locale = Locale(identifier:"en_US")
        dateOutputFormat.dateFormat = "EEEE,MMMM dd"
        timeOutput.dateFormat = "h:mm:ss a"
        totalDate.dateFormat = "EEEE, MMMM dd, YYYY h:mm:ss a"
        let tempFirst = firstName.text
        let tempLast = lastName.text
        //Make sure string isnt empty or whitepaces
        if tempFirst?.replacingOccurrences(of: " ", with: "") != "" && tempLast?.replacingOccurrences(of: " ", with: "") != ""
        {
            let teen = Teen(firstName: firstName.text!, lastName: lastName.text!, signInTime: totalDate.string(from: date))
            teensArray.append(teen)
            firstName.text = ""
            lastName.text = ""
            Teen.saveTeensToDefaults()
            print(teensArray.count)
            
            let alertController = UIAlertController(title: "Successfully Logged in!", message: "Thank you for visiting DesTeenation, "+teen.firstName!+" "+teen.lastName!,preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
            
        }
        else{
            let alertController = UIAlertController(title: "Login Failure!", message: "First Name AND Last Name must be filled out.",preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)

        }
        
        
        
    
        
    }
}

//Date Builder
    extension Date {
        func toTimeString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm:ss a"
            return dateFormatter.string(from: self)
        }


}

