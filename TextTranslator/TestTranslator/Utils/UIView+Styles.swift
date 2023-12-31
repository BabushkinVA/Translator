//
//  UIView+Styles.swift
//  TestTranslator
//
//  Created by Vadim on 24.08.23.
//

import UIKit

extension UIView {
    
    func setWarningStyle() {
        addBorder(width: 1.0, color: .systemRed)
    }
    
    func setNoBorderStyle() {
        addBorder(width: .zero, color: .clear)
    }
 
    func setDefaultButtonStyle() {
        cornerRadius = 10.0
        addBorder(width: 1.0, color: .systemBlue)
    }
}
