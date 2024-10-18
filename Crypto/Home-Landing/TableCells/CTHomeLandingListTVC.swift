//
//  CTHomeLandingListTVC.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

import UIKit

class CTHomeLandingListTVC: UITableViewCell{
    
    let containerView = UIView()
    let titleLBL: UILabel = UILabel()
    let secondaryTitleLBL = UILabel()
    let coinImageView = UIImageView()
    let newTokenTagImageView = UIImageView()
    
    static let reuseIdentifier = CTHomeLandingListTVC.description()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI(){
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(titleLBL)
        containerView.addSubview(secondaryTitleLBL)
        containerView.addSubview(coinImageView)
        containerView.addSubview(newTokenTagImageView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLBL.translatesAutoresizingMaskIntoConstraints = false
        secondaryTitleLBL.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        newTokenTagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false
        
        
        secondaryTitleLBL.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLBL.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            titleLBL.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            
            secondaryTitleLBL.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            secondaryTitleLBL.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            coinImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            coinImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 40),
            coinImageView.heightAnchor.constraint(equalToConstant: 40),
            
            newTokenTagImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            newTokenTagImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            newTokenTagImageView.widthAnchor.constraint(equalToConstant: 36),
            newTokenTagImageView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configure(with data:CTHomeListingDataModel){
        titleLBL.text = data.name
        secondaryTitleLBL.text = data.symbol
        if data.isActive{
            self.containerView.backgroundColor = UIColor.white
            switch data.type {
            case .coin:
                coinImageView.image = UIImage(named: "crypto-coin-active")
            case .token:
                coinImageView.image = UIImage(named: "crypto-token-active")
            }
        }else{
            coinImageView.image = UIImage(named: "crypto-inactive")
            //Adding a simple inactive indicator for now.
            //TODO: - Add a more intuitive indicator for inactive item
            self.containerView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        }
        if data.isNew{
            newTokenTagImageView.image = UIImage(named: "new-crypto")
        }else{
            newTokenTagImageView.image = nil
        }
    }
    
}
