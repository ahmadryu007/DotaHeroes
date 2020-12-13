//
//  HeroesViewController.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 10/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import UIKit
import SDWebImage

class HeroesViewController: UIViewController {
    
    let cellId = "heroesCellId"
    var roles: [String] = []
    var heroes: [HeroEntity] = []
    var presenter: HeroesViewToPresenter?
    var selectedRoles: String?
    
    
    lazy var heroesListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.white
        view.register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "All"
        
        presenter?.getHeroes(role: nil)
        loadingView()
    }
    
    func loadingView(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.startAnimating()
    }
    
    
    func bodyView(){
        activityIndicator.stopAnimating()
        view.addSubview(heroesListView)
        heroesListView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0).isActive = true
        heroesListView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        heroesListView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        heroesListView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        
        filterBarSetup()
    }
    
    func filterBarSetup(){
        let rightNavBar = UIBarButtonItem(title: "Role", style: .plain, target: self, action: #selector(showFilter))
        
        navigationItem.rightBarButtonItem = rightNavBar
    }
    
    @objc func showFilter(){
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 200)
        
        pickerView.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        vc.view.addSubview(pickerView)
        
        let rolesFilterAlert = UIAlertController(title: "Select Role", message: "", preferredStyle: UIAlertController.Style.alert)
        rolesFilterAlert.setValue(vc, forKey: "contentViewController")
        rolesFilterAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        rolesFilterAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            self.presenter?.getHeroes(role: self.selectedRoles)
        }))
        self.present(rolesFilterAlert, animated: true)
    }

}

extension HeroesViewController: HeroesPresenterToView {
    func showError(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func heroesLoaded(heroes: [HeroEntity], roles: [String]) {
        self.heroes = heroes
        self.roles = roles
        
        bodyView()
        heroesListView.reloadData()
    }
}

extension HeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? HeroesCollectionViewCell
        
        cell?.heroName.text = self.heroes[indexPath.row].name
        let imageUrl = URL(string: Constant.baseUrl + (self.heroes[indexPath.row].img ?? ""))!
        
        
        cell?.heroImage.sd_setImage(with: imageUrl, placeholderImage: nil)
        
        return cell ?? HeroesCollectionViewCell()
    }
    
    
}

extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let similarHero: [HeroEntity] = HeroEntity.getSimilar(hero: self.heroes[indexPath.row], from: self.heroes)
        let hero = self.heroes[indexPath.row]
        let detailView = Router.heroDetailRouter(hero: hero, similarHero: similarHero)
        
        self.navigationController?.pushViewController(detailView, animated: true)
        
    }
}

extension HeroesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row != 0){
            self.selectedRoles = roles[row]
        }
        
        self.title = roles[row]
    }
    
}
