//
//  AudioCellViewModel.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import Foundation

enum AudioWrapperType: String {
    case album = "collection"
    case song = "track"
}

final class AudioCellViewModel {
    let title: String?
    let subtitle: String?
    let imageUrl: URL?
    let audio: Audio
    
    init(audio: Audio) {
        self.audio = audio
        imageUrl = URL(string: audio.artworkUrl100 ?? "")
        subtitle = audio.artistName
        switch audio.wrapperType {
        case AudioWrapperType.album.rawValue:
            title = audio.collectionName
        case AudioWrapperType.song.rawValue:
            title = audio.trackName
        default:
            title = nil
        }
    }
}
