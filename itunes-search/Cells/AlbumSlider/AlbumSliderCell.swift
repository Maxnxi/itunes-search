//
//  AlbumSliderCell.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import UIKit
import SnapKit
import RxDataSources
import RxSwift

final class AlbumSliderCell: UITableViewCell {
    private let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.backgroundColor = .blue
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
           
        }
    }
    
    func configure(viewModel: AlbumSliderViewModel) {
        Observable.just(viewModel.albums).map { [SectionModel<Void, AudioCellViewModel>.init(model: (), items: $0)]}
            .bind(for:)
    }
}
