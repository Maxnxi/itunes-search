//
//  AlbumSliderCell.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

final class AlbumSliderCell: UITableViewCell {
    private let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var disposeBag = DisposeBag()
    private let height: CGFloat = 180
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 120, height: height)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
        }
            
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(self.height)
           
        }
    }
    
    func configure(viewModel: AlbumSliderViewModel) {       
        Observable.just(viewModel.albums)
            .bind(to: collectionView.rx.items(cellIdentifier: AlbumCell.reuseIdentifier, cellType: AlbumCell.self)) {
                row, data, cell in
                cell.configure(viewModel: data)
            }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(AudioCellViewModel.self)
            .bind(to: viewModel.didSelectAlbumSubject)
            .disposed(by: disposeBag)
    }
}
