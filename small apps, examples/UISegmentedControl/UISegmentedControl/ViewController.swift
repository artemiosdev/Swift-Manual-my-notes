//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Artem Androsenko on 28.10.2022.
//

import UIKit

class ViewController: UIViewController {
    // элементы для выбора в PickerView
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker" ]
    var selectedElement: String?
    
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
        
        // для PickerView
        choiceUiElements()
        createToolbar()
    }
    
    func hideAllElements() {
        segmentedContol.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        button.isHidden = true
        datePicker.isHidden = true
    }
    
    func choiceUiElements() {
        let elementPicker = UIPickerView()
        // скрываем клавиатуру при тапе в поле textField
        elementPicker.delegate = self
        textField.inputView = elementPicker
        
        // customization
        elementPicker.backgroundColor = UIColor.brown
    }
    
//    кнопка для выхода из PickerView
    func createToolbar() {
        let toolbar = UIToolbar()
        // встраиваем в наш View под размер
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        // позволяет разместить несколько объектов, в данном случае кнопку Done
        toolbar.setItems([doneButton], animated: true)
        // мы разрешаем пользователю взаимодействовать с этим элементом
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        // customization
        toolbar.tintColor = UIColor.white
        toolbar.barTintColor = UIColor.brown
    }
    
    // скрываем клавиатуру
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // возвращает кол-во барабанов которое будем использовать
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // кол-во доступных элементов из массива для барабана
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    // обображение элементов из массива, по индексу row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    // взаимодействие с выбранным элементом
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmentedContol.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            button.isHidden = false
        case 5:
            hideAllElements()
            datePicker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    // позволяет работать со свойствами label внутри PickerView
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerViewLabel = UILabel()
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = UIColor.white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25)
        pickerViewLabel.text = uiElements[row]
        return pickerViewLabel
    }
    
}
