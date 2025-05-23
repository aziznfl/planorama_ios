//
//  ApiClient.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Alamofire
import Combine
import FirebaseAuth

final class ApiClient {
    static let shared = ApiClient()
    
    private init() {}

    func get<T: Decodable>(
        _ url: String,
        responseType: T.Type,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(.get, url, responseType, parameters: parameters, completion: completion)
    }

    func post<T: Decodable>(
        _ url: String,
        responseType: T.Type,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(.post, url, responseType, parameters: parameters, completion: completion)
    }

    // MARK: - Private
    
    private func request<T: Decodable>(
        _ method: HTTPMethod,
        _ url: String,
        _ responseType: T.Type,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        ensureValidToken { token in
            guard let token = token else {
                completion(.failure(NSError(domain: "auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "No valid token"])))
                return
            }

            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "platform": "ios",
            ]

            AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: responseType) { response in
                completion(response.result.mapError { $0 as Error })
            }
        }
    }
    
    private func ensureValidToken(completion: @escaping (String?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(nil)
            return
        }
        
        user.getIDTokenForcingRefresh(true) { idToken, error in
            if let idToken = idToken, error == nil {
                completion(idToken)
            } else {
                completion(nil)
            }
        }
    }
}
