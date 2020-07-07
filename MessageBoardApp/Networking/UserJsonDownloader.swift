//
//  UserJsonDownloader.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation

struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}


class UserJsonDownloader {

    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias UsersCompletionHandler = ([User]?, Error?) -> Void
    typealias PostsCompletionHandler = ([Post]?, Error?) -> Void
    typealias CommentsCompletionHandler = ([Comment]?, Error?) -> Void
    typealias GenCompletionHandler<T:Codable> = ([T]?, Error?) -> ()

    
    func getModelGen<T:Codable>(for type :ApiEndPoint , completionHandler completion: @escaping GenCompletionHandler<T>) {
        
        let request = URLRequest(url: type.url)
        
        let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, error)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                                let users = try self.decoder.decode(Array<T>.self, from: data)
               
                                 completion(users, nil)
                           
                        } catch DecodingError.dataCorrupted(let context) {
                            print(context)
                        } catch DecodingError.keyNotFound(let key, let context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch DecodingError.valueNotFound(let value, let context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch DecodingError.typeMismatch(let type, let context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        }
                        catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            
        }
        
        task.resume()
    }
    
    
    
    
    func getModel(for type :ApiEndPoint , completionHandler completion: @escaping UsersCompletionHandler) {
        
        let request = URLRequest(url: type.url)
        
        let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, error)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            switch type {
                            case .Users:
                                let users = try self.decoder.decode(Array<User>.self, from: data)
               
                                 completion(users, nil)
                            case .Comments:
                                return
                            case .Posts:
                                return
                            }
                            
                        } catch DecodingError.dataCorrupted(let context) {
                            print(context)
                        } catch DecodingError.keyNotFound(let key, let context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch DecodingError.valueNotFound(let value, let context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch DecodingError.typeMismatch(let type, let context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        }
                        catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            
        }
        
        task.resume()
    }
    
    
}
