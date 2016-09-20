//
//  SharingManager.swift
//  Sharing is Caring
//
//  Created by Jure Zove on 22/04/15.
//  Copyright (c) 2015 Candy Code. All rights reserved.
//

class SharingManager {

    var eventName: String = ""
    var eventVenue: String = ""
    var eventTime: String = ""
    var eventDate: String = ""
    
    var eventEntryCondition: String = ""
    var eventDescription: String = ""
    
    var eventDay: String = ""
//    var eventImage: UIImage = UIImage(named: "")!
    
    var ticketType: String = ""
    var ticketQuantity: String = ""
    var ticketPrice: String = ""
    
    var tableNumber: String = ""
    
    static let sharedInstance = SharingManager()
}
