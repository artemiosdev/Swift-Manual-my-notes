//
//  ViewController.swift
//  UILabel
//
//  Created by Artem Androsenko on 27.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var actionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        label.font = label.font.withSize(35)
        
        button.isHidden = true
        
        for button in actionButtons {
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.black
        }
        
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        label.isHidden = false
        button.isHidden = false
        
        if sender.titleLabel?.text == "Action 1" {
//        if sender.tag == 0 {
            label.text = "Hello World!"
            label.textColor = .white
        } else if sender.titleLabel?.text == "Action 2" {
//      } else if sender.tag == 1 {
            label.text = "Hello Everyone!"
            label.textColor = .yellow
        } else if sender.titleLabel?.text == "Clear" {
//      } else if sender.tag == 2 {
            label.isHidden = true
            button.isHidden = true
        }
    }
}
