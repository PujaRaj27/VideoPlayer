//
//  VideoServices.swift
//  DemoVideoPlayer
//
//  Created by PujaRaj on 05/08/24.
//

import Foundation

class VideoService {

    func fetchVideos(completion: @escaping (Result<[VideoSection], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "videos", withExtension: "json") else {
            completion(.failure(VideoServiceError.invalidURL))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
            completion(.success(decodedResponse.reels))
        } catch {
            completion(.failure(VideoServiceError.decodingError(error)))
        }
    }

    enum VideoServiceError: Error {
        case invalidURL
        case decodingError(Error)
    }
}
