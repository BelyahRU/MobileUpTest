//
//  VideosViewModel.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation

final class VideoViewModel {
    
    private(set) var videos: [Video] = []
    var onUpdate: (() -> Void)?
    
    private var isLoading = false
    private var currentPage = 0
    private var hasMoreData = true
    
    var isVideosLoaded: Bool {
        return !videos.isEmpty
    }
    
    var videoCount: Int {
        return videos.count
    }
    
    // Обновленный метод для загрузки видео с обработкой ошибок
    func loadVideos(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !isLoading, hasMoreData else { return }
        isLoading = true
        
        VideoFetcher().fetchVideos(forPage: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let newVideos):
                self.videos.append(contentsOf: newVideos)
                self.hasMoreData = newVideos.count > 0
                self.currentPage += 1
                self.onUpdate?()
                completion(.success(()))  // Успешная загрузка
                
            case .failure(let error):
                print("Error fetching videos: \(error)")
                completion(.failure(error))  // Ошибка при загрузке
            }
        }
    }
    
    func video(at indexPath: IndexPath) -> Video {
        return videos[indexPath.row]
    }
}
