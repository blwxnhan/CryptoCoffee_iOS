//
//  OrderDetailViewController.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit

final class OrderDetailViewController: UIViewController {
    private var menu: String?
    
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

    private lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mug.fill")
        imageView.tintColor = .bwGreen
        
        return imageView
    }()
    
    private lazy var menuTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var menuPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.text = "1800원"

        return label
    }()
    
    private lazy var priceDescription: UILabel = {
        let label = UILabel()
        label.text = "1800원"
        
        return label
    }()
        
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var orderButton = CustomButton(buttonTitle: "주문하기",
                                                fontSize: 18,
                                                action: UIAction { _ in
        guard let menu = self.menu else { return }
        guard let token = CryptoUserDefaults.shared.DIDList.did else { return }
        
        let qrVC = QRViewController()
        qrVC.loadImage(menu: menu, token: token)
        qrVC.modalPresentationStyle = UIModalPresentationStyle.automatic
        self.present(qrVC, animated: true, completion: nil)
        
    })
    
    func setTitle(menu: String) {
        self.menu = menu
        menuTitle.text = menu
    }
    
    private func setupLayouts() {
        [logo, 
         menuImageView,
         menuTitle,
         menuPrice,
         lineView,
         orderButton].forEach {
            view.addSubview($0)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        menuImageView.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.width.equalTo(70)
        }
        
        menuTitle.snp.makeConstraints {
            $0.top.equalTo(menuImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(menuImageView)
        }
        
        menuPrice.snp.makeConstraints {
            $0.top.equalTo(menuTitle.snp.bottom).offset(10)
            $0.centerX.equalTo(menuTitle)
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(orderButton.snp.top).offset(-40)
        }
    
        orderButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.height.equalTo(50)
        }
    }
}
