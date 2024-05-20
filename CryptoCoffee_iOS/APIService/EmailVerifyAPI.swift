//
//  EmailVerifyAPI.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/20/24.
//

import Foundation

enum EmailVerifyAPI {
    static let baseURL = "http://52.79.126.94:8082"
    
    case sendEmailCode
    case emailAuth
}

extension EmailVerifyAPI {
    var path: String {
        switch self {
        case .sendEmailCode:
            "/api/email"
        case .emailAuth:
            "/api/email/auth"
        }
    }
    
    var method: String {
        switch self {
        case .sendEmailCode,
            .emailAuth:
            "POST"
        }
    }
    
    var url: URL {
        return URL(string: EmailVerifyAPI.baseURL + path)!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - network 호출함수
    func performRequest(with parameters: Encodable? = nil) async throws {
        /// URLRequest 생성
        var request = self.request
        
        /// 요청에 파라미터 추가
        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
            print(parameters)
        }
        
        /// request URL
        print(request)
        
        /// 네트워크 요청 및 데이터 수신
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.invalidStatus
        }
        
        /// response status 확인
        switch httpResponse.statusCode {
        case 200..<300:
            /// 성공적인 응답 처리
            if case .sendEmailCode = self {
                print("이메일 인증 메일 send")
            }
            
            else if case .emailAuth = self {
                print("이메일 인증 성공")
            }
            
        case 400..<600:
            /// 오류 응답 처리
            let message = String(decoding: data, as: UTF8.self)
            print(message)
            print("Error: \(httpResponse.statusCode)")
            throw FetchError.invalidStatus
            
        default:
            /// 그 외의 상태코드 처리
            throw FetchError.invalidStatus
        }
    }
}
