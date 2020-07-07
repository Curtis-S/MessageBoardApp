//
//  EndPoints.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation

enum ApiEndPoint {
    case Users
    case Posts
    case Comments
    
}

extension ApiEndPoint {
    var url:URL {
        switch self {
        case .Users:
            return URL(string: "https://Jsonplaceholder.typicode.com/users")!
        case .Posts:
        return URL(string: "https://Jsonplaceholder.typicode.com/posts")!
        case .Comments:
        return URL(string: "https://Jsonplaceholder.typicode.com/comments")!
        
        }
        
    }
    
}
