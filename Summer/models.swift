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

class Message: NSObject {
    
    var timestamp: Double?
    var fromId: String?
    var toId: String?
    
    var text: String?
    var imageUrl: String?
    
    var imageHeight: Double?
    var imageWidth: Double?

    init(dictionary: [String: AnyObject]) {
        super.init()
        
        timestamp = dictionary["timestamp"] as? Double
        fromId = dictionary["fromId"] as? String
        toId = dictionary["toId"] as? String
        
        text = dictionary["text"] as? String
        imageUrl = dictionary["imageUrl"] as? String
        
        imageWidth = dictionary["imageWidth"] as? Double
        imageHeight = dictionary["imageHeight"] as? Double
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}

class Person: NSObject {
    var name: String?
    var profileImageName: String?
    var email: String?
    var username: String?
    var id: String?
    
    init(dictionary: [String: AnyObject], id: String) {
        super.init()
        name = dictionary["name"] as? String
        profileImageName = dictionary["profileImageURL"] as? String
        email = dictionary["email"] as? String
        username = dictionary["username"] as? String
        self.id = id
    }
    
    override init() {
        super.init()
        self.profileImageName = ""
        self.name = ""
        self.email = ""
        self.username = ""
        self.id = ""
    }
}


