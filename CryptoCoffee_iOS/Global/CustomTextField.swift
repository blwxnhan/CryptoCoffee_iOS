//
//  CustomTextField.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit

final class CustomTextField: UIView {
    private var descriptionText: String
    private var placeholder: String
    
    init(_ description: String, placeholder: String) {
        self.descriptionText = description
        self.placeholder = placeholder
        super.init(frame: .zero)
        self.setupLayouts()
        self.setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var textfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private func setupStyles() {
        label.text = descriptionText
        textfield.placeholder = placeholder
    }
    
    private func setupLayouts() {
        [label, textfield].forEach {
            addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        textfield.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.leading.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(330)
        }
    }
}

