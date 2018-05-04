//
//  AppDelegate.swift
//  SiriDemo
//
//  Created by Anup DSouza on 03/05/18.
//  Copyright © 2018 Anup DSouza. All rights reserved.
//

import UIKit
import Intents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        guard let audioCallIntent = userActivity.interaction?.intent as? INStartAudioCallIntent else {
            return false
        }
        
        if let contact = audioCallIntent.contacts?.first {
            
            if let type = contact.personHandle?.type, type == .phoneNumber {
                
                guard let callNumber = contact.personHandle?.value else {
                    return false
                }
                
                let callUrl = URL(string: "tel://\(callNumber)")
                    
                if UIApplication.shared.canOpenURL(callUrl!) {
                    UIApplication.shared.open(callUrl!, options: [:], completionHandler: nil)
                } else {
                    
                    let alertController = UIAlertController(title: nil , message: "Calling not supported", preferredStyle: .alert)
                    let okAlertAction = UIAlertAction(title: "Ok" , style: UIAlertActionStyle.default, handler:nil)
                    alertController.addAction(okAlertAction)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        return true
    }
}

