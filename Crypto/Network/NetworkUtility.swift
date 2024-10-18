//
//  NetworkUtility.swift
//  Crypto
//
//  Created by Arun on 16/10/24.
//


import Foundation

class NetworkUtility{
    
    enum RequestType:String{
        case get = "GET"
        case post = "POST"
    }
    
    static func request(ofType requestType:RequestType,url:String,completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned from server"])))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
