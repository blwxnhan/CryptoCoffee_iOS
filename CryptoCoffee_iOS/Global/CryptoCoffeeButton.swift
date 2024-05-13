//
//  CryptoCoffeeButton.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit

final class CryptoCoffeeButton: UIButton {
    private var imageName: String
    private var title: String
    private var action: UIAction
    
    init(buttonImage: String, buttonTitle: String, action: UIAction) {
        self.imageName = buttonImage
        self.title = buttonTitle
        self.action = action
        super.init(frame: .zero)
        self.setupStyles()
        self.addAction(action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyles() {
        var config = UIButton.Configuration.filled()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)

        config.baseBackgroundColor = .bwGreen
        config.baseForegroundColor = .white
        config.image = image
        config.title = title
        config.imagePlacement = .top
        config.imagePadding = 15
        self.configuration = config
    }
}
