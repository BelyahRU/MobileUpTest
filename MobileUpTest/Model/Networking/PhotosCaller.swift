//
//  APICaller.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation


final class PhotosCaller {

    static let shared = PhotosCaller()

    struct NetworkConstants {
        static let owner_id = "-128666765"
        static let album_ids = ["266641437", "0", "263471498", "266310117", "266310086", "269543385", "270745774", "269548231", "266276915"]
        static let basicURL = "https://api.vk.com/method/"
        static let albumPhotosURL = "photos.get?&owner_id=\(owner_id)&album_id="
    }

    enum APIError: Error {
        case failedToGetData
        case failedToDownloadImage
        case failedToParseData
        case invalidURL
    }

    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }

    public func getAllPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        var allPhotos: [Photo] = []
        var encounteredError: Error?
        let dispatchGroup = DispatchGroup()

        for album_id in NetworkConstants.album_ids {
            dispatchGroup.enter()
            getAlbumPhotos(albumId: album_id) { result in
                switch result {
                case .success(var photos):
                    let photosGroup = DispatchGroup()
                    
                    for (index, photo) in photos.enumerated() {
                        photosGroup.enter()
                        self.downloadImageData(from: photo.urlString) { imageDataResult in
                            switch imageDataResult {
                            case .success(let imageData):
                                photos[index].imageData = imageData // Сохраняем данные изображения
                                allPhotos.append(photos[index])
                            case .failure(let error):
                                encounteredError = error
                                print("Failed to download image data for photo \(photo.id): \(error)")
                            }
                            photosGroup.leave()
                        }
                    }
                    
                    photosGroup.notify(queue: .main) {
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    encounteredError = error
                    print("Failed to get photos for album \(album_id): \(error)")
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            if !allPhotos.isEmpty {
                completion(.success(allPhotos))
            } else if let error = encounteredError {
                completion(.failure(error))
            } else {
                completion(.failure(APIError.failedToGetData))
            }
        }
    }

    public func getAlbumPhotos(albumId: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: NetworkConstants.basicURL + NetworkConstants.albumPhotosURL + albumId + "&access_token=\(AuthManager.shared.accessToken ?? "")&v=5.199&count=20") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        print(url)

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.timeoutInterval = 30

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }

            do {
                let albumResponse = try JSONDecoder().decode(AlbumResponse.self, from: data)
                
                let photos: [Photo] = albumResponse.response.items.compactMap { photoModel in
                    return Photo(date: photoModel.date, id: photoModel.id, urlString: photoModel.sizes.filter { $0.type == "x" }.first?.url ?? "", imageData: nil)
                }
                completion(.success(photos))
            } catch {
                completion(.failure(APIError.failedToParseData))
            }
        }

        task.resume()
    }

    private func downloadImageData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToDownloadImage))
                return
            }
            completion(.success(data))
        }

        task.resume()
    }
}
