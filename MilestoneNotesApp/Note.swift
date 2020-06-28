//
//  Note.swift
//  MilestoneNotesApp
//
//  Created by Luke Inger on 28/06/2020.
//  Copyright © 2020 Luke Inger. All rights reserved.
//

import UIKit

class Note: NSObject, Codable {

    var Content: String
    var id: String
    
    init(with content: String){
        Content = content
        id = UUID().uuidString
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        Content = aDecoder.decodeObject(forKey: "content") as? String ?? ""
//        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
//    }
//    
//    func encode(with coder: NSCoder) {
//        coder.encode(Content, forKey: "content")
//        coder.encode(id, forKey: "id")
//    }
}
