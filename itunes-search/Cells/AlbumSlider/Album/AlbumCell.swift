//
//  AlbumCell.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import UIKit
import SnapKit
import SDWebImage

final class AlbumCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .blue
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        addSubview(titleLabel)
        titleLabel.backgroundColor = .yellow
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.greaterThanOrEqualTo(self)
        }
    }
    
    func configure(viewModel: AudioCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
}
