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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      label.isHidden = true
        slider.value = 0.5
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 3
        segmentedContol.insertSegment(withTitle: "Third", at: 2, animated: true)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.maximumTrackTintColor = .yellow
        slider.minimumTrackTintColor = .blue
        slider.thumbTintColor = .white
        textField.placeholder = "Enter your name"
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
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
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else { return }
        
        if let _ = Double(textField.text!) {
            let alert = UIAlertController(title: "Name format is wrong", message: "Please, enter your name", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: true, completion: nil)
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    
}

