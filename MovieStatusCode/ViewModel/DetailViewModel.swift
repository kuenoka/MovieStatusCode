//
//  DetailViewModel.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import Foundation

class DetailViewModel {
  static let shared = DetailViewModel()
  
  private var result: Results? = nil
  private var imageData: Data? = nil
  
  func getImage(completionHandler: @escaping (Data?)->() ) {
    guard let urlString = result?.image_url,
    let url = URL(string: urlString) else { return }
    APIHandler.shared.getData(url: url) { (data, _, _) in
      completionHandler(data)
    }
  }
  
  func setResult(result: Results) {
    self.result = result
  }
  
  func getResult() -> Results? {
    return result
  }
  
  private init() {}
}
