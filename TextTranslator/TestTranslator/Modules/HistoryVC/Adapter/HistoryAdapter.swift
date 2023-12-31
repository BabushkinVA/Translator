//
//  HistoryAdapter.swift
//  TestTranslator
//
//  Created by Vadim on 14.09.23.
//

import UIKit

protocol HistoryAdapterDataSource: AnyObject {
    func getTableView() -> UITableView?
    func getItems() -> [TranslationMO]
}

protocol HistoryAdapterDelegate: AnyObject {
    func didSelect(translation: TranslationMO)
}

final class HistoryAdapter: NSObject {
    
    private typealias Section = (date: Date, items: [TranslationMO])
    
    private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    weak var dataSource: HistoryAdapterDataSource?
    weak var delegate: HistoryAdapterDelegate?
    
    private var sections: [Section] = []
    
    func setup() {
        tableView = dataSource?.getTableView()
    }
    
    func reloadData() {
        buildData()
        tableView.reloadData()
    }
    
    private func buildData() {
        let items = dataSource?.getItems() ?? []
        
        sections = items
            .map { Date(timeIntervalSince1970: $0.date) }
            .reduce([Date]()) { result, item in
                return result.contains { $0.isSameDay(item) } ? result : result + [item]
            }
            .map { date in
                return Section(date, items.filter {
                    return Date(timeIntervalSince1970: $0.date).isSameDay(date)
                })
            }
        
    }
}

extension HistoryAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TranslationTableViewCell.self)", for: indexPath) as! TranslationTableViewCell
        cell.setup(model: sections[indexPath.section].items[indexPath.row])
        return cell
    }
}

extension HistoryAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didSelect(translation: sections[indexPath.section].items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HistoryHeaderView()
        header.set(date: sections[section].date)
        return header
    }
    
}

extension HistoryAdapter: HistoryAdapterProtocol { }
