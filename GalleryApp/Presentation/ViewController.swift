//
//  ViewController.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 30.01.26.
//
import UIKit

final class ViewController: UIViewController {
    private let viewModel: ViewModel
    private var items: [Photo] = []
    private let favorites: FavoriteProtocol = Favorites()

    private lazy var collectionView: UICollectionView = {
        // gridView
        let layout = UICollectionViewFlowLayout()
        // padding all - 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let globalCv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        globalCv .backgroundColor = .systemBackground
        globalCv .dataSource = self
        globalCv .delegate = self
        globalCv .register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        return globalCv
    }()

    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Gallery"
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // вызывается каждый раз перед ем как вью станет видимым
    // уже имеет границы но ориентация еще не задана
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        bind()
        viewModel.initial()
    }
    
    func bind() {
        viewModel.onStateChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .loading:
                break
            case .loaded(items: let photos, _):
                self.items = photos
                self.collectionView.reloadData()
            case .error(let message):
                self.showError(message)
            }
        }
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath
       ) as? PhotoCell else {
           return UICollectionViewCell()
       }
        cell.configure(url: items[indexPath.item].urls.small)
        let id = items[indexPath.item].id
        cell.setFavorite(favorites.isFavorite(id: id))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 3
        let spacing: CGFloat = 10
        let inset: CGFloat = spacing * columns
        let totalSpacing = inset + spacing * (columns - 1)
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        viewModel.loadNextPage(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVM = DetailViewModel(photos: items, startIndex: indexPath.item)
        let detailVC = DetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
