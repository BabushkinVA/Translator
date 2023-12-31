//
//  HistoryHeaderView.swift
//  TestTranslator
//
//  Created by Vadim on 14.09.23.
//

import UIKit

final class HistoryHeaderView: UIView {
    
    private static let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter
        }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func set(date: Date) {
        titleLabel.text = Self.dateFormatter.string(from: date)
    }
}
