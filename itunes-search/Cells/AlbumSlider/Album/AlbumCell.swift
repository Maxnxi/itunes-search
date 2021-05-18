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
        //backgroundColor = .blue
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 2
        //titleLabel.backgroundColor = .yellow
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func configure(viewModel: AudioCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
}
