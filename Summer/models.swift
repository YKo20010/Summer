//
//  models.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Person: NSObject {
    var name: String?
    var email: String?
    var profileImageName: String?
    var username: String?
    var id: String?
    
    override init() {
        super.init()
        self.profileImageName = ""
        self.name = ""
        self.email = ""
        self.username = ""
        self.id = ""
    }
}

class Message: NSObject {
    
    var text: String?
    var timestamp: Double?
    var fromId: String?
    var toId: String?
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}

