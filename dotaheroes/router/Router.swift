//
//  Router.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 10/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import Foundation
import UIKit

class Router {
    class func heroesRouter() -> UIViewController {
        let interctor = HeroesInteractor()
        let presenter = HeroesPresenter()
        let view = HeroesViewController()
        
        interctor.presenter = presenter
        presenter.interactor = interctor
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
    
    class func heroDetailRouter(hero: HeroEntity, similarHero: [HeroEntity]) -> UIViewController {
        let view = HeroDetailViewController()
        view.hero = hero
        view.similarHero = similarHero
        
        return view
    }
}
