//
//  AudioResponse.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import Foundation

struct AudioResponse: Decodable {
    let resultCount: Int
    let results: [Audio]

}
