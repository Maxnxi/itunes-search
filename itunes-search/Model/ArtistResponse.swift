//
//  ArtistResponse.swift
//  itunes-search
//
//  Created by Maksim on 12.05.2021.
//

import Foundation

struct ArtistResponse: Decodable {
    let resultCount: Int
    let results: [Artist]

}
