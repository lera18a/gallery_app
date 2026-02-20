//
//  DetailVewController.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {

    private let viewModel: DetailViewModel

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Photo"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapFavorite() {
        viewModel.toggleFavorite()
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(didTapFavorite)
        )
    
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupUI()
        imageView.kf.indicatorType = .activity
        setupGestures()

        viewModel.onChange = { [weak self] photo in
            self?.render(photo)
        }
        viewModel.start()
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true

        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2

        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 12

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -12),

            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    private func render(_ photo: Photo) {
        imageView.kf.setImage(with: photo.urls.regular, placeholder: UIImage(systemName: "photo"))

        titleLabel.text = photo.altDescription ?? "Untitled"
        descriptionLabel.text = photo.description ?? ""
        
        let isFavorite = viewModel.isCurrentFavorite()
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }

    private func setupGestures() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        left.direction = .left

        let right = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        right.direction = .right

        view.addGestureRecognizer(left)
        view.addGestureRecognizer(right)
    }

    @objc private func didSwipeLeft() {
        viewModel.next()
    }

    @objc private func didSwipeRight() {
        viewModel.previous()
    }

}
