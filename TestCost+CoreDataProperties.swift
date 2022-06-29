//
//  TestCost+CoreDataProperties.swift
//  MyCostsTestWithCoreData
//
//  Created by Анна Тибекина on 22.06.2022.
//
//

import Foundation
import CoreData


extension TestCost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestCost> {
        return NSFetchRequest<TestCost>(entityName: "TestCost")
    }

    @NSManaged public var arrayLabel: String?
    @NSManaged public var arrayTextField: String?

}

extension TestCost : Identifiable {

}
