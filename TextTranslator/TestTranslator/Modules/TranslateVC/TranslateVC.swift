//
//  TranslateVC.swift
//  TestTranslator
//
//  Created by Vadim on 24.08.23.
//

import UIKit

final class TranslateVC: UIViewController {
    
    @IBOutlet private weak var sourceLanguageButton: UIButton! {
        didSet { sourceLanguageButton.setDefaultButtonStyle() }
    }
    @IBOutlet private weak var sourceTextView: UITextView!
    @IBOutlet private weak var targetLanguageButton: UIButton!{
        didSet { targetLanguageButton.setDefaultButtonStyle() }
    }
    @IBOutlet private weak var targetTextView: UITextView!
    @IBOutlet private weak var translateButton: UIButton! {
        didSet {
            translateButton.setTitle("translate_button".localized, for: .normal)
        }
    }
    
    var viewModel: TranslateVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func openLanguagesVC(with type: LanguageType) {
        let nextVC = LanguagesAssembler.languagesVC(
            type: type,
            delegate: viewModel.languagesDelegate
        )
        present(nextVC, animated: true)
    }
    
    private func checkValidation() -> Bool {
        guard sourceTextView.hasText
       else {
           sourceTextView.setWarningStyle()
           return false
       }
       sourceTextView.setNoBorderStyle()
       
       guard viewModel.sourceLanguageName != nil
       else {
           sourceTextView.setWarningStyle()
           return false
       }
       sourceLanguageButton.setDefaultButtonStyle()
       
       guard viewModel.targetLanguageName != nil
       else {
           targetTextView.setWarningStyle()
           return false
       }
       targetLanguageButton.setDefaultButtonStyle()
        
        return true
    }

    @IBAction private func didSourscButtonTap() {
        openLanguagesVC(with: .source)
    }
    
    @IBAction private func didTargetButtonTap() {
        openLanguagesVC(with: .target)
    }
    
    @IBAction private func didTranslateButtonTap() {
         guard
            checkValidation(),
            let sourceText = sourceTextView.text
        else { return }
        
        viewModel.tryToTranslate(text: sourceText)
    }
    
    @IBAction private func didOpenHistoryTap() {
        let nextVC = HistoryAssembler.historyVC()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension TranslateVC: TranslateVCProtocol {
    func reloadData() {
        targetTextView.text = viewModel.translatedText
        
        if let sourceLanguage = viewModel.sourceLanguageName {
            sourceLanguageButton.setTitle(sourceLanguage, for: .normal)
        } else {
            sourceLanguageButton.setTitle("select_source_language_button".localized, for: .normal)
        }
        
        if let targetLanguage = viewModel.targetLanguageName {
            targetLanguageButton.setTitle(targetLanguage, for: .normal)
        } else {
            targetLanguageButton.setTitle("select_target_language_button".localized, for: .normal)
        }
    }
    
    
}
