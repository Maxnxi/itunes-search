//
//  Artist.swift
//  itunes-search
//
//  Created by Maksim on 12.05.2021.
//

import Foundation

struct Artist: Decodable {
    let wrapperType: String
    let artistName: String
    let artistId: Int
}
