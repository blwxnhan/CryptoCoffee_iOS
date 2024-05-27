//
//  AuthenticationWaitViewController.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/27/24.
//

import UIKit
import SnapKit

final class AuthenticationWaitViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupLayouts()
    }
    
    // MARK: - Config UI
    private let logo: UILabel = {
        let label = UILabel()
        label.text = "CryptoCoffee"
        label.font = .systemFont(ofSize: 26, weight: .black)
        
        return label
    }()

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "DID 발급 대기중입니다."
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - set up Constraints
    private func setupLayouts() {
        [logo, 
         guideLabel].forEach {
            view.addSubview($0)
        }
         
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

