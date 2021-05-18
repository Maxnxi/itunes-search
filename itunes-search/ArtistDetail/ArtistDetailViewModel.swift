//
//  ArtistDetailViewModel.swift
//  itunes-search
//
//  Created by Maksim on 13.05.2021.
//

import Foundation

protocol ArtistDetailViewModelProtocol {
    var title: String { get }
}

final class ArtistDetailViewModel: ArtistDetailViewModelProtocol {
    private let router: ArtistDetailRouter
    private let service: SearchServiceProtocol
    private let artist: Artist
    
    var title: String
    
    init(router: ArtistDetailRouter, artist: Artist, service: SearchServiceProtocol = SearchService()) {
        self.router = router
        self.service = service
        self.artist = artist
        
        self.title = artist.artistName
    }
}
