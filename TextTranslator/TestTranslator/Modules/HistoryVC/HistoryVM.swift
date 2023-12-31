//
//  HistoryVM.swift
//  TestTranslator
//
//  Created by Vadim on 31.08.23.
//

import UIKit

protocol HistoryVMProtocol {
    func viewDidLoad()
}

protocol HistoryVCProtocol: AnyObject {
    func getTableView() -> UITableView
}

protocol HistoryAdapterProtocol {
    func setup()
    func reloadData()
}

protocol TranslationRepositoryHistoryUseCase {
    func getAll() -> [TranslationMO]
}

final class HistoryVM: HistoryVMProtocol {
    
    private var items: [TranslationMO] = [] {
        didSet { adapter.reloadData() }
    }
    
    private let repository: TranslationRepositoryHistoryUseCase
    
    private let adapter: HistoryAdapterProtocol
    private weak var view: HistoryVCProtocol?
    
    init(
        view: HistoryVCProtocol,
        repository: TranslationRepositoryHistoryUseCase,
        adapter: HistoryAdapterProtocol
    ) {
        self.view = view
        self.repository = repository
        self.adapter = adapter
    }
    
    func viewDidLoad() {
        adapter.setup()
        loadHistory()
    }
    
   private func loadHistory() {
        items = repository.getAll()
    }
    
}

extension HistoryVM: HistoryAdapterDataSource {
    func getTableView() -> UITableView? {
        return view?.getTableView()
    }
    
    func getItems() -> [TranslationMO] {
        return items
    }
}

extension HistoryVM: HistoryAdapterDelegate {
    func didSelect(translation: TranslationMO) {
        print(translation.sourceText ?? "")
    }
}
