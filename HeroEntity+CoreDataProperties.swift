//
//  HeroEntity+CoreDataProperties.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 13/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//
//

import Foundation
import CoreData


extension HeroEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroEntity> {
        return NSFetchRequest<HeroEntity>(entityName: "HeroEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var img: String?
    @NSManaged public var icon: String?
    @NSManaged public var primaryAttr: String?
    @NSManaged public var baseHealth: Int32
    @NSManaged public var baseMana: Int32
    @NSManaged public var baseArmor: Int32
    @NSManaged public var moveSpeed: Int32
    @NSManaged public var baseAttackMin: Int32
    @NSManaged public var baseAttackMax: Int32
    @NSManaged public var roles: [String]?

}
