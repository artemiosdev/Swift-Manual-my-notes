//
//  ViewController.swift
//  PassDataProjectArt
//
//  Created by Artem Androsenko on 25.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBAction func loginTapped(_ sender: UIButton) {
//        if someValue = true {
        performSegue(withIdentifier: "detailSegue", sender: nil)
//        } else {
//            performSegue(withIdentifier: "anotherSegue", sender: nil)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destinationViewController = segue.destination as? WelcomeViewController else { return }
        destinationViewController.login = loginTF.text
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

