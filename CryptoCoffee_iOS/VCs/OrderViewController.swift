//
//  OrderViewController.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit

final class OrderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.setupLayouts()
    }
    
    private let logo: UILabel = {
        let label = UILabel()
        label.text = "CryptoCoffee"
        label.font = .systemFont(ofSize: 26, weight: .black)
        
        return label
    }()
    
    private lazy var brudeCoffee = CryptoCoffeeButton(buttonImage: "mug.fill", buttonTitle: "브루드 커피", action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private lazy var cafeLatte = CryptoCoffeeButton(buttonImage: "mug.fill", buttonTitle: "카페라떼", action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private lazy var pink = CryptoCoffeeButton(buttonImage: "mug.fill", buttonTitle: "핑크 자몽 블랙티", action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private lazy var honey = CryptoCoffeeButton(buttonImage: "mug.fill", buttonTitle: "허니 유자", action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private func setupLayouts() {
        [logo,
         brudeCoffee,
         cafeLatte,
         pink,
         honey].forEach {
            view.addSubview($0)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        brudeCoffee.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.width.equalTo(150)
        }
        
        cafeLatte.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(30)
            $0.leading.equalTo(brudeCoffee.snp.trailing).offset(30)
            $0.height.width.equalTo(150)
        }
        
        pink.snp.makeConstraints {
            $0.top.equalTo(brudeCoffee.snp.bottom).offset(25)
            $0.leading.equalTo(brudeCoffee.snp.leading)
            $0.height.width.equalTo(150)
        }
        
        honey.snp.makeConstraints {
            $0.top.equalTo(cafeLatte.snp.bottom).offset(25)
            $0.trailing.equalTo(cafeLatte.snp.trailing)
            $0.height.width.equalTo(150)
        }
    }
}
