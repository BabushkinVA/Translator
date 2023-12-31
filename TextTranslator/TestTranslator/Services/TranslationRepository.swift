//
//  TranslationRepository.swift
//  TestTranslator
//
//  Created by Vadim on 24.08.23.
//

import Foundation
import CoreData

final class TranslationRepository {
    
    private lazy var languageRepository = LanguageRepository()
    
    func save(
        sourceLanguage: LanguageResponseModel,
        sourceText: String,
        targetLanguage: LanguageResponseModel,
        translatedText: String
    ) {
        let context = CoreDataService.shared.context
        context.perform {
            guard
                let sourceLanguage = self.languageRepository.getLanguage(by: sourceLanguage.code),
                let targetLanguage = self.languageRepository.getLanguage(by: targetLanguage.code)
            else { return }
            
            let translation = TranslationMO(context: context)
            translation.sourceText = sourceText
            translation.translatedText = translatedText
            translation.sourceLanguage = sourceLanguage
            translation.targetLanguage = targetLanguage
            translation.date = Date().timeIntervalSince1970
            
            CoreDataService.shared.saveContext()
        }
    }

    func getAll() -> [TranslationMO] {
        let request = TranslationMO.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "\(#keyPath(TranslationMO.date))", ascending: false)
        ]
        return (try? CoreDataService.shared.context.fetch(request)) ?? []
    }
    
}
