//
//  LoginViewController.swift
//  PassDataProjectArt
//
//  Created by Artem Androsenko on 25.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func loginTapped(_ sender: UIButton) {
    // choice segue
//        if someValue = true {
            performSegue(withIdentifier: "detailSegue", sender: nil)
//        } else {
//            performSegue(withIdentifier: "anotherSegue", sender: nil)
//        }
    }
    
    @IBAction func unwindSegueToMainScreen(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else { return }
        guard let sourseViewController = segue.source as? WelcomeViewController else { return }
        let resultMessage = sourseViewController.login
        self.resultLabel.text = "Bye \(resultMessage ?? "")"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? WelcomeViewController else { return }
        destinationViewController.login = loginTF.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

