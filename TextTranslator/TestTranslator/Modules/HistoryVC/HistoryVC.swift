//
//  HistoryVC.swift
//  TestTranslator
//
//  Created by Vadim on 24.08.23.
//

import UIKit
import CoreData

final class HistoryVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: HistoryVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        title = "history".localized
    }
}

extension HistoryVC: HistoryVCProtocol {
    func getTableView() -> UITableView {
        return tableView
    }
}
