//
//  CustomButton.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit

final class CustomButton: UIButton {
    private let buttonSetTitle: String
    private var tabButtonAction: UIAction
    
    init(buttonTitle: String, action: UIAction) {
        self.buttonSetTitle = buttonTitle
        self.tabButtonAction = action
        super.init(frame: .zero)
        self.setupStyles()
        self.addAction(tabButtonAction, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup Styles
    private func setupStyles() {
        self.setTitle(buttonSetTitle, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.bwGreen.cgColor
        self.layer.backgroundColor = UIColor.bwGreen.cgColor
    }
}
