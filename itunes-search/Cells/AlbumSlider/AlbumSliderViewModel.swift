//
//  AlbumSliderViewModel.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import Foundation
import RxSwift

final class AlbumSliderViewModel {
    let albums:[AudioCellViewModel]
    let didSelectAlbumSubject = PublishSubject<AudioCellViewModel>()
    
    init(albums: [AudioCellViewModel]) {
        self.albums = albums
    }
}
