//
//  DetailViewController.swift
//  ArtCover
//
//  Created by Artem Androsenko on 06.11.2022.
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
        artistLabel.text = track?.artist
        songLabel.text = track?.song
    }
}
