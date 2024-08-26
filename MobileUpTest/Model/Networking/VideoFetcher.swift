//
//  test.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

final class VideoFetcher {
    
    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let endpoint = "video.get"
        static let apiVersion = "5.199"
        static let ownerId = "-128666765"
    }

    enum NetworkError: Error {
        case invalidURL
        case dataFetchFailed
        case dataParsingFailed
    }

    func fetchVideos(forPage page: Int, completion: @escaping (Result<[Video], Error>) -> Void) {
        guard let url = buildURL(forPage: page) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFetchFailed))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                completion(.success(response.response.items))
            } catch {
                completion(.failure(NetworkError.dataParsingFailed))
            }
        }
        
        dataTask.resume()
    }
    
    private func buildURL(forPage page: Int) -> URL? {
        let token = AuthManager.shared.accessToken!
        let offset = page * 20
        let urlString = "\(Constants.baseURL)\(Constants.endpoint)?access_token=\(token)&count=20&owner_id=\(Constants.ownerId)&v=\(Constants.apiVersion)&offset=\(offset)"
        return URL(string: urlString)
    }
}

