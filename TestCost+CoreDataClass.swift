//
//  TestCost+CoreDataClass.swift
//  MyCostsTestWithCoreData
//
//  Created by Анна Тибекина on 22.06.2022.
//
//

import Foundation
import CoreData

@objc(TestCost)
public class TestCost: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entintyForname(entintyName: "TestCost"), insertInto: CoreDataManager.instance.context)
    }
}
