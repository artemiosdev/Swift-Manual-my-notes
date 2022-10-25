//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by Artem Androsenko on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let temperatureCelsius = Int(round(sender.value))
        celsiusLabel.text = "\(temperatureCelsius)ºC"
        let temperatureFahrenheit = Int(round((sender.value * 9 / 5) + 32 ))
        fahrenheitLabel.text = "\(temperatureFahrenheit)ºF"
    }
}

