//
//  HeroEntity+CoreDataClass.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 13/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//
//

import Foundation
import CoreData

@objc(HeroEntity)
public class HeroEntity: NSManagedObject {
    class func getSimilar(hero: HeroEntity, from: [HeroEntity]) -> [HeroEntity] {
        var result: [HeroEntity] = []
        for value in from {
            if (value.primaryAttr == hero.primaryAttr) && (value.name != hero.name) {
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
