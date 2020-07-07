//
//  Comments.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation


struct Comment:Codable{
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
