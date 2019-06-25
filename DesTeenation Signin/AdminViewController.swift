//
//  AdminViewController.swift
//  DesTeenation Signin
//
//  Created by Sachem Library on 6/28/17.
//  Copyright © 2017 Sachem Library. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AdminViewController : UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let file = "sessionData.csv" //csv file to write to
    
    
    
    override func viewDidLoad()
    {
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

    @IBAction func exportLogins(_ sender: Any)
    {
        
        let path = dir?.appendingPathComponent(file)
        let data = writeSessionDataToString()
        
        //writing
        do {
            try data.write(to: path!, atomically: false, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}

        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["ann.ulrich@sachemlibrary.org","laura.panter@sachemlibrary.org"])
            composeVC.setSubject("Teen Login Data")
            composeVC.setMessageBody("Teen Login CSV.", isHTML: false)
            let fileLocationForLoad = URL(fileURLWithPath: file, relativeTo: dir)
            let fileData =  NSData(contentsOf: fileLocationForLoad)
            composeVC.addAttachmentData(fileData! as Data, mimeType: "csv", fileName: "teenData.csv")
            
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
            
            
            
            
        }
    }
    
    func writeSessionDataToString() -> String{
        //loop to access each teen
        var fileData = ""
        for teen in teensArray{
            fileData += teen.firstName!
            fileData += "   "
            fileData += teen.lastName!
            fileData += "   "
            fileData += teen.signInTime!
            fileData = fileData + "\n"
        }
        
        return fileData
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            break
        case .failed:
            break
            
        @unknown default: break
            
        }
        
        controller.dismiss(animated: true, completion: nil)            }
    
    
    
    //Delete Teen Sign-In Data
    @IBAction func deleteLogins(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete all login data?", message: "Are you sure?",preferredStyle: UIAlertController.Style.alert)
        
        
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            teensArray.removeAll()
            Teen.saveTeensToDefaults()
        }))
        alertController.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            Teen.saveTeensToDefaults()
        }))
        self.present(alertController,animated: true, completion: nil)
    }
    

}
