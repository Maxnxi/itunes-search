//
//  SongCell.swift
//  itunes-search
//
//  Created by Maksim on 18.05.2021.
//

import UIKit
import SnapKit

final class SongCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview().offset(-1)
            make.bottom.equalToSuperview().offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: AudioCellViewModel) {
        titleLabel.text = viewModel.title
    }
}
