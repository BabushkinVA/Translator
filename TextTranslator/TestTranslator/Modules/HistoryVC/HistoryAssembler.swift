//
//  HistoryAssembler.swift
//  TestTranslator
//
//  Created by Vadim on 31.08.23.
//

import UIKit

final class HistoryAssembler {
    private init() {}
    
    static func historyVC() -> HistoryVC {
        let vc = HistoryVC.instanceFromStoryboard()
        
        let adapter = HistoryAdapter()
        
        let vm = HistoryVM(
            view: vc,
            repository: TranslationRepository(),
            adapter: adapter
        )
        
        adapter.dataSource = vm
        adapter.delegate = vm
        
        vc.viewModel = vm
        return vc
    }
}
