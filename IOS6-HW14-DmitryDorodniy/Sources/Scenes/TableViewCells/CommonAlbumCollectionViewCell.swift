//
//  CommonAlbumCollectionTableViewCell.swift
//  IOS6-HW14-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 11.06.2022.
//

import UIKit

class CommonAlbumCollectionTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CommonAlbumCollectionTableViewCell"

    let cellsCountInRow: CGFloat = 1
    let collectionInsets: CGFloat = 18 //расстояние между ячейками
    let collectionCellMarginFromPictureToCellBottom: CGFloat = 55

    private lazy var albumCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let album = UICollectionView(frame: .zero, collectionViewLayout: layout)
        album.showsHorizontalScrollIndicator = false
        album.register(CollectionViewCell.self,
                       forCellWithReuseIdentifier: CollectionViewCell.identifier)
        album.dataSource = self
        album.delegate = self
        return album
    }()

    // MARK: - Tabble cell init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(albumCollectionView)

        albumCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Metric.tableCellForPicturesHight/2)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup extentions
extension CommonAlbumCollectionTableViewCell: UICollectionViewDelegate,
                                                UICollectionViewDataSource,
                                                UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cellSecondColletionData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                            for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }

        cell.configure(with: cellSecondColletionData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        print("Selected section \(indexPath.section) and row \(indexPath.row)")
    }

    // MARK: - Setup cell sizes
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = contentView.frame.width / 2
        let cellHeight = cellWidth + collectionCellMarginFromPictureToCellBottom
        let spacing = 3 * collectionInsets / 2
        return CGSize(width: cellWidth - spacing,
                      height: cellHeight - collectionInsets * 2)
    }

    //зазор между линиями
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Metric.minimumLineSpacingForSectionAt
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    //отступы по периметру коллекции
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: collectionInsets,
                            left: collectionInsets + 2,
                            bottom: collectionInsets,
                            right: collectionInsets + 2)
    }
}
