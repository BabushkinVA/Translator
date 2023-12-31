//
//  TranslateVM.swift
//  TestTranslator
//
//  Created by Vadim on 4.09.23.
//

import UIKit

protocol TranslateVMProtocol {
    var targetLanguageName: String? { get }
    var sourceLanguageName: String? { get }
    var translatedText: String? { get }
    
    var languagesDelegate: LanguagesVCDelegate { get }
    
    func tryToTranslate(text: String)
}

protocol TranslateVCProtocol: UIViewController {
    func reloadData()
}

protocol NetworkServiceTranslateUseCase {
    func translate(
        sourceCode: String,
        targetCode: String,
        text: String,
        completion: @escaping (String) -> Void
    )
}

protocol TranslationRepositoryTranslateUseCase {
    func save(
        sourceLanguage: LanguageResponseModel,
        sourceText: String,
        targetLanguage: LanguageResponseModel,
        translatedText: String
    )
}

final class TranslateVM: TranslateVMProtocol {
    var languagesDelegate: LanguagesVCDelegate {
        return self
    }
    
    var targetLanguageName: String? {
        return targetLanguage?.name
    }
    
    var sourceLanguageName: String? {
        return sourceLanguage?.name
    }
    
    var translatedText: String? {
        didSet {
            view?.reloadData()
        }
    }
    
    private var targetLanguage: LanguageResponseModel?
    private var sourceLanguage: LanguageResponseModel?
    
    private weak var view: TranslateVCProtocol?
    
    private var networkService: NetworkServiceTranslateUseCase
    private var translationRepository: TranslationRepositoryTranslateUseCase
    
    init(
        view: TranslateVCProtocol,
        networkService: NetworkServiceTranslateUseCase,
        translationRepository: TranslationRepositoryTranslateUseCase
    ) {
        self.view = view
        self.networkService = networkService
        self.translationRepository = translationRepository
    }
    
    func tryToTranslate(text: String) {
        guard let sourceCode = sourceLanguage?.code
        else {
//            sourceLanguageButton.setWarningStyle()
            return
        }
//        sourceLanguageButton.setDefaultButtonStyle()
        
        guard let targetCode = targetLanguage?.code
        else {
//            targetLanguageButton.setWarningStyle()
            return
        }
//        targetLanguageButton.setDefaultButtonStyle()
        
        networkService.translate(
            sourceCode: sourceCode,
            targetCode: targetCode,
            text: text
        ) { [weak self] translatedText in
            self?.translatedText = translatedText
            self?.saveTranslation(sourceText: text, translatedText: translatedText)
        }
    }
    
    private func saveTranslation(sourceText: String, translatedText: String) {
        guard let sourceLanguage, let targetLanguage
        else { return }
        
        translationRepository.save(
            sourceLanguage: sourceLanguage,
            sourceText: sourceText,
            targetLanguage: targetLanguage,
            translatedText: translatedText
        )
    }
}

extension TranslateVM: LanguagesVCDelegate {
    func didSelect(language: LanguageResponseModel, with type: LanguageType) {
        switch type {
        case .source: sourceLanguage = language
        case .target: targetLanguage = language
        default: break
        }
        view?.reloadData()
    }
}
