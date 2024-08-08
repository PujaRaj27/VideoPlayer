//
//  MyCell.swift
//  DemoVideoPlayer
//
//  Created by PujaRaj on 03/08/24.
//

import UIKit
import AVFoundation

class MyCell: UICollectionViewCell {
    
    private var player: AVPlayer?
       private var playerLayer: AVPlayerLayer?
    static let identifier = "MyCell"
       private let thumbnailImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()

       private var videoURL: URL?

       // MARK: - Lifecycle
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func prepareForReuse() {
           super.prepareForReuse()
           resetPlayer()
       }

       // MARK: - Methods
       func configure(with video: VideoModel) {
           videoURL = video.video
           print("video.thumbnail==\(video.thumbnail)")
           let image = UIImage(contentsOfFile: "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66953a8501bd082401a3a3c9/1721055877655-7014527174220184-model1.jpg")
           thumbnailImageView.image = image // for hardcode thumbnail
          // thumbnailImageView.loadImage(from: video.thumbnail)// from response
          
       }

       func playVideo() {
           guard let videoURL = videoURL else { return }
           player = AVPlayer(url: videoURL)
           playerLayer = AVPlayerLayer(player: player)
           playerLayer?.videoGravity = .resizeAspectFill
           if let playerLayer = playerLayer {
               layer.insertSublayer(playerLayer, at: 0)
               playerLayer.frame = bounds
           }
           player?.rate = 2.0
           player?.play()

           DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
               self?.resetPlayer()
           }
       }

       private func resetPlayer() {
           player?.pause()
           player = nil
           playerLayer?.removeFromSuperlayer()
       }

       // MARK: - UI Setup
       private func setupUI() {
           contentView.addSubview(thumbnailImageView)

           NSLayoutConstraint.activate([
               thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
               thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

           ])
       }
}


extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
