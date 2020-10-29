//
//  APIHandler.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import Foundation

class APIHandler {
  
  static let shared = APIHandler()
  
  func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      completion(data, response, error)
    }.resume()
  }
  
  private init() {}
  
}
