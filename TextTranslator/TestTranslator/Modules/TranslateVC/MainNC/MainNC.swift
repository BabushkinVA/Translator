//
//  MainNC.swift
//  TestTranslator
//
//  Created by Vadim on 4.09.23.
//

import UIKit

final class MainNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers.append(TranslateAssembler.translateVC())
    }
}
