//
//  DogModel.swift
//  Segundamano-test
//
//  Created by Jonathan Pabel on 19/02/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import Foundation

class DogModel {
    
    var name:String
    var imageURL:String
    var coverURL:String?
    var arrayURLs:[String]?
    
    init(name:String, imageURL:String, coverURL:String? = nil, arrayURLs:[String]? = nil) {
        self.name = name
        self.imageURL = imageURL
        self.coverURL = coverURL
        self.arrayURLs = arrayURLs
    }
}
