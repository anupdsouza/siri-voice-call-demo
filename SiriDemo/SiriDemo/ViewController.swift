//
//  ViewController.swift
//  SiriDemo
//
//  Created by Anup DSouza on 03/05/18.
//  Copyright © 2018 Anup DSouza. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        INPreferences.requestSiriAuthorization { (status) in
            
            if status == .authorized {
                print("Siri access allowed")
            } else {
                print("Siri access denied")
            }
        }
        
        DataManager.sharedManager.saveContacts(contacts: [["name": "Thor", "number": "1800-THUNDER"], ["name": "Tony Stark", "number": "1800-IRONMAN"], ["name": "Bruce Banner", "number": "1800-HULKSMASH"], ["name": "Bruce Wayne", "number": "1800-BATMAN"]])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

