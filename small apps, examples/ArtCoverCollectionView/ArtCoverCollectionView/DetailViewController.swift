//
//  DetailViewController.swift
//  ArtCoverCollectionView
//
//  Created by Artem Androsenko on 10.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    var track: Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: track?.title ?? "Image cover track")
        songLabel.text = track?.song
        artistLabel.text = track?.artist
    }
}
