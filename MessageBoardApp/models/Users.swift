//
//  Users.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation



extension User {
    
    func getFormattedDetails() -> [(String,String)] {
        return [("Name ","\(self.name)") ,
            ("Username","\(self.username)"),
            ("Email ", self.email),
            ("Address ","\(self.address.getFullAdress()) "),
            ("Company ",self.company.name)]
    }
}

struct User: Codable {
    let id:Int
    let name:String
    let username: String
    let email: String
    let address:Address
    let company:Company
    var iconAddress:URL {
        let firstName = self.name.split(separator: " ").first
        return URL(string: "https://api.adorable.io/avatars/120/\(firstName ?? "test")@adorable.io.png")!
    }
       
    
}

struct Address: Codable {
    let street:String
    let suite:String
    let city:String
    let zipcode:String
    let geo:GeographicalCoords
    
    func getFullAdress() -> String {
        "\(street) \(suite) \(city) \(zipcode)"
    }
    
}

struct GeographicalCoords: Codable{
    let lat:String
    let lng:String
    
}

struct Company: Codable {
    let name:String
    let catchPhrase:String
    let bs:String
    
}
