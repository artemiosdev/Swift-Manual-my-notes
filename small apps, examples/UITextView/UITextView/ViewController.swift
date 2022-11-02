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
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        textView.delegate = self
        view.backgroundColor = UIColor.systemGreen
        countLabel.text = "0"
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        textView.backgroundColor = UIColor.systemGreen
        
//      или можно вот так, если цвет задали в storyboard
//      textView.backgroundColor = self.view.backgroundColor
        
        textView.layer.cornerRadius = 10
        
        // наблюдатель, будет следить за появлением клавиатуры
        // UIKeyboardWillChangeFrame, и запускать updateTextView
        // UIKeyboardWillChangeFrame - когда клавиатура поменяет свой размер
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        // наблюдатель, будет следить за скрытием клавиатуры UIKeyboardWillHide
        // UIKeyboardWillHide, и запускать updateTextView
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
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
    
}

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
        return textView.text.count + (text.count - range.length) <= 60
    }
}
