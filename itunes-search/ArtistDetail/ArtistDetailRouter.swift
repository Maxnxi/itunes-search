//
//  ArtistDetailRouter.swift
//  itunes-search
//
//  Created by Maksim on 13.05.2021.
//

import UIKit

class BaseRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

final class ArtistDetailRouter: BaseRouter {
    
    
    
    func showSong() {
        
    }
    
    func showAlbum() {
        
    }
}
