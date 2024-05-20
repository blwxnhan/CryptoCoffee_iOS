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
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .bwGreen
        
        return view
    }()
    
    private let coffeeLabel: UILabel = {
        let label = UILabel()
        label.text = "커피"
        label.font = .systemFont(ofSize: 20, weight: .light)
        
        return label
    }()
    
    private lazy var brudeCoffee = CryptoCoffeeButton(buttonImage: "mug.fill", 
                                                      buttonTitle: "브루드 커피",
                                                      action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        detailVC.setTitle(menu: "브루드 커피")
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private lazy var cafeLatte = CryptoCoffeeButton(buttonImage: "mug.fill", 
                                                    buttonTitle: "카페라떼",
                                                    action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        detailVC.setTitle(menu: "카페라떼")
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private let teaAdeLabel: UILabel = {
        let label = UILabel()
        label.text = "티/에이드"
        label.font = .systemFont(ofSize: 20, weight: .light)
        
        return label
    }()
    
    private lazy var pink = CryptoCoffeeButton(buttonImage: "mug.fill", 
                                               buttonTitle: "핑크 자몽 블랙티",
                                               action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        detailVC.setTitle(menu: "핑크 자몽 블랙티")
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private lazy var honey = CryptoCoffeeButton(buttonImage: "mug.fill", 
                                                buttonTitle: "허니 유자",
                                                action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        detailVC.setTitle(menu: "허니 유자")
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private let nonCoffee: UILabel = {
        let label = UILabel()
        label.text = "논커피"
        label.font = .systemFont(ofSize: 20, weight: .light)
        
        return label
    }()

    
    private func setupLayouts() {
        [logo,
         lineView,
         coffeeLabel,
         brudeCoffee,
         cafeLatte,
         teaAdeLabel,
         pink,
         honey,
         nonCoffee].forEach {
            view.addSubview($0)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(1)
        }
        
        coffeeLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        brudeCoffee.snp.makeConstraints {
            $0.top.equalTo(coffeeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.width.equalTo(150)
        }
        
        cafeLatte.snp.makeConstraints {
            $0.top.equalTo(coffeeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(brudeCoffee.snp.trailing).offset(30)
            $0.height.width.equalTo(150)
        }
        
        teaAdeLabel.snp.makeConstraints {
            $0.top.equalTo(brudeCoffee.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        pink.snp.makeConstraints {
            $0.top.equalTo(teaAdeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(brudeCoffee.snp.leading)
            $0.height.width.equalTo(150)
        }
        
        honey.snp.makeConstraints {
            $0.top.equalTo(teaAdeLabel.snp.bottom).offset(20)
            $0.trailing.equalTo(cafeLatte.snp.trailing)
            $0.height.width.equalTo(150)
        }
        
        nonCoffee.snp.makeConstraints {
            $0.top.equalTo(honey.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
    }
}
