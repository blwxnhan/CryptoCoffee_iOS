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
    
    private let contentView = UIView()
    
    private lazy var listScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        
        return scrollView
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
    
    private lazy var choco = CryptoCoffeeButton(buttonImage: "mug.fill",
                                               buttonTitle: "핫초코",
                                               action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        detailVC.setTitle(menu: "핫초코")
        self.navigationController?.pushViewController(detailVC, animated: true)
    })
    
    private lazy var honeyMilk = CryptoCoffeeButton(buttonImage: "mug.fill",
                                                buttonTitle: "허니밀크티",
                                                action: UIAction { _ in
        let detailVC = OrderDetailViewController()
        detailVC.setTitle(menu: "허니밀크티")
        self.navigationController?.pushViewController(detailVC, animated: true)
    })


    
    private func setupLayouts() {
        [coffeeLabel,
         brudeCoffee,
         cafeLatte,
         teaAdeLabel,
         pink,
         honey,
         nonCoffee,
         choco,
         honeyMilk].forEach {
            contentView.addSubview($0)
        }
        
        listScrollView.addSubview(contentView)
        
        [logo,
         lineView,
         listScrollView].forEach {
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
        
        listScrollView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(1)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(listScrollView.contentLayoutGuide)
            $0.width.equalTo(listScrollView.frameLayoutGuide)
            $0.height.equalTo(800)
        }
        
        coffeeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(30)
        }
        
        brudeCoffee.snp.makeConstraints {
            $0.top.equalTo(coffeeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.height.width.equalTo(150)
        }
        
        cafeLatte.snp.makeConstraints {
            $0.top.equalTo(coffeeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(brudeCoffee.snp.trailing).offset(30)
            $0.height.width.equalTo(150)
        }
        
        teaAdeLabel.snp.makeConstraints {
            $0.top.equalTo(brudeCoffee.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(30)
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
            $0.leading.equalToSuperview().offset(30)
        }
        
        choco.snp.makeConstraints {
            $0.top.equalTo(nonCoffee.snp.bottom).offset(20)
            $0.leading.equalTo(brudeCoffee.snp.leading)
            $0.height.width.equalTo(150)
        }
        
        honeyMilk.snp.makeConstraints {
            $0.top.equalTo(nonCoffee.snp.bottom).offset(20)
            $0.trailing.equalTo(cafeLatte.snp.trailing)
            $0.height.width.equalTo(150)
        }
    }
}
