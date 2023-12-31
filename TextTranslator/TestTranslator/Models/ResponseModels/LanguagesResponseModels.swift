//
//  LanguagesResponseModels.swift
//  TestTranslator
//
//  Created by Vadim on 21.08.23.
//

import Foundation

struct LanguageResponseModel: Decodable {
    var code: String
    var name: String
}

struct LanguageDataResponseModel: Decodable {
    var languages: [LanguageResponseModel]
}

struct LanguageResponse: Decodable {
    var data: LanguageDataResponseModel
}
