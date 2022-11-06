//
//  TrackList.swift
//  ArtCover
//
//  Created by Artem Androsenko on 05.11.2022.
//

import UIKit

class TrackList: UITableViewController {
    let imageNameArray = Track.getTrackList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    // возвращает кол-во строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageNameArray.count
    }
    
    // создание ячейки по Identifier и работа с ячейкой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)
        // устаревшие свойства
        // cell.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        // cell.textLabel?.text = imageNameArray[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        let track = imageNameArray[indexPath.row]
        // Configure content.
        content.image = UIImage(named: track.title)
        content.text = track.song
        content.secondaryText = track.artist
        content.textProperties.numberOfLines = 0
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailViewController = segue.destination as! DetailViewController
                let track = imageNameArray[indexPath.row]
                detailViewController.track = track
            }
        }
        
//        или тот же переход, но с guard
//        guard let detailViewController = segue.destination as? DetailViewController else { return }
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        let track = imageNameArray[indexPath.row]
//        detailViewController.track = track
    }
    
}
