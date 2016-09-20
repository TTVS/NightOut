//
//  BookingModel.swift
//  Clubber
//
//  Created by Terra on 13/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

import Foundation

class BookingModel: NSObject {
    
    let offer_id: Int
    let ticket_quantity: Int
    let ticket_price: Int
    let ticket_type: String
    
    
    init(offerID: Int?, ticketQuantity: Int?, ticketPrice: Int?, ticketType: String?)
    {
        self.offer_id = offerID!
        self.ticket_quantity = ticketQuantity!
        self.ticket_price = ticketPrice!
        self.ticket_type = ticketType ?? ""
        
    }
}