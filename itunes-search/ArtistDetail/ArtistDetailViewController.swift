//
//  ArtistDetailViewController.swift
//  itunes-search
//
//  Created by Maksim on 13.05.2021.
//

import UIKit

final
class ArtistDetailViewController: UIViewController {

    var viewModel: ArtistDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title

       
    }


}
