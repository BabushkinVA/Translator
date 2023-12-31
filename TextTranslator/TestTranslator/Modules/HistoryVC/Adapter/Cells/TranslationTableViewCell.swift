//
//  TranslationTableViewCell.swift
//  TestTranslator
//
//  Created by Vadim on 24.08.23.
//

import UIKit

final class TranslationTableViewCell: UITableViewCell {
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }()
    
    @IBOutlet private weak var sourceLanguageLabel: UILabel!
    @IBOutlet private weak var sourceTextView: UITextView!
    @IBOutlet private weak var targetLanguageLabel: UILabel!
    @IBOutlet private weak var targetTextView: UITextView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func setup(model: TranslationMO) {
        sourceLanguageLabel.text = model.sourceLanguage?.name
        sourceTextView.text = model.sourceText
        targetLanguageLabel.text = model.targetLanguage?.name
        targetTextView.text = model.translatedText
        dateLabel.text = Self.dateFormatter.string(from: Date(timeIntervalSince1970: model.date))
        
    }
    
}
