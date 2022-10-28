//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Artem Androsenko on 28.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentedContol: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 3
        segmentedContol.insertSegment(withTitle: "Third", at: 2, animated: true)
    }

    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        label.shadowColor = UIColor.white
        switch segmentedContol.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = UIColor.red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = UIColor.black
        case 2:
            label.text = "The third segment is selected"
            label.textColor = UIColor.yellow
        default:
            print("Error")
        }
    }
}

