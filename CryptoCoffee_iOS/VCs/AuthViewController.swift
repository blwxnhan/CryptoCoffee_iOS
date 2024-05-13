//
//  ViewController.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import UIKit
import SnapKit
import metamask_ios_sdk

final class AuthViewController: UIViewController {
    let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")
//    @ObservedObject var metamaskSDK = MetaMaskSDK.shared(appMetadata)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupLayouts()
//        metamaskSDK.connect()
    }
    
    private let logo: UILabel = {
        let label = UILabel()
        label.text = "CryptoCoffee"
        label.font = .systemFont(ofSize: 26, weight: .black)
        
        return label
    }()
    
    private let authLabel: UILabel = {
        let label = UILabel()
        label.text = "구성원 인증을 하시면 \n하루 한잔, 음료를 \n무료로 제공해드립니다 :)"
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 22, weight: .medium)
        
        return label
    }()
    
    private lazy var memberNumber = CustomTextField("사원번호",placeholder: "사원번호를 입력해주세요")
    private lazy var email = CustomTextField("이메일", placeholder: "이메일을 입력해주세요")
    private lazy var nickname = CustomTextField("닉네임", placeholder: "닉네임을 입력해주세요")
    
    private lazy var emailVerifyButton = CustomButton(buttonTitle: "인증", action: UIAction { _ in })
    
    private lazy var authButton = CustomButton(buttonTitle: "인증서 발급",
                                               action: UIAction { [weak self] _ in
        
//        guard let email = self?.email.textfield.text else { return }
//        var param = DIDRequestDTO(account: "0x9e56a749eda10be733ff8f13b365daea23572642", email: email)
//        print(param)
//        
//        Task {
//            do {
//                try await DIDAPI.DIDRequest.performRequest(with: param)
//                
//                try await Task.sleep(nanoseconds: 4)
                
//                if !DIDManager.shared.DIDList.DIDList.isEmpty {
                    let homeVC = HomeViewController()
                    self?.navigationController?.pushViewController(homeVC, animated: true)
//                }
//            } catch {
//                print("error: \(error)")
//            }
//        }
    })
    
//    private func getChainID() {
//        let chainIdRequest = EthereumRequest(method: .ethChainId)
//        let chainId = await metamaskSDK.request(chainIdRequest)
//    }
    
    // MARK: - setupLayouts
    private func setupLayouts() {
        [logo,
         authLabel,
         memberNumber,
         email,
         emailVerifyButton,
         nickname,
         authButton].forEach {
            view.addSubview($0)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        authLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(30)
            $0.leading.equalTo(logo.snp.leading).offset(20)
        }
        
        memberNumber.snp.makeConstraints {
            $0.top.equalTo(authLabel.snp.bottom).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.equalTo(100)
            $0.width.equalTo(400)
        }
        
        email.snp.makeConstraints {
            $0.top.equalTo(memberNumber.snp.bottom)
            $0.leading.equalTo(memberNumber.snp.leading)
            $0.height.equalTo(100)
            $0.width.equalTo(400)
        }
        
        emailVerifyButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.bottom.equalTo(email.snp.bottom).offset(-20)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        
        nickname.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom)
            $0.leading.equalTo(email.snp.leading)
            $0.height.equalTo(100)
            $0.width.equalTo(400)
        }
        
        authButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}

