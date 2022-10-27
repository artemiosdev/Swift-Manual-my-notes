//
//  WelcomeViewController.swift
//  PassDataProjectArt
//
//  Created by Artem Androsenko on 25.10.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    var login: String?
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let login = self.login else { return }
        welcomeLabel.text = "Welcome \(login)"
    }
    
    @IBAction func goBackTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }

}
