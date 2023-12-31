//
//  TranslateAssembler.swift
//  TestTranslator
//
//  Created by Vadim on 4.09.23.
//

import UIKit

final class TranslateAssembler {
    private init() {}
    
    static func translateVC() -> TranslateVC {
        let vc = TranslateVC.instanceFromStoryboard()
        let vm = TranslateVM(
            view: vc,
            networkService: NetworkService(),
            translationRepository: TranslationRepository()
        )
        vc.viewModel = vm
        return vc
    }
}
