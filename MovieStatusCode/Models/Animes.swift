//
//  Animes.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import Foundation

struct Animes: Decodable {
  var results: [Results]
}

struct Results: Decodable {
  var title: String
  var synopsis: String
  var image_url: String
}
