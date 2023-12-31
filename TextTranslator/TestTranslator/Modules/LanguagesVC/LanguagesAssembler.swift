//
//  LanguagesAssembler.swift
//  TestTranslator
//
//  Created by Vadim on 31.08.23.
//

import UIKit

final class LanguagesAssembler {
    private init() {}
    
    static func  languagesVC(type: LanguageType, delegate: LanguagesVCDelegate) -> LanguagesVC {
        let vc = LanguagesVC.instanceFromStoryboard(sourceStoryboard: .languages)
        let vm = LanguagesVM(
            view: vc,
            networkService: NetworkService(),
            languageRepository: LanguageRepository(),
            ud: UserDefaults.standard)
        vm.type = type
        vm.delegate = delegate
        
        vc.viewModel = vm
        return vc
    }
}
