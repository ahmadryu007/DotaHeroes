//
//  HeroesCollectionViewCell.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 10/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import UIKit

class HeroesCollectionViewCell: UICollectionViewCell {
    
    let heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var heroImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(heroImage)
        heroImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        heroImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        heroImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        heroImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        contentView.addSubview(heroName)
        heroName.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 7).isActive = true
        heroName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
