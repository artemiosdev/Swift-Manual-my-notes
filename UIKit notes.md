## [UIKit](https://developer.apple.com/documentation/uikit) 

<img alt="image" src="images/UIKit classes.jpg"/>

[Views and controls](https://developer.apple.com/documentation/uikit/views_and_controls) 

Верстка кодом. Элементы функционала

---

### [#UIButton](https://developer.apple.com/documentation/uikit/uibutton)

`#Tint color` – цвет оттенка кнопки

`#IBOutlet` – кастомизация, обращение к свойствам элемента (к примеру кнопки, label и тп)

`#IBAction` – будет выполнять все действия связанные с элементом  

```swift
override func viewDidLoad() {

// скрываем - true, показываем - false
button.isHidden = true

// текст кнопки
button.setTitle("Clear", for: .normal)

// цвет текста
button.setTitleColor(UIColor.white, for: .normal)

// фон
button.backgroundColor = UIColor.red

}
```

---

### [#UILabel](https://developer.apple.com/documentation/uikit/uilabel)

```swift
override func viewDidLoad() {
// скрываем - true, показываем - false
label.isHidden = true

// шрифт
label.font = label.font.withSize(35)

// текст
label.text = "Hello World!"

// цвет текста
label.textColor = .white

// значение свойства currentTitle для кнопки
if sender.titleLabel?.text == "Action 1" { }

// тегирование элементов
if sender.tag == 0 { }

// тень
label.shadowColor = UIColor.white

// выравнивание центр, слева, справа
label.textAlignment = .center

// количество строк в label
label.numberOfLines = 3

}
```

---

### [#UISegmentedControl](https://developer.apple.com/documentation/uikit/uisegmentedcontrol)
`#UISegmentedControl`  - the segments can represent single or multiple selection, or a list of commands. Each segment can display text or an image, but not both.

Добавить кодом segment, можно просто заголовок и текст; можно и с image, `at` это порядковый индекс элемента 

```swift
override func viewDidLoad() {

segmentedContol.insertSegment(withTitle: "Third", at: 2, animated: true)
// or
segmentedContol.insertSegment(with: UIImage?, at: Int, animated: <Bool)

}
```

---

### [#UISlider](https://developer.apple.com/documentation/uikit/uislider)

```swift
override func viewDidLoad() {

// значение
slider.value = 0.5
slider.minimumValue = 0
slider.maximumValue = 1

// цвет
slider.maximumTrackTintColor = .yellow
slider.minimumTrackTintColor = .blue
slider.thumbTintColor = .white

}
```

---

### [#UITextField ]( https://developer.apple.com/documentation/uikit/uitextfield) 
Есть делегат  [#UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate) с помощью которого можно отслеживать взаимодействия пользователя с текстовым полем в реальном времени (начал ввод, закончил, и тп)

```swift
textField.placeholder = "Enter your name"
```

---

### [#UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller/) 
an object that displays an alert message.
`let alert` – создаем само предупреждение

### [#UIAlertAction](https://developer.apple.com/documentation/uikit/uialertaction )
action that can be taken when the user taps a button in an alert.
`let alertButton` – создаем кнопку в предупреждении (возможна функциональность при ее нажатии, замыкания, несколько кнопок и тп)

Метод [#present()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present) вызывает на экран наше предупреждение #alert. 
При вводе числового формата в поле ввода имени будет предупреждение

[Пример использования](https://github.com/artemiosdev/Swift-Manual-my-notes/blob/main/small%20apps%2C%20examples/UISegmentedControl/UISegmentedControl/ViewController.swift)

```swift
    @IBAction func donePressed(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else { return }
        
        if let _ = Double(textField.text!) {
            let alert = UIAlertController(title: "Name format is wrong", message: "Please, enter your name", 
            preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: true, completion: nil)
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
```

---

### [#UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)
View, которое позволяет прокручивать и масштабировать содержащиеся в нем view. Вид прокрутки отслеживает движения пальцев и соответствующим образом корректирует начало координат. Задаем размер view.

В самом контейнере UIScrollView можно размещать элементы, если мы знаем что нам нужна будет прокрутка. Или можно добавить UIScrollView на уже существующие элементы `editor -> embed in -> scroll view`

Все констрейты которые ранее были связаны с View (обычный) теперь не работают, так как элементы поместили  в UIScrollView. Привяжем UIScrollView к View, и все констрейты элементов к UIScrollView. Xcode может сам добавить пропущенные констрейты (кнопка треугольник нижняя панель, `resolve auto layout issues - add missing constraints`)

---

### [#UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
#Барабан выбора, даты, времени.

[#DateFormatter()](https://developer.apple.com/documentation/foundation/dateformatter/) - форматирование, которое преобразует даты в их текстовые представления. Так как у даты изначально значение вовсе не String. Поэтому нужен отдельный метод для преобразования в String, для вывода в label.

```swift
override func viewDidLoad() {
// добавим отображение даты на русском, локализуем
datePicker.locale = Locale(identifier: "ru_RU")

}

    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        // явно локализуем формат даты для отображения в label на русском, может уже работать автоматически
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormatter.string(from: sender.date)
        label.text = dateValue
    }
```

---

### [#UISwitch](https://developer.apple.com/documentation/uikit/uiswitch)

```swift
override func viewDidLoad() {
switchElement.isOn = false
switchElement.onTintColor = UIColor.blue
switchElement.thumbTintColor = UIColor.red

}
```

Пример использования switch для скрытия/отображения элементов на экране

```swift
    @IBAction func switchAction(_ sender: UISwitch) {
        label.isHidden = !label.isHidden
        textField.isHidden = !textField.isHidden
        if sender.isOn {
            switchLabel.text = "Отображить все элементы"
        } else {
            switchLabel.text = "Скрыть все элементы"
        }     
    }
```

---

### [#UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview)
Вращающийся барабан с возможностью выбора среди элементов, чем то похож на UIDatePicker.

Необходимые протоколы (подпись extension) [#UIPickerViewDelegate](https://developer.apple.com/documentation/uikit/uipickerviewdelegate), и [#UIPickerViewDataSource](https://developer.apple.com/documentation/uikit/uipickerviewdatasource), и обязательные для них методы. 

[Пример использования](https://github.com/artemiosdev/Swift-Manual-my-notes/blob/main/small%20apps%2C%20examples/UISegmentedControl/UISegmentedControl/ViewController.swift) с отдельной кнопкой [#UIToolbar](https://developer.apple.com/documentation/uikit/uitoolbar) и [#UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem)

```swift
class ViewController: UIViewController {

	 // элементы для выбора в PickerView
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker" ]
    var selectedElement: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // для PickerView
        choiceUiElements()
        createToolbar()
    }

    func choiceUiElements() {
		// создаем Picker View
        let elementPicker = UIPickerView()

        // скрываем клавиатуру при тапе в поле textField
        elementPicker.delegate = self
        textField.inputView = elementPicker
        
        // customization
        elementPicker.backgroundColor = UIColor.brown
    }

// можно создать отдельную кнопку для выхода из PickerView
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
        // при тапе в поле textField будет открываться именно toolbar
        textField.inputAccessoryView = toolbar
        
        // customization
        toolbar.tintColor = UIColor.white
        toolbar.barTintColor = UIColor.brown
    }
    
    // скрываем клавиатуру
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
```


```swift
// кастомная настройка PickerView, обязательные методы протоколов
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // возвращает кол-во барабанов которое будем использовать
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // кол-во доступных элементов из массива для барабана
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    // отображение элементов из массива, по индексу row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    // взаимодействие с выбранным элементом
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
     }
     
     // позволяет работать со свойствами label внутри PickerView, и кастомизировать их
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, 
    reusing view: UIView?) -> UIView {
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
```

---

### [#UITextView ](https://developer.apple.com/documentation/uikit/uitextview)

[#UITextViewDelegate](https://developer.apple.com/documentation/uikit/uitextviewdelegate) - протокол включающий в себя методы отслеживания тапов, и не только.

```swift
override func viewDidLoad() {

textView.text = ""
textView.delegate = self
textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
textView.backgroundColor = UIColor.systemGreen

// округлим углы поля
textView.layer.cornerRadius = 10

}
```

Изменим фон textView при редактировании, и просто при просмотре

```swift
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
}
```

```swift
class ViewController: UIViewController {
    // данный метод отслеживаем тапы
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // скрыть клавиатуру для любого вызванного объекта
        // при тапе по view он скроет ранее вызванную клавиатуру
        self.view.endEditing(true)
        
  // позволяет отключить клавиатуру для конкретного вызванного объекта
        textView.resignFirstResponder()
    }
}
```

`#textView.text.count` – количество символов в textView. 
Далее вводим символ (всегда считается по одному введенному символу), и здесь же отнимаем удаленные символы клавишей backspace если конечно удаляли `+ (text.count - range.length)` <= 600 , и здесь лимит на 600 значений


```swift
extension ViewController: UITextViewDelegate {
    // позволяет вводить в textView определенное кол-во символов
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
       return textView.text.count + (text.count - range.length) <= 600
    }
}
```

Можно назначать наблюдателей за поведением textView, чтобы клавиатура не перекрывала textView, "приподнять" поле при появлении клавиатуры, и "опустить" при скрытии клавиатуры. Уменьшить шрифт, фон, цвет и тп.

```swift
override func viewDidLoad() {

  // наблюдатель, будет следить за появлением клавиатуры
  // UIKeyboardWillChangeFrame, и запускать updateTextView
  // когда клавиатура поменяет свой размер
        NotificationCenter.default.addObserver(self,
                selector: #selector(updateTextView(notification:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)
                
// наблюдатель, будет следить за скрытием клавиатуры UIKeyboardWillHide и запускать updateTextView
        NotificationCenter.default.addObserver(self,
                   selector: #selector(updateTextView(notification:)),
                   name: UIResponder.keyboardWillHideNotification,
                   object: nil)
                   
}
```

---

### [#UIStepper ](https://developer.apple.com/documentation/uikit/uistepper)
Элемент управления, для увеличения или уменьшения значения.
Размер шрифта измеряется в CGFloat

```swift
override func viewDidLoad() {

        stepper.value = 17
        stepper.maximumValue = 10
        stepper.maximumValue = 25
        stepper.stepValue = 1
        stepper.tintColor = .white
        stepper.backgroundColor = .gray
        // скругление углов у stepper
        stepper.layer.cornerRadius = 5
        
}
```

```swift
// увеличение и уменьшение шрифта 
// в заданных границах в textView
  @IBAction func sizeFont(_ sender: UIStepper) {
        let font = textView.font?.fontName
        let fontSize = CGFloat(sender.value)
        textView.font = UIFont(name: font!, size: fontSize)
  }
```

---

### [#UIActivityIndicatorView](https://developer.apple.com/documentation/uikit/uiactivityindicatorview)
Анимация прогресса загрузки данных.

Если нужно запретить пользователю взаимодействовать с вашим приложением во время пока `#UIActivityIndicatorView` активен (к примеру, пока грузятся данные). То в `viewDidLoad()`

```swift
@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

override func viewDidLoad() {

// отвечает за ActivityIndicator,
// когда он закончит свою анимацию действия, то исчезнет
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.darkGray
        activityIndicator.startAnimating()

// метод UIApplication.shared.beginIgnoringInteractionEvents() устарел
// вот новое решение, заморозим view, с ним нельзя взаимодействовать
        self.view.isUserInteractionEnabled = false
        
        
// данный метод прекратит анимацию activityIndicator.startAnimating()
    UIView.animate(withDuration: 0, delay: 5, options: .curveEaseIn) {
            self.textView.alpha = 1
        } completion: { finished in
            self.activityIndicator.stopAnimating()
            self.textView.isHidden = false
            // оживим view для взаимодействия
            self.view.isUserInteractionEnabled = true
        }
}
```

---

### [#UIProgressView](https://developer.apple.com/documentation/uikit/uiprogressview)
Индикатор прогресса загрузки.

```swift
@IBOutlet weak var progressView: UIProgressView!
 
override func viewDidLoad() {
progressView.setProgress(0, animated: true)

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
```

---

### []()

```swift

```

```swift

```

