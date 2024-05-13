//
//  QRViewController.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit

final class QRViewController: UIViewController {
    var menu: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.setupLayouts()
        
        guard let menu = self.menu else { return }
        loadImage(menu: menu)
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "기기에 QR을 찍어주세요😊:)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private func loadImage(menu: String) {
        let data = "https://quickchart.io/qr?text=\(menu)"
        guard let url = URL(string: data)  else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.qrImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setupLayouts() {
        [label,
         qrImageView].forEach {
            view.addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.bottom.equalTo(qrImageView.snp.top).offset(-20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        qrImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.width.equalTo(300)
        }
    }
}
