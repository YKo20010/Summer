//
//  models.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import Foundation
import UIKit

class Person: NSObject {
    var name: String?
    var email: String?
    var profileImageName: String?
    var username: String?
    
    override init() {
        super.init()
        self.profileImageName = ""
        self.name = ""
        self.email = ""
        self.username = ""
    }
}

class Message: NSObject {
    var text: String?
    var date: Date?
    var person: Person?
}

