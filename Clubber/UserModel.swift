//
//  UserModel.swift
//  Clubber
//
//  Created by Terra on 13/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    
    let user_email: String
    let user_password: String
    let user_password_confirmation: String
    let user_first_name: String
    let user_last_name: String
    
    
    // Must be one of: Guest, Manager, Admin, Organizer, VIP
    let user_type: String
    
    
    let user_image: String
    let user_description: String
    let user_location: String
    let user_contact_number: String
    
    
    init(userEmail: String?, userPassword: String?, userPasswordConfirmation: String?, userFirstName: String?, userLastName: String?, userType: String?, userImage: String?, userDescription: String?, userLocation: String?, userContactNumber: String?)
    {
        self.user_email = userEmail ?? ""
        self.user_password = userPassword ?? ""
        self.user_password_confirmation = userPasswordConfirmation ?? ""
        self.user_first_name = userFirstName ?? ""
        self.user_last_name = userLastName ?? ""
        self.user_type = userType ?? ""
        self.user_image = userImage ?? ""
        self.user_description = userDescription ?? ""
        self.user_location = userLocation ?? ""
        self.user_contact_number = userContactNumber ?? ""
    }
}








































