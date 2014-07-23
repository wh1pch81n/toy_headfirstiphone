//
//  PhoneBooth.swift
//  RetroPhoneHunter
//
//  Created by Derrick Ho on 7/13/14.
//  Copyright (c) 2014 Element 84, LLC. All rights reserved.
//

import Foundation
import CoreData

class PhoneBooth: NSManagedObject {

    @NSManaged var city: String
    @NSManaged var imagePath: String
    @NSManaged var lat: NSNumber
    @NSManaged var lon: NSNumber
    @NSManaged var name: String
    @NSManaged var notes: String

}
