//
//  UserDefaults+LanguagesUseCase.swift
//  TestTranslator
//
//  Created by Vadim on 31.08.23.
//

import Foundation

extension UserDefaults: UserDefaultsLanguagesUseCase {
    
// 1)   private var kLoadTime: String { "kLastLoadTimeInterval" }  или
    
    private enum Keys {
        static let loadTime = "kLastLoadTimeInterval"
    }
    
    func getLoadTime() -> Double {
        return double(forKey: Keys.loadTime)
    }
    
    func setLoadTime(_ time: Double) {
        setValue(time, forKey: Keys.loadTime)
    }
}
