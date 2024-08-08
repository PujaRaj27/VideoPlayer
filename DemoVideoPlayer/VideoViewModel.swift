//
//  VideoViewModel.swift
//  DemoVideoPlayer
//
//  Created by PujaRaj on 05/08/24.
//

import Foundation



class VideoViewModel {

    // MARK: - Properties
    private let videoService: VideoService
    private(set) var videoSections: [VideoSection] = []
    var onVideosUpdated: (() -> Void)?

    // MARK: - Initializer
    init(videoService: VideoService = VideoService()) {
        self.videoService = videoService
    }

    // MARK: - Methods
    func fetchVideos() {
        videoService.fetchVideos { [weak self] result in
            switch result {
            case .success(let sections):
                self?.videoSections = sections
                self?.onVideosUpdated?()
            case .failure(let error):
                print("Error fetching videos: \(error)")
            }
        }
    }

    func numberOfSections() -> Int {
        return videoSections.count
    }

    func numberOfVideos(in section: Int) -> Int {
        return videoSections[section].arr.count
    }

    func video(at indexPath: IndexPath) -> VideoModel {
        return videoSections[indexPath.section].arr[indexPath.item]
    }
}
