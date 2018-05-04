//
//  IntentHandler.swift
//  SiriExtension
//
//  Created by Anup DSouza on 03/05/18.
//  Copyright © 2018 Anup DSouza. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INStartAudioCallIntentHandling {
    
    func handle(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartAudioCallIntent.self))
        let response = INStartAudioCallIntentResponse(code: .continueInApp, userActivity: userActivity)
        completion(response)
    }
    
    func resolveContacts(for intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        
        var contactName: String?
        
        if let contacts = intent.contacts {
            contactName = contacts.first?.displayName
        }
        
        DataManager.sharedManager.findContact(contactName: contactName, with: { (contacts) in
            
            switch contacts.count {
                
            case 1:
                completion([INPersonResolutionResult.success(with: contacts.first!)])
            case 2 ... Int.max:
                completion([INPersonResolutionResult.disambiguation(with: contacts)])
            default:
                completion([INPersonResolutionResult.unsupported()])
            }
            
        })
    }
    
    func confirm(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartAudioCallIntent.self))
        let response = INStartAudioCallIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }
    
}

