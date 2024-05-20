//
//  HomeViewController.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
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
    
    private lazy var order = CryptoCoffeeButton(buttonImage: "mug.fill", 
                                                buttonTitle: "주문하기",
                                                action: UIAction { _ in
        let orderVC = OrderViewController()
        self.navigationController?.pushViewController(orderVC, animated: true)
    })
    
    private lazy var coupon = CryptoCoffeeButton(buttonImage: "mug.fill",
                                            buttonTitle: "쿠폰사용",
                                            action: UIAction { [weak self] _ in
        let qrVC = QRViewController()
        qrVC.loadImage(menu: "쿠폰")
        qrVC.modalPresentationStyle = UIModalPresentationStyle.automatic
        self?.present(qrVC, animated: true, completion: nil)
    })
    
    private func setupLayouts() {
        [logo,
         order,
         coupon].forEach {
            view.addSubview($0)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        order.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.width.equalTo(150)
        }
        
        coupon.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(30)
            $0.leading.equalTo(order.snp.trailing).offset(30)
            $0.height.width.equalTo(150)
        }
    }
}
