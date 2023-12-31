//
//  LanguagesVC.swift
//  TestTranslator
//
//  Created by Vadim on 21.08.23.
//

import UIKit

enum LanguageType {
    case source
    case target
    case none
}

protocol LanguagesVCDelegate: AnyObject {
    func didSelect(language: LanguageResponseModel, with type: LanguageType)
}

final class LanguagesVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: LanguagesVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.loadData()
    }
}

extension LanguagesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LanguageTableViewCell.self)", for: indexPath) as! LanguageTableViewCell
        cell.setup(model: viewModel.languages[indexPath.row])
        return cell
    }
}

extension LanguagesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.didSelect(language: viewModel.languages[indexPath.row])
        
        dismiss(animated: true)
    }
}

extension LanguagesVC: LanguagesVCProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
