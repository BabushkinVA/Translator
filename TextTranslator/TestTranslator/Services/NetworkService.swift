//
//  NetworkService.swift
//  TestTranslator
//
//  Created by Vadim on 21.08.23.
//

import Foundation

final class NetworkService {
    
    private let host = "https://text-translator2.p.rapidapi.com"
    
    private let requiredHeaders: [String: String] = [
            "X-RapidAPI-Key": "a6d6fde1cdmsh897360d74bc73c4p1fe32djsn87d40fd19d43",
            "X-RapidAPI-Host": "text-translator2.p.rapidapi.com"
        ]
    
    func loadLanguages(completion: @escaping ([LanguageResponseModel]) -> Void) {
        
        guard let url = URL(string: host + "/getLanguages")
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = requiredHeaders
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            let responseModel = try? JSONDecoder().decode(LanguageResponse.self, from: jsonData)
            DispatchQueue.main.async {
                completion(responseModel?.data.languages ?? [])
            }
        }.resume()
    }
    
    func translate(sourceCode: String,
                   targetCode: String,
                   text: String,
                   completion: @escaping (String) -> Void) {
        guard let url = URL(string: host + "/translate")
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requiredHeaders
        
        let params = [
                    "source_language": sourceCode,
                    "target_language": targetCode,
                    "text": text
                ]
                request.httpBody = params
                    .map { "\($0)=\($1)&" }
                    .joined()
                    .data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            let responseModel = try? JSONDecoder().decode(TranslateResponse.self, from: jsonData)
            let translatedText = responseModel?.data.translatedText ?? "Error: no translation"
            DispatchQueue.main.async {
                completion(translatedText)
            }
        }.resume()
    }
    
}
