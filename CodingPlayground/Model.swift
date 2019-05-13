//
//  Model.swift
//  CodingPlayground
//
//  Created by Raphael Berendes on 13.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import Foundation

struct Mother: Codable {
    
    let name: String
    let age: Int?
    let children: [Kid]
}

struct Kid: Codable {
    
    let name: String
    let age: Int
    let toys: [Toy]?
}

struct Toy: Codable {
    
    let price: Double
}
