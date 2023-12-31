//
//  LanguagesVM.swift
//  TestTranslator
//
//  Created by Vadim on 31.08.23.
//

import UIKit

protocol LanguagesVMProtocol {
    var languages: [LanguageResponseModel] { get }
    
    func loadData()
    func didSelect(language: LanguageResponseModel)
}

protocol LanguagesVCProtocol: UIViewController {
    func reloadData()
}

protocol NetworkServiceLanguagesUseCase {
    func loadLanguages(completion: @escaping ([LanguageResponseModel]) -> Void)
}

protocol LanguageRepositoryLanguagesUseCase {
    func getLanguages() -> [LanguageResponseModel]
    func save(models: [LanguageResponseModel])
}

protocol UserDefaultsLanguagesUseCase {
    func getLoadTime() -> Double
    func setLoadTime(_ time: Double)
}

final class LanguagesVM: LanguagesVMProtocol {
    private(set) var languages: [LanguageResponseModel] = [] {
        didSet {
            view?.reloadData()
        }
    }
    
    private weak var view: LanguagesVCProtocol?
    
    weak var delegate: LanguagesVCDelegate?
    var type: LanguageType = .none
    
    private let networkService: NetworkServiceLanguagesUseCase
    private let languageRepository: LanguageRepositoryLanguagesUseCase
    private let ud: UserDefaultsLanguagesUseCase
    
    init(
        view: LanguagesVCProtocol,
        networkService: NetworkServiceLanguagesUseCase,
        languageRepository: LanguageRepositoryLanguagesUseCase,
        ud: UserDefaultsLanguagesUseCase
    ) {
        self.view = view
        self.networkService = networkService
        self.languageRepository = languageRepository
        self.ud = ud
    }
    
    func loadData() {
        let loadTime = ud.getLoadTime()
        let nowTime = Date().timeIntervalSince1970
        let cashedLanguages = languageRepository.getLanguages()
        
        if
            nowTime - loadTime < 24 * 3600,
            !cashedLanguages.isEmpty {
            self.languages = cashedLanguages
        } else {
            networkService.loadLanguages { [weak self] languages in
                self?.languages = languages
                self?.languageRepository.save(models: languages)
                self?.ud.setLoadTime(nowTime)
            }
        }
    }
    
    func didSelect(language: LanguageResponseModel) {
        delegate?.didSelect(language: language, with: type)
    }
}
