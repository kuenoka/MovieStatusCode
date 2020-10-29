//
//  APIHandler.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import Foundation

class APIHandler {
  static let shared = APIHandler()
  var data: Data?
  var response: URLResponse
  var error: Error
  
  func getData(url: URL, completion: (Data, URLResponse, Error) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if 
      completion(data, error, error)
    }.resume()
  }
  
  private init() {}
}
