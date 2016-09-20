//
//  EventModel.swift
//  Clubber
//
//  Created by Terra on 12/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

import Foundation

class EventModel: NSObject {
    
    let event_name: String
    let event_description: String
    let event_date: String
    let event_time: String
    let event_day: String
    let event_location: String
    let event_image: String
    let event_entry_conditions: String
    
    init(eventName: String?, eventDescription: String?, eventDate: String?, eventTime: String?, eventDay: String?, eventLocation: String?, eventImage: String?, eventEntryConditions: String?)
    {
        self.event_name = eventName ?? ""
        self.event_description = eventDescription ?? ""
        self.event_date = eventDate ?? ""
        self.event_time = eventTime ?? ""
        self.event_day = eventDay ?? ""
        self.event_location = eventLocation ?? ""
        self.event_image = eventImage ?? ""
        self.event_entry_conditions = eventEntryConditions ?? ""
    }
    
    
//    let appStoreURL: String    
//    override var description: String {
//        return "Name: \(name), URL: \(appStoreURL)\n"
//    }
//    
//    init(name: String?, appStoreURL: String?) {
//        self.name = name ?? ""
//        self.appStoreURL = appStoreURL ?? ""
//    }
}