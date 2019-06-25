//
//  Teen.swift
//  DesTeenation Signin
//
//  Created by Sachem Library on 6/28/17.
//  Copyright © 2017 Sachem Library. All rights reserved.
//

import Foundation
import os.log


class Teen : NSObject,NSCoding

{
    //Declare Values
    var firstName : String?
    var lastName  : String?
    var signInTime : String?
    
    //Init values
    init(firstName: String, lastName: String, signInTime: String){
        self.firstName = firstName
        self.lastName = lastName
        self.signInTime = signInTime
    }
    
    //Decode Data from Defaults
    required init?(coder aDecoder: NSCoder)
    {
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String ?? ""
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        self.signInTime = aDecoder.decodeObject(forKey: "signInTime") as? String ?? ""
    }
    
    //Encode Data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(signInTime,forKey: "signInTime")
    }
    
    //Load encoded data
    class func loadTeensFromDefaults() -> [Teen]
    {
        guard let data = UserDefaults.standard.data(forKey: "teens"),
            let loadedTeensFromDefaults = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [Teen]
            else{
                return []
        }
        return loadedTeensFromDefaults

    }
    
    //Save encoded data
    class func saveTeensToDefaults()
    {
        let userDefaults = UserDefaults.standard
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: teensArray)
        userDefaults.set(encodedData, forKey: "teens")
        userDefaults.synchronize()
    }
    
}
