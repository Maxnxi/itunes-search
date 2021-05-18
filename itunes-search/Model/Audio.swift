//
//  Audio.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import Foundation

struct Audio: Decodable {
    let wrapperType: String
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let artworkUrl100: String?
}
