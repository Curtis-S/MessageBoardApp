//
//  UserJsonDownloader.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation


class UserJsonDownloader {

    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
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
    
    
    
}
