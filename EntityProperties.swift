//
//  Entity+CoreDataProperties.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/15/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Float

}
