//
//  SearchService.swift
//  itunes-search
//
//  Created by Maksim on 12.05.2021.
//
import Moya
import RxSwift
import Foundation

protocol SearchServiceProtocol {
    func artistList(searchString: String, limit: Int, offset: Int) -> Observable<ArtistResponse>
    func audioList(type: String, artistId:Int, limit: Int, offset: Int) -> Observable<AudioResponse>
}

final class SearchService: SearchServiceProtocol {
    private let provider = MoyaProvider<SearchProvider>()
    private let queue = DispatchQueue.init(label: "ru.geekbrains.itunessearch")
    
    func artistList(searchString: String, limit: Int, offset: Int) -> Observable<ArtistResponse> {
        let token: SearchProvider = .artistList(searchString: searchString, limit: limit, offset: offset)
        return provider.rx.request(token, callbackQueue: queue)
            .map(ArtistResponse.self)
            .asObservable()
    }
    
    func audioList(type: String, artistId: Int, limit: Int, offset: Int) -> Observable<AudioResponse> {
        let token: SearchProvider = .audioList(type: type, artistId: artistId, limit: limit, offset: offset)
        return provider.rx.request(token, callbackQueue: queue)
            .map(AudioResponse.self)
            .asObservable()
    }
}
