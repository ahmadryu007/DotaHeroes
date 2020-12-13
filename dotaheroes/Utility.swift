//
//  Utility.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 14/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import Foundation

class Utility {
    class func getSimilar(hero: Hero, from: [Hero]) -> [Hero] {
        
        var result: [Hero] = []
        for value in from {
            if (value.primaryAttr == hero.primaryAttr) && (value.id != hero.id) {
                result.append(value)
            }
        }
        
        switch hero.primaryAttr {
        case "agi":
            result = result.sorted { (a, b) -> Bool in
                a.moveSpeed > b.moveSpeed
            }
        case "str":
            result = result.sorted { (a, b) -> Bool in
                a.baseAttackMax > b.baseAttackMax
            }
        case "int":
            result = result.sorted { (a, b) -> Bool in
                a.baseMana > b.baseMana
            }
        default:
            result = from
        }
        
        if result.count > 3 {
            result = Array(result[0...2])
        }
        
        return result
    }
}
