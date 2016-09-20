//
//  MDKMessage.swift
//  Clubber
//
//  Created by Terra on 9/18/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import Foundation
import CoreData

class MDKMessage: NSManagedObject {
    
    var sender: String?
    var photo: NSData?
    var timestamp: NSDate?
    var text: String?
    
}