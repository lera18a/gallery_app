//
//  PhotoCell.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    static let reuseId = "PhotoCell"
    private let heartView = UIImageView()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        heartView.image = UIImage(systemName: "heart.fill")
    
        heartView.tintColor = .systemRed
        heartView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heartView)

        NSLayoutConstraint.activate([
            heartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            heartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6)])
    }
    
    func setFavorite(_ isFavorite: Bool) {
        heartView.isHidden = !isFavorite
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        
        heartView.isHidden = true
    }

    func configure(url: URL) {
        imageView.kf.setImage(with: url)
    }
}
