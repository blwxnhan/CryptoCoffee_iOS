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
    
    private var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupLayouts()
        self.hideKeyboardWhenTappedAround()
        self.keyboardLayout()
        
        let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")
        metamaskSDK = MetaMaskSDK.shared(appMetadata, sdkOptions: SDKOptions(infuraAPIKey: ""))
        
        Task {
            let connectResult = await self.metamaskSDK?.connect()
            
            switch connectResult {
            case .success(let data):
                let trimData = data.trimmingCharacters(in: ["[","\"","]"])
                CryptoUserDefaults.shared.account.account = trimData
                CryptoUserDefaults.shared.saveAccountData()

                print(CryptoUserDefaults.shared.account.account)
            case .failure(let error):
                print(error)
            case .none:
                print("none")
            }
        }
    }
    
    private func keyboardLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
            
        self.bottomConstraint = NSLayoutConstraint(item: self.authButton, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.bottomConstraint?.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    // MARK: - 키보드 높이에 따른 Auth button높이 조정을 위한 Notification
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
            self.bottomConstraint?.constant = (-1 * keyboardHeight) - 10
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.bottomConstraint?.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Config UI 
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
    
    private let contentView = UIView()
    
    private lazy var listScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        
        return scrollView
    }()
    
    private lazy var memberNumber = CustomTextField("사원번호",placeholder: "사원번호를 입력해주세요")
    private lazy var nickName = CustomTextField("닉네임", placeholder: "닉네임을 입력해주세요")
    private lazy var email = CustomTextField("이메일", placeholder: "이메일을 입력해주세요")
    private lazy var emailAuth = CustomTextField("이메일 인증", placeholder: "인증번호를 입력해주세요")
    
    private lazy var emailVerifyButton = CustomButton(buttonTitle: "보내기",
                                                      fontSize: 14,
                                                      action: UIAction { _ in
        
        guard let email = self.email.textfield.text else { return }
        let param = EmailVerifyRequestDTO(email: email)
        
        Task {
            do {
                try await EmailVerifyAPI.sendEmailCode.performRequest(with: param)
                print("이메일 보내기 성공")
            } catch {
                print("이메일 보내기 실패")
            }
        }
    })
    
    private lazy var emailAuthButton = CustomButton(buttonTitle: "인증",
                                                    fontSize: 14,
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
    })
    
    private lazy var authButton = CustomButton(buttonTitle: "인증서 발급",
                                               fontSize: 18,
                                               action: UIAction { _ in
        
        let metamask = CryptoUserDefaults.shared
        metamask.loadAccountData()
        guard let email = self.email.textfield.text else { return }
        guard let nickname = self.nickName.textfield.text else { return }
        guard let memberNumber = self.memberNumber.textfield.text else { return }
        
        let param = DIDRequestDTO(account: metamask.account.account, email: email)

        Task {
            do {
//                if !self.email.textfield.state.isEmpty &&
//                    !self.nickName.textfield.state.isEmpty &&
//                    !self.memberNumber.textfield.state.isEmpty {
//                    try await DIDAPI.DIDRequest.performRequest(with: param)
//                    print("DID요청")
//                }
                
                if email != "" &&
                    nickname != "" &&
                    memberNumber != "" {
                    try await DIDAPI.DIDRequest.performRequest(with: param)
                    print("DID요청")
                }
                
                else {
                    let alert = UIAlertController(title: "알림",
                                                         message: "빈칸없이 작성해주세요",
                                                         preferredStyle: UIAlertController.Style.alert)
                    
                    let success = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(success)
                    self.present(alert, animated: true, completion: nil)
                }
                
                let authenticationWaitVC = AuthenticationWaitViewController()
                self.navigationController?.pushViewController(authenticationWaitVC, animated: true)
            } catch {
                print("error: \(error)")
            }
        }
    })
    
    // MARK: - setupLayouts
    private func setupLayouts() {
        [memberNumber,
          nickName,
          email,
          emailVerifyButton,
          emailAuth,
          emailAuthButton].forEach {
            contentView.addSubview($0)
        }
        
        listScrollView.addSubview(contentView)
        
        [logo,
         authLabel,
         listScrollView,
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
        
        listScrollView.snp.makeConstraints {
            $0.top.equalTo(authLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(authButton.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(listScrollView.contentLayoutGuide)
            $0.width.equalTo(listScrollView.frameLayoutGuide)
            $0.height.equalTo(400)
        }
        
        memberNumber.snp.makeConstraints {
            $0.top.equalToSuperview().offset(3)
            $0.leading.equalToSuperview().offset(30)
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
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

