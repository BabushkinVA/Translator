//
//  Date+Calendar.swift
//  TestTranslator
//
//  Created by Vadim on 14.09.23.
//

import Foundation

extension Date {
    func isSameDay(_ anotherDate: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: anotherDate)
    }
}
