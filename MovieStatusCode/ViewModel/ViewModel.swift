//
//  ViewModel.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import Foundation

class ViewModel {
  
  static let shared = ViewModel()
  
  private var results: [Results] = []
  
  func getAnimes(urlString: String, completionHandler: @escaping (Result<[Results], NetworkCode>) -> ()) {
    
    guard let url = URL(string: urlString) else { return }
    
    APIHandler.shared.getData(url: url) { (data, response, error) in
      
      guard let httpResponse = response as? HTTPURLResponse else {
        let code = NetworkCode(code: 500)
        completionHandler(.failure(code))
        return
      }
      let code = NetworkCode(code: httpResponse.statusCode)
      
      guard (200...300).contains(httpResponse.statusCode) else {
        completionHandler(.failure(code))
        return
      }
      
      guard let data = data else { return }
      
      do {
        let jsonObj = try JSONDecoder().decode(Animes.self, from: data)
        self.results = jsonObj.results
        completionHandler(.success(jsonObj.results))
      } catch {
        print(error.localizedDescription)
      }
      
    }
    
  }
  
  func numberOfAnime() -> Int {
    return results.count
  }
  
  func getAnime(at index: Int) -> Results {
    return results[index]
  }
  
  private init() {}
}

struct NetworkCode: Error {
  let code: Int
}
