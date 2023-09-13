//
//  NetworkingUtils.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case jsonParsingFailed
}

func getJSON<T: Decodable>(fromURL urlString: String, withDecodableType: T.Type) async throws -> T {
    guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
    
    do {
        let data = try await fetchData(fromURL: url.absoluteString, httpMethod: "GET")
        
        if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
           let jsonString = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted),
           let string = String(data: jsonString, encoding: .utf8) {
            debugPrint("Response: ")
            debugPrint(string)
            debugPrint("")
        }
        
        let responseObject = try JSONDecoder().decode(T.self, from: data)
        
        return responseObject
    } catch {
        throw NetworkError.jsonParsingFailed
    }
}

func fetchData(fromURL urlString: String, httpMethod: String) async throws -> Data {
    guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }
        
        return data
    } catch {
        throw NetworkError.requestFailed
    }
}
