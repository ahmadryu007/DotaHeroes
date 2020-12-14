//
//  HeroesPresenter.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 11/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import Foundation
import UIKit

class HeroesPresenter: HeroesInteractorToPresenter {
    
    var interactor: HeroesPresenterToInteractor?
    var view: HeroesPresenterToView?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func heroesListRequestSuccess(heroes: [Hero]) {
        var roles: [String] = ["All"]
        for hero in heroes {
            for role in hero.roles {
                if !roles.contains(role) {
                    roles.append(role)
                }
            }
        }
        
        syncData(heroes)
        view?.heroesLoaded(heroes: fetchHeroes(), roles: roles)
    }
    
    func heroesListRequestFail(message: String) {
        view?.showError(message: message)
    }
}

extension HeroesPresenter: HeroesViewToPresenter {
    func getHeroes(role: String?) {
        
        if let roleValue = role {
            getHeroesDataLocalBy(role: roleValue)
        } else {
            if interactor?.checkInternetConnection() ?? true {
                interactor?.heroesListRequest()
            } else {
                view?.showError(message: "No Internet Connection")
                getHeroesDataLocalBy(role: "All")
            }
        }
    }
    
    func getHeroesDataLocalBy(role: String){
        let heroEntities = fetchHeroes()
        var result: [HeroEntity] = []
        var roles: [String] = ["All"]
        
        for hero in heroEntities {
            if role != "All" {
                if hero.roles?.contains(role) ?? false {
                    result.append(hero)
                }
            } else {
                result.append(hero)
            }
            
            for role in hero.roles ?? [] {
                if !roles.contains(role) {
                    roles.append(role)
                }
            }
        }
        
        view?.heroesLoaded(heroes: result, roles: roles)
    }
}

extension HeroesPresenter {
    func fetchHeroes() -> [HeroEntity]{
        do {
            let heroEntities: [HeroEntity] = try context.fetch(HeroEntity.fetchRequest())
            return heroEntities
        } catch {
            print(error)
            return []
        }
    }
    
    func addHeroes(_ heroes:[Hero]) {
        
        for hero in heroes {
            let heroEntity = HeroEntity(context: self.context)
            heroEntity.name = hero.localizedName
            heroEntity.baseArmor = Int32(exactly: hero.baseArmor ?? 0) ?? 0
            heroEntity.baseAttackMax = Int32(hero.baseAttackMax)
            heroEntity.baseAttackMin = Int32(hero.baseAttackMin)
            heroEntity.baseHealth = Int32(hero.baseHealth)
            heroEntity.baseMana = Int32(hero.baseMana)
            heroEntity.img = hero.img
            heroEntity.icon = hero.icon
            heroEntity.moveSpeed = Int32(hero.moveSpeed)
            heroEntity.primaryAttr = hero.primaryAttr
            heroEntity.roles = hero.roles
            
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
        }
    }
    
    func clearData(){
        do {
            for heroEntity in fetchHeroes() {
                self.context.delete(heroEntity)
            }
            try self.context.save()
        } catch {
            print(error)
        }
    }
    
    func syncData(_ heroes: [Hero]){
        clearData()
        addHeroes(heroes)
    }
}
