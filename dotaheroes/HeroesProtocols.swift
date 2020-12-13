//
//  HeroesProtocols.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 11/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import Foundation

protocol HeroesViewToPresenter {
    func getHeroes(role: String?)
}

protocol HeroesPresenterToView {
    func showError(message: String)
    func heroesLoaded(heroes: [HeroEntity], roles: [String])
}

protocol HeroesPresenterToInteractor {
    func checkInternetConnection() -> Bool
    func heroesListRequest()
}

protocol HeroesInteractorToPresenter {
    func heroesListRequestSuccess(heroes: [Hero])
    func heroesListRequestFail(message: String)
}
