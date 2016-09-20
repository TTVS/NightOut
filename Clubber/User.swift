//
//  User.swift
//  Clubber
//
//  Created by Terra on 26/6/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var userID: String
    @NSManaged var accessToken: String

}
