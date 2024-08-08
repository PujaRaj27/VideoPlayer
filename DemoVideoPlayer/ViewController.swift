//
//  ViewController.swift
//  DemoVideoPlayer
//
//  Created by PujaRaj on 03/08/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private let viewModel = VideoViewModel()
        var screenSize: CGRect!
        var screenWidth: CGFloat!
        var screenHeight: CGFloat!
    
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0//20
            layout.minimumInteritemSpacing = 0//20
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 200)
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(VideoGridCell.self, forCellWithReuseIdentifier: VideoGridCell.identifier)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setupUI()
          bindViewModel()
          viewModel.fetchVideos()
      }

      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          collectionView.frame = view.bounds
      }

      // MARK: - Methods
      private func bindViewModel() {
          viewModel.onVideosUpdated = { [weak self] in
              DispatchQueue.main.async {
                  self?.collectionView.reloadData()
              }
          }
      }

      // MARK: - UI Setup
      private func setupUI() {
          view.backgroundColor = .white
          collectionView.dataSource = self
          collectionView.delegate = self
          view.addSubview(collectionView)
      }
    
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfVideos(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoGridCell.identifier, for: indexPath) as? VideoGridCell else {
            return UICollectionViewCell()
        }
        
        let videos = viewModel.videoSections[indexPath.section].arr
        cell.configure(with: videos)
        return cell
    }
}




