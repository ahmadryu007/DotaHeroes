//
//  HeroDetailViewController.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 12/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import UIKit
import SDWebImage

class HeroDetailViewController: UIViewController {

    var hero: HeroEntity?
    var similarHero: [HeroEntity] = []
    
    let heroImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let bodyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let footerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var potraitConstraint = [
        headerContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        bodyContainer.topAnchor.constraint(equalTo: headerContainer.bottomAnchor),
        bodyContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        footerContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
    ]
    
    lazy var landscapeConstraint = [
        headerContainer.widthAnchor.constraint(equalToConstant: 300),
        bodyContainer.topAnchor.constraint(equalTo: headerContainer.topAnchor),
        bodyContainer.widthAnchor.constraint(equalToConstant: 470),
        footerContainer.leadingAnchor.constraint(equalTo: bodyContainer.leadingAnchor)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headerView()
        bodyView()
        footerView()
        
        if (UIDevice.current.orientation == .portrait) || (UIDevice.current.orientation == .portraitUpsideDown) {
            NSLayoutConstraint.activate(potraitConstraint)
        } else {
            NSLayoutConstraint.activate(landscapeConstraint)
        }
    }
    
    func headerView(){
        
        view.addSubview(headerContainer)
        headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerContainer.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        
        let heroImageUrl = URL(string: Constant.baseUrl + (hero?.img ?? ""))!
        heroImageView.sd_setImage(with: heroImageUrl, placeholderImage: nil)
        
        headerContainer.addSubview(heroImageView)
        heroImageView.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 15).isActive = true
        heroImageView.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor).isActive = true
        heroImageView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        heroImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        let heroName = UILabel()
        heroName.translatesAutoresizingMaskIntoConstraints = false
        heroName.text = hero?.name
        heroName.font = .boldSystemFont(ofSize: 20)
        
        headerContainer.addSubview(heroName)
        heroName.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor).isActive = true
        heroName.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 8).isActive = true
        
        let heroIcon = UIImageView()
        let heroIconUrl = URL(string: Constant.baseUrl + (hero?.icon ?? ""))!
        heroIcon.sd_setImage(with: heroIconUrl, placeholderImage: nil)
        heroIcon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(heroIcon)
        heroIcon.centerYAnchor.constraint(equalTo: heroName.centerYAnchor).isActive = true
        heroIcon.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor).isActive = true
        heroIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        heroIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        var roleString = ""
        for role in hero?.roles ?? [] {
            roleString.append(contentsOf: "\(role) ")
        }
        
        let roleLabel = UILabel()
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        roleLabel.numberOfLines = 2
        roleLabel.font = .systemFont(ofSize: 15)
        roleLabel.text = "Role : \n \(roleString)"
        roleLabel.textAlignment = .center
        
        view.addSubview(roleLabel)
        roleLabel.centerXAnchor.constraint(equalTo: heroName.centerXAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: heroName.bottomAnchor, constant: 10).isActive = true
        
        
    }
    
    func bodyView(){
        
        view.addSubview(bodyContainer)
        bodyContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        bodyContainer.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        guard let heroData = self.hero else {return}
        
        let bodyData: [[String: String]] = [
            [
                "icon" : "ic_sword",
                "value" : "\(heroData.baseAttackMin) - \(heroData.baseAttackMax)"
            ],
            [
                "icon" : "ic_plus",
                "value" : "\(heroData.baseHealth)"
            ],
            [
                "icon" : "ic_shield",
                "value" : "\(heroData.baseArmor)"
            ],
            [
                "icon" : "ic_potion",
                "value" : "\(heroData.baseMana)"
            ],
            [
                "icon" : "ic_boots",
                "value" : "\(heroData.moveSpeed)"
            ],
            [
                "icon" : "ic_chains",
                "value" : heroData.primaryAttr ?? ""
            ],
        ]
        
        let leftView = UIStackView()
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.spacing = 10
        leftView.distribution = .fillEqually
        leftView.axis = .vertical
        
        bodyContainer.addSubview(leftView)
        leftView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        leftView.topAnchor.constraint(equalTo: bodyContainer.topAnchor, constant: 10).isActive = true
        leftView.leadingAnchor.constraint(equalTo: bodyContainer.leadingAnchor, constant: 5).isActive = true
        
        let rightView = UIStackView()
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.spacing = 10
        rightView.distribution = .fillEqually
        rightView.axis = .vertical
        
        bodyContainer.addSubview(rightView)
        rightView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        rightView.topAnchor.constraint(equalTo: bodyContainer.topAnchor, constant: 10).isActive = true
        rightView.trailingAnchor.constraint(equalTo: bodyContainer.trailingAnchor, constant: 5).isActive = true
        
        
        
        for data in bodyData.enumerated() {
            
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 15
            view.distribution = .fillEqually
            
            let icon = UIImageView()
            icon.contentMode = .scaleAspectFit
            icon.image = UIImage(named: data.element["icon"]!)
            
            let label = UILabel()
            label.text = data.element["value"]
            label.font = .systemFont(ofSize: 20)
            
            view.addArrangedSubview(icon)
            view.addArrangedSubview(label)
            
            
            if data.offset % 2 == 0 {
                leftView.addArrangedSubview(view)
            } else {
                rightView.addArrangedSubview(view)
            }
        }
        
    }
    
    func footerView(){
        view.addSubview(footerContainer)
        footerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        footerContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        footerContainer.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Similar Heroes:"
        label.font = .boldSystemFont(ofSize: 15)
        
        footerContainer.addSubview(label)
        label.centerYAnchor.constraint(equalTo: footerContainer.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: footerContainer.leadingAnchor, constant: 10).isActive = true
        
        let stackImage = UIStackView()
        stackImage.translatesAutoresizingMaskIntoConstraints = false
        stackImage.spacing = 10
        stackImage.axis = .horizontal
        stackImage.distribution = .fillEqually
        
        footerContainer.addSubview(stackImage)
        stackImage.topAnchor.constraint(equalTo: footerContainer.topAnchor).isActive = true
        stackImage.bottomAnchor.constraint(equalTo: footerContainer.bottomAnchor).isActive = true
        stackImage.trailingAnchor.constraint(equalTo: footerContainer.trailingAnchor, constant: -5).isActive = true
        stackImage.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        for hero in self.similarHero {
            let imageUrl = URL(string: Constant.baseUrl + (hero.img ?? ""))!
            let imageView = UIImageView()
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: imageUrl, placeholderImage: nil)
            
            stackImage.addArrangedSubview(imageView)
        }
        
    }

}

extension HeroDetailViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if size.height > size.width {
            // potrait
            NSLayoutConstraint.deactivate(landscapeConstraint)
            NSLayoutConstraint.activate(potraitConstraint)
        } else {
            // landscape
            NSLayoutConstraint.deactivate(potraitConstraint)
            NSLayoutConstraint.activate(landscapeConstraint)
        }
        
    }
}
