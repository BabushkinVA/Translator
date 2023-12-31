//
//  UIViewController+Instance.swift
//  TestTranslator
//
//  Created by Vadim on 31.08.23.
//

import UIKit

extension UIViewController {
    
    static func instanceFromStoryboard(sourceStoryboard: UIStoryboard = .main) -> Self {
        return sourceStoryboard.instantiateViewController(withIdentifier: "\(Self.self)")
            as! Self
    }
    
}
