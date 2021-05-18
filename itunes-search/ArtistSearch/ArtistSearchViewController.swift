//
//  ArtistSearchViewController.swift
//  itunes-search
//
//  Created by Maksim on 12.05.2021.
//
import UIKit
import Foundation
import RxSwift
import SnapKit
import RxCocoa
import RxDataSources

let pageSize:Int = 20

final class ArtistSearchViewController: UIViewController {
    private let service: SearchServiceProtocol = SearchService()
    private let disposeBag = DisposeBag()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var isLoading: Bool = false // to do capture List
    private var section: SectionModel<String, Artist> = SectionModel(model: "", items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Search"
        view.backgroundColor = .white
        
        setupSearchBar()
        setupTableView()
        loadData()
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Enter name of artist"
        navigationItem.titleView = searchBar
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        let searchTextObservable = searchBar.rx.text.orEmpty.asObservable()
            .throttle(0.5, scheduler: MainScheduler.asyncInstance)
            //DispatchTimeInterval
            .do(onNext: { [unowned self] (_) in
                self.section.items.removeAll()
        })
        
        let willDisplayCellObservable = tableView.rx.willDisplayCell.filter { [tableView, isLoading] (_, indexPath) -> Bool in
            let numberOfRows = tableView.numberOfRows(inSection: 0)
            return (indexPath.row == numberOfRows - 1) && (numberOfRows % pageSize == 0) && !isLoading
        }
        .map { [unowned self] (_) in self.searchBar.text ?? "" }
        
//        searchTextObservable.subscribe (onNext: { (str) in
//            print(str)
//        })
//        .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Artist>>(configureCell: { (model, tableView, indexPath, artist) in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = artist.artistName
            
            return cell
        })
        
        Observable.merge([searchTextObservable, willDisplayCellObservable])
            .do(onNext: { [unowned self] (_) in
                self.isLoading = true
            })
            .flatMapLatest { [service] (searchString) -> Observable<ArtistResponse> in
                //let numberOfRows = tableView.numberOfRows(inSection: 0)
                return service.artistList(searchString: searchString, limit: pageSize, offset: 0)
            }
            .asDriver(onErrorJustReturn: ArtistResponse(resultCount: 0, results: [Artist]()))
            .do(onNext: { [unowned self] (_) in
                self.isLoading = false
            })
            .map{ [unowned self] response in
                self.section.items.append(contentsOf: response.results)
                return [self.section]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
//        (service.artistList(searchString: $0, limit: pageSize, offset: 0))

        tableView.rx.modelSelected(Artist.self).subscribe(onNext: { [unowned self] (artist) in
            self.showArtist(artist)
            })
            .disposed(by: disposeBag)

    }
    
    
    func showArtist(_ artist:Artist) {
        let vc = ArtistDetailViewController()
        let router = ArtistDetailRouter(viewController: vc)
        let viewModel = ArtistDetailViewModel(router: router, artist: artist)
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}
