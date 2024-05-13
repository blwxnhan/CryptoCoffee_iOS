//
//  DIDAPI.swift
//  CryptoCoffee_iOS
//
//  Created by Bowon Han on 5/13/24.
//

import Foundation

enum DIDAPI {
    static let baseURL = "https://didauthserver.run.goorm.io"
    
    case DIDRequest
}

extension DIDAPI {
    var path: String {
        switch self {
        case .DIDRequest:
            "/didrequest"
        }
    }
    
    var method: String {
        switch self {
        case .DIDRequest:
            "POST"
        }
    }
    
    var url: URL {
        return URL(string: DIDAPI.baseURL + path)!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - network 호출함수
    func performRequest(with parameters: Encodable? = nil) async throws {
        print("request 함수 호출 시점")
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
            if case .DIDRequest = self {
                let result = try JSONDecoder().decode(DIDModel.self, from: data)
                DIDManager.shared.DIDList = result
                print(result)
            } else {
                throw FetchError.invalidStatus
            }
            
        case 400..<600:
            /// 오류 응답 처리
            print("Error: \(httpResponse.statusCode)")
            throw FetchError.invalidStatus
            
        default:
            /// 그 외의 상태코드 처리
            throw FetchError.invalidStatus
        }
    }
}
