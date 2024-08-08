//
//  VideoGridCell.swift
//  DemoVideoPlayer
//
//  Created by PujaRaj on 05/08/24.
//

import UIKit

class VideoGridCell: UICollectionViewCell {
    
    
    
    // MARK: - Properties
    static let identifier = "VideoGridCell"
    private var videoModels: [VideoModel] = []
    private var videoCells: [MyCell] = []
    private var timer: Timer?
    private var currentVideoIndex = 0

    private let gridLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 150, height: 150)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

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
        stopPlayingVideos()
    }

    // MARK: - Methods
    func configure(with videos: [VideoModel]) {
        videoModels = videos
        collectionView.reloadData()
        startPlayingVideos()
       
    }

    private func startPlayingVideos() {
        currentVideoIndex = 0
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(playNextVideo), userInfo: nil, repeats: true)
        playNextVideo()
    }

    private func stopPlayingVideos() {
        timer?.invalidate()
        timer = nil
        videoCells.forEach { $0.prepareForReuse() }
    }

    @objc private func playNextVideo() {
        guard !videoCells.isEmpty else { return }
        videoCells[currentVideoIndex].prepareForReuse()
        currentVideoIndex = (currentVideoIndex + 1) % videoModels.count
        videoCells[currentVideoIndex].playVideo()
    }

    // MARK: - UI Setup
    private func setupUI() {
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension VideoGridCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identifier, for: indexPath) as? MyCell else {
            return UICollectionViewCell()
        }
        let video = videoModels[indexPath.item]
        cell.configure(with: video)
        videoCells.append(cell)
        return cell
    }
}
