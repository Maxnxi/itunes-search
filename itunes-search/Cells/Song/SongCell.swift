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
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        addSubview(artistLabel)
        artistLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        artistLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: AudioCellViewModel) {
        titleLabel.text = viewModel.title
        artistLabel.text = viewModel.subtitle
    }
}
