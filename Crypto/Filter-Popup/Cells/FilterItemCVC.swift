//
//  FilterItemCVC.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

import UIKit

class FilterItemCVC: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 6
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
