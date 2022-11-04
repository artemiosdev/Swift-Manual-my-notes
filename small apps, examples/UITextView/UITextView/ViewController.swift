//
//  ViewController.swift
//  UITextView
//
//  Created by Artem Androsenko on 01.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstrait: NSLayoutConstraint!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // textView.text = ""
        textView.delegate = self
        
        // для примера работы UIActivityIndicatorView
        textView.isHidden = true
        
        // прозрачность текста
        // textView.alpha = 0
        
        view.backgroundColor = UIColor.systemGreen
        countLabel.text = "0"
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        textView.backgroundColor = UIColor.systemGreen
        
        stepper.value = 17
        stepper.maximumValue = 10
        stepper.maximumValue = 25
        stepper.stepValue = 1
        stepper.tintColor = .white
        stepper.backgroundColor = .gray
        // скругление углов у stepper
        stepper.layer.cornerRadius = 5
        
        //      или можно вот так, если цвет задали в storyboard
        //      textView.backgroundColor = self.view.backgroundColor
        
        textView.layer.cornerRadius = 10
        
        // отвечает за ActivityIndicator,
        // когда он закончит свою анимацию действия, то исчезнет
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.darkGray
        activityIndicator.startAnimating()
        
        //      устарел
        //      UIApplication.shared.beginIgnoringInteractionEvents()
        //      заморозим view, с ним нельзя взаимодействовать
        // пока "идет загрузка" данных
        self.view.isUserInteractionEnabled = false
        
        progressView.setProgress(0, animated: true)
        
        // наблюдатель, будет следить за появлением клавиатуры
        // UIKeyboardWillChangeFrame, и запускать updateTextView
        // когда клавиатура поменяет свой размер
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        // наблюдатель, будет следить за скрытием клавиатуры
        // UIKeyboardWillHide, и запускать updateTextView
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        // данный метод прекратит анимацию activityIndicator.startAnimating()
        // которая объявлена выше
        // его можно уже и не использовать, так его он только для activityIndicator
        // и его функционал есть ниже в реализации progressView с Timer
        //        UIView.animate(withDuration: 0, delay: 5, options: .curveEaseIn) {
        //            self.textView.alpha = 1
        //        } completion: { finished in
        //            self.activityIndicator.stopAnimating()
        //            self.textView.isHidden = false
        //            // оживим view для взаимодействия
        //            self.view.isUserInteractionEnabled = true
        //        }
        
        // используем его для индикаторов
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.progressView.progress != 1 {
                self.progressView.progress += 0.2
            } else {
                self.activityIndicator.stopAnimating()
                self.textView.isHidden = false
                // оживим view для взаимодействия
                self.view.isUserInteractionEnabled = true
                self.progressView.isHidden = true
            }
        }
        
    }
    
    // данный метод отслеживаем тапы
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // скрыть клавиатуру для любого вызванного объекта
        // при тапе по view он скроет ранее вызванную клавиатуру
        self.view.endEditing(true)
        
        // позволяет отключить клавиатуру для конкретного вызванного объекта
        textView.resignFirstResponder()
    }
    
    @objc func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: keyboardFrame.height - bottomConstrait.constant,
                                                 right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    @IBAction func sizeFont(_ sender: UIStepper) {
        let font = textView.font?.fontName
        let fontSize = CGFloat(sender.value)
        textView.font = UIFont(name: font!, size: fontSize)
    }
    
}

//MARK: - Set TextView
extension ViewController: UITextViewDelegate {
    // срабатывает при тапе на область textView
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
        textView.textColor = UIColor.gray
    }
    
    // срабатываем при тапе за пределами textView
    // при окончании работы с полем
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.systemGreen
        textView.textColor = UIColor.black
        
    }
    
    // позволяет вводить в textView определенное кол-во символов
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
        return textView.text.count + (text.count - range.length) <= 6000
    }
}
