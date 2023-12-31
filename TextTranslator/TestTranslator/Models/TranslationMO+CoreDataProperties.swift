//
//  TranslationMO+CoreDataProperties.swift
//  TestTranslator
//
//  Created by Vadim on 24.08.23.
//
//

import Foundation
import CoreData


extension TranslationMO {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TranslationMO> {
        return NSFetchRequest<TranslationMO>(entityName: "TranslationMO")
    }
    
    @NSManaged public var sourceText: String?
    @NSManaged public var translatedText: String?
    @NSManaged public var date: Double
    @NSManaged public var sourceLanguage: LanguageMO?
    @NSManaged public var targetLanguage: LanguageMO?
    
}

extension TranslationMO : Identifiable {
    
}
