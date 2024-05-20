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
    private var metamaskSDK: MetaMaskSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupLayouts()
        
        let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")
        metamaskSDK = MetaMaskSDK.shared(appMetadata, sdkOptions: SDKOptions(infuraAPIKey: ""))
        
        Task {
            let connectResult = await self.metamaskSDK?.connect()
            let result = await metamaskSDK?.getChainId()
            
            switch connectResult {
            case .success(let data):
                MetaMaskAccountManager.shared.account.account = data
            case .failure(let error):
                print(error)
            case .none:
                print("none")
            }
            
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            case .none:
                print("none")
            }
        }
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
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    private lazy var memberNumber = CustomTextField("사원번호",placeholder: "사원번호를 입력해주세요")
    private lazy var nickName = CustomTextField("닉네임", placeholder: "닉네임을 입력해주세요")
    private lazy var email = CustomTextField("이메일", placeholder: "이메일을 입력해주세요")
    private lazy var emailAuth = CustomTextField("이메일 인증", placeholder: "인증번호를 입력해주세요")
    
    private lazy var emailVerifyButton = CustomButton(buttonTitle: "보내기",
                                                      action: UIAction { _ in
        
        guard let email = self.email.textfield.text else { return }
        let param = EmailVerifyRequestDTO(email: email)
        
        Task {
            do {
                try await EmailVerifyAPI.sendEmailCode.performRequest(with: param)
                print("이메일 보내기 성공")
            } catch {
                print(MetaMaskAccountManager.shared.account.account)
                print("이메일 보내기 실패")
            }
        }
    }, fontSize: 14)
    
    private lazy var emailAuthButton = CustomButton(buttonTitle: "인증",
                                                      action: UIAction { _ in
        
        guard let email = self.email.textfield.text else { return }
        guard let emailAuthNumber = self.emailAuth.textfield.text else { return }
        
        let param = EmailAuthRequestDTO(email: email, authNum: emailAuthNumber)
        
        Task {
            do {
                try await EmailVerifyAPI.emailAuth.performRequest(with: param)
                print("이메일 보내기 성공")
            } catch {
                print("이메일 보내기 실패")
            }
        }

    }, fontSize: 14)

    
    private lazy var authButton = CustomButton(buttonTitle: "인증서 발급",
                                               action: UIAction { [weak self] _ in
        /*
        guard let email = self?.email.textfield.text else { return }
        var param = DIDRequestDTO(account: "0x9e56a749eda10be733ff8f13b365daea23572642", email: email)
        print(param)
        
        Task {
            do {
                try await DIDAPI.DIDRequest.performRequest(with: param)
                
                try await Task.sleep(nanoseconds: 4)
                
                if !DIDManager.shared.DIDList.DIDList.isEmpty {
                    let homeVC = HomeViewController()
                    self?.navigationController?.pushViewController(homeVC, animated: true)
                }
            } catch {
                print("error: \(error)")
            }
        }*/
        
        let homeVC = HomeViewController()
        self?.navigationController?.pushViewController(homeVC, animated: true)
    }, fontSize: 18)
    
    // MARK: - setupLayouts
    private func setupLayouts() {
        [logo,
         authLabel,
         memberNumber,
         nickName,
         email,
         emailVerifyButton,
         emailAuth,
         emailAuthButton,
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
            $0.height.equalTo(90)
            $0.width.equalTo(400)
        }
        
        nickName.snp.makeConstraints {
            $0.top.equalTo(memberNumber.snp.bottom)
            $0.leading.equalTo(memberNumber.snp.leading)
            $0.height.equalTo(90)
            $0.width.equalTo(400)
        }
        
        email.snp.makeConstraints {
            $0.top.equalTo(nickName.snp.bottom)
            $0.leading.equalTo(nickName.snp.leading)
            $0.height.equalTo(90)
            $0.width.equalTo(400)
        }
        
        emailVerifyButton.snp.makeConstraints {
            $0.trailing.equalTo(email.snp.trailing).inset(75)
            $0.bottom.equalTo(email.snp.bottom).offset(-15)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        
        emailAuth.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom)
            $0.leading.equalTo(email.snp.leading)
            $0.height.equalTo(90)
            $0.width.equalTo(400)
        }
        
        emailAuthButton.snp.makeConstraints {
            $0.trailing.equalTo(emailAuth.snp.trailing).inset(75)
            $0.bottom.equalTo(emailAuth.snp.bottom).offset(-15)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        
        authButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

