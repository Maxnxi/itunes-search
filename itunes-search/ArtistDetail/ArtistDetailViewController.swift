//
//  ArtistDetailViewController.swift
//  itunes-search
//
//  Created by Maksim on 13.05.2021.
//

import UIKit
import RxSwift
import RxDataSources
import SnapKit

final class ArtistDetailViewController: UIViewController {

    var viewModel: ArtistDetailViewModelProtocol!
    private let tableView = UITableView.init(frame: .zero, style: .grouped)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        setupTableView()
        loadData()
    }
   
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseIdentifier)
        tableView.register(AlbumSliderCell.self, forCellReuseIdentifier: AlbumSliderCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
   
    private func loadData() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, AudioCellType>>(configureCell: { (model, tableView, indexPath, vm) -> UITableViewCell in
            
            switch vm {
            case .albumsSlider (let albumVm):
                let cell = tableView.dequeueReusableCell(withIdentifier: AlbumSliderCell.reuseIdentifier, for: indexPath) as! AlbumSliderCell
                cell.configure(viewModel: albumVm)
                return cell
            case .song(let audioVm):
                let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath) as! SongCell
                cell.configure(viewModel: audioVm)
                return cell
            }
        })
        
        viewModel?.loadSongAndAlbums()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
