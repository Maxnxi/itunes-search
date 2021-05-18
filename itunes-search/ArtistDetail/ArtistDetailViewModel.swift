//
//  ArtistDetailViewModel.swift
//  itunes-search
//
//  Created by Maksim on 13.05.2021.
//

import Foundation
import RxSwift
import RxDataSources

enum AudioCellType {
    case albumsSlider(AlbumSliderViewModel)
    case song(AudioCellViewModel)
}

protocol ArtistDetailViewModelProtocol {
    var title: String { get }
    func loadSongAndAlbums() -> Observable<[SectionModel<String, AudioCellType>]>
}

final class ArtistDetailViewModel: ArtistDetailViewModelProtocol {
    private let router: ArtistDetailRouter
    private let service: SearchServiceProtocol
    private let artist: Artist
    private let disposeBag = DisposeBag()
    
    var title: String
    
    init(router: ArtistDetailRouter, artist: Artist, service: SearchServiceProtocol = SearchService()) {
        self.router = router
        self.service = service
        self.artist = artist
        
        self.title = artist.artistName
    }
    
    func loadSongAndAlbums() -> Observable<[SectionModel<String, AudioCellType>]> {
        let songsObservable = service.audioList(type: "song", artistId: artist.artistId, limit: 10, offset: 0).map { (response) -> SectionModel<String, AudioCellType> in
            let songs = response.results.filter { $0.wrapperType == AudioWrapperType.song.rawValue }
            let songViewModels = songs.map { AudioCellType.song(AudioCellViewModel(audio: $0))}
            return SectionModel.init(model: "Songs", items: songViewModels)
        }
        
        let albumsObservable = service.audioList(type: "album", artistId: artist.artistId, limit: 10, offset: 0).map { [unowned self] (response) -> SectionModel<String, AudioCellType> in
            let albums = response.results.filter { $0.wrapperType == AudioWrapperType.album.rawValue }
            let albumsViewModels = albums.map { AudioCellViewModel(audio: $0)}
            let sliderVm = AlbumSliderViewModel.init(albums: albumsViewModels)
            
            sliderVm.didSelectAlbumSubject.asObservable().subscribe(onNext: {(vm) in
                self.router.showAlbum(audio: vm.audio)
                print("\n\n\n", vm.title)
            }).disposed(by: self.disposeBag)
            
            return SectionModel.init(model: "Albums", items: [AudioCellType.albumsSlider(sliderVm)])
            
            
        }
        return Observable.combineLatest([albumsObservable, songsObservable])
    }
    
}
