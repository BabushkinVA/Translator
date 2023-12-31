//
//  String+Locale.swift
//  TestTranslator
//
//  Created by Vadim on 7.09.23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
