//
//  PreviewPage.swift
//  ArtCoverCollectionView
//
//  Created by Artem Androsenko on 07.11.2022.
//

import UIKit

private let reuseIdentifier = "ArtCover"
class PreviewPage: UICollectionViewController {
    let imageNameArray = Track.getTrackList()
    override func viewDidLoad() {
        super.viewDidLoad()
        //      настройка размеров ячейки
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 105, height: 105)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNameArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtCoverCell
        let track = imageNameArray[indexPath.row]
        //      Configure content.
        cell.coverImageView.image = UIImage(named: track.title)
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView.indexPath(for: cell)
            let detailViewController = segue.destination as! DetailViewController
            let track = imageNameArray[indexPath!.row]
            detailViewController.track = track
        }
    }
    
}
