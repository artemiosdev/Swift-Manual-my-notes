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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchElement: UISwitch!
    
    
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
        
        // добавим отображение даты на русском, локализуем
        datePicker.locale = Locale(identifier: "ru_RU")
        
        switchLabel.text = "Скрыть все элементы"
        switchLabel.textColor = UIColor.white
        
        switchElement.isOn = false
        switchElement.onTintColor = UIColor.blue
        switchElement.thumbTintColor = UIColor.red
        
    }
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedContol.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = UIColor.purple
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
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        // явно локализуем формат даты для отображения на русском, может работать автоматически
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormatter.string(from: sender.date)
        label.text = dateValue
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedContol.isHidden = !segmentedContol.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        button.isHidden = !button.isHidden
        datePicker.isHidden = !datePicker.isHidden
        
        if sender.isOn {
            switchLabel.text = "Отображить все элементы"
        } else {
            switchLabel.text = "Скрыть все элементы"
        }
            
    }
}
