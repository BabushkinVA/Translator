//
//  LanguageTableViewCell.swift
//  TestTranslator
//
//  Created by Vadim on 21.08.23.
//

import UIKit

final class LanguageTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func setup(model: LanguageResponseModel) {
        codeLabel.text = model.code
        nameLabel.text = model.name
    }
    
}
