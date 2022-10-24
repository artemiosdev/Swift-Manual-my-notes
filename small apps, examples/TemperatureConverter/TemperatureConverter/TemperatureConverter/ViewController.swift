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
    
    @IBOutlet weak var cenliusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
    }
}

