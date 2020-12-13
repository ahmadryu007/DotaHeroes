//
//  HeroesInteractor.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 11/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import Foundation
import Alamofire

class HeroesInteractor: HeroesPresenterToInteractor {
    
    var presenter: HeroesInteractorToPresenter?
    
    func checkInternetConnection() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? true
    }
    
    func heroesListRequest() {
        AF.request(Constant.dotaHeroUrl, method: .get, parameters: nil).response {response in
            switch response.result {
            case .success(let data):
                guard let responseData = data else {
                    self.presenter?.heroesListRequestFail(message: "Data nil")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let heroes = try decoder.decode(Heroes.self, from: responseData)
                    self.presenter?.heroesListRequestSuccess(heroes: heroes)
                } catch {
                    self.presenter?.heroesListRequestFail(message: error.localizedDescription)
                }
                
                
            case .failure(let error):
                self.presenter?.heroesListRequestFail(message: error.errorDescription ?? "")
            }
        }
    }
    
}
