//
//  LanguageMO+CoreDataProperties.swift
//  TestTranslator
//
//  Created by Vadim on 21.08.23.
//
//

import Foundation
import CoreData


extension LanguageMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanguageMO> {
        return NSFetchRequest<LanguageMO>(entityName: "LanguageMO")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?

}

extension LanguageMO : Identifiable {

}
