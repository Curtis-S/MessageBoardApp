//
//  Posts.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation


struct Post:Codable {
    let userId:Int
    let id:Int
    let title:String
    let body: String
    
}
