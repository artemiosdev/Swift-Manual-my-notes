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

### #Navigation

- [#Navigation Controller Scene](https://developer.apple.com/documentation/uikit/uinavigationcontroller)
- [#UINavigationItem](https://developer.apple.com/documentation/uikit/uinavigationitem)

```swift
// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
self.navigationItem.rightBarButtonItem = self.editButtonItem
```

---

### [#UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller)

В `[indexPath.row]` мы располагаем каждый элемент из нашего массива на отдельной строке. Обращаемся, чтобы выбрать конкретный элемент для конкретной строки. 

- [#UIListContentConfiguration](https://developer.apple.com/documentation/uikit/uilistcontentconfiguration) - конфигурация содержимого для представления содержимого на основе списка, `#content`

```swift
var content = cell.defaultContentConfiguration()
// Configure content.
content.image = UIImage(systemName: "star")
content.text = "Favorites"
// Customize appearance.
content.imageProperties.tintColor = .purple
cell.contentConfiguration = content
```

- [#tableView(_:numberOfRowsInSection:)](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614931-tableview) - указывает источнику данных возвращать необходимое количество строк в заданном разделе табличного представления.

```swift
    // MARK: - Table view data source
    // возвращает кол-во строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
        return imageNameArray.count
    }
```

- [#tableView(_:cellForRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614861-tableview) - запрашивает у источника данных ячейку для вставки в определенном месте табличного представления. Используем описанный выше `#content` [#UIListContentConfiguration](https://developer.apple.com/documentation/uikit/uilistcontentconfiguration)

```swift
// создание ячейки по Identifier и работа с ячейкой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)

        // устаревшие свойства
        // cell.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        // cell.textLabel?.text = imageNameArray[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        let track = imageNameArray[indexPath.row]
        // Configure content.
        content.image = UIImage(named: track.title)
        content.text = track.song
        content.secondaryText = track.artist
        content.textProperties.numberOfLines = 0
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        return cell
    }
```

- [#tableView(_:didSelectRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614877-tableview) - tells the delegate a row is selected.

tableView - informing the delegate about the new row selection.

indexPath - locating the new selected row in tableView.

В примере ниже используется [#UIContainerView](https://github.com/artemiosdev/Small-projects/tree/main/UIContainerView/UIContainerView) для ipad. UIContainerView - определяет область в иерархии представлений контроллера представления для размещения дочернего #child view controller. The child view controller указывается с помощью встроенного перехода segue. Встраивается наш TableView отвечающий за список song in ContainerView, все на одном экране ipad который визуально разделен на условные 2 области для пользователя. 

```swift
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = parent as? ViewController {
            let track = imageNameArray[indexPath.row]
            viewController.artistLabel.text = track.artist
            viewController.songLabel.text = track.song
            viewController.imageCover.image = UIImage(named: track.title)
        }
    }
```

и здесь же используется свойство [#parent](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621362-parent)
Instance Property #parent - The parent view controller of the recipient.

`weak var parent: UIViewController? { get }`

` if let viewController = parent as? ViewController { ... } `

- [#prepare(for:sender:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621490-prepare) - уведомляет контроллер представления о том, что переход вот-вот будет выполнен. При тапе на трек, сделаем переход #seque, добавим #identifier, на новый view controller 

```swift
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
           if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailViewController = segue.destination as! DetailViewController
                let track = imageNameArray[indexPath.row]
                detailViewController.track = track
            }
        }       
//        или тот же переход, но с guard
//        guard let detailViewController = segue.destination as? DetailViewController else { return }
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        let track = imageNameArray[indexPath.row]
//        detailViewController.track = track
    } 
```

---

### [#UICollectionViewController](https://developer.apple.com/documentation/uikit/uicollectionviewcontroller)
контроллер представления, который специализируется на управлении представлением коллекции.

- [#UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell)

- [#collectionView(_:numberOfItemsInSection:)](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource/1618058-collectionview) - запрашивает у вашего объекта источника данных количество элементов в указанном разделе.

```swift
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
        return imageNameArray.count
    }
```

- [#collectionView(_:cellForItemAt:)](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource/1618029-collectionview) - запрашивает у вашего объекта источника данных ячейку, соответствующую указанному элементу в представлении коллекции. 

```swift
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtCoverCell
        let track = imageNameArray[indexPath.row]
        // Configure content.
        cell.coverImageView.image = UIImage(named: track.title)
        return cell
    }
}
```

- [#prepare(for:sender:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621490-prepare) - уведомляет контроллер представления о том, что переход вот-вот будет выполнен.  При тапе на трек, сделаем переход #seque, добавим #identifier, на новый view controller 

```swift
// MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView.indexPath(for: cell)
            let detailViewController = segue.destination as! DetailViewController
            let track = imageNameArray[indexPath!.row]
            detailViewController.track = track
        }
    }
```


---

### [#UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) 
верстка элемента кодом

```swift
let layout = UICollectionViewFlowLayout()
layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
layout.itemSize = CGSize(width: 105, height: 105)
layout.minimumInteritemSpacing = 0
layout.minimumLineSpacing = 20
collectionView.collectionViewLayout = layout
```

```swift

```



---

### [#WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) 
An object that displays interactive web content, such as for an in-app browser.

- [#WebKit](https://developer.apple.com/documentation/webkit) - integrate web content seamlessly into your app, and customize content interactions to meet your app’s needs.
- [Creating a simple browser with WKWebView, by hackingwithswift](https://www.hackingwithswift.com/read/4/2/creating-a-simple-browser-with-wkwebview)
- [#WKNavigationDelegate](https://developer.apple.com/documentation/webkit/wknavigationdelegate) - methods for accepting or rejecting navigation changes, and for tracking the progress of navigation requests.
- [#UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate) - a set of optional methods to manage the editing and validation of text in a text field object.
- [#URL](https://developer.apple.com/documentation/foundation/url)
- [#URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
- [#load(_:)](https://developer.apple.com/documentation/webkit/wkwebview/1414954-load) - loads the web content that the specified URL request object references and navigates to that content.
```swift
let homePage = "https://www.apple.com"
let url = URL(string: homePage)
let request = URLRequest(url: url!)
urlTextField.text = homePage
webView.load(request)
```
- [webView.#allowsBackForwardNavigationGestures](https://developer.apple.com/documentation/webkit/wkwebview/1414995-allowsbackforwardnavigationgestu) - Boolean value that indicates whether horizontal swipe gestures trigger backward and forward page navigation. Добавим свайпы вперед и назад
```swift
// добавим свайпы вперед и назад
webView.allowsBackForwardNavigationGestures = true
```

Свойства `webView`
- `#canGoBack` -  Boolean value that indicates whether there is a valid back item in the back-forward list.
- `#canGoForward` - a Boolean value that indicates whether there is a valid forward item in the back-forward list.
И методы `webView`
- `#goBack()` - navigates to the back item in the back-forward list. New navigation to the requested item, or nil if there is no back item in the back-forward list.
- `#goForward()` - navigates to the forward item in the back-forward list. New navigation to the requested item, or nil if there is no forward item in the back-forward list.
```swift
    // добавим функционал кнопок при возможности их использования
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
```
and
```swift
backButton.isEnabled = webView.canGoBack
forwardButton.isEnabled = webView.canGoForward
```

- [#resignFirstResponder()](https://developer.apple.com/documentation/uikit/uiresponder/1621097-resignfirstresponder) - notifies this object that it has been asked to relinquish its status as first responder in its window. Им "скрываем" клавиатуру после ввода нужного адреса ссылки.
```swift
textField.resignFirstResponder()
```


- [#textFieldShouldReturn(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619603-textfieldshouldreturn) - asks the delegate whether to process the pressing of the Return button for the text field. Работает благодаря протоколу UITextFieldDelegate.

- [#webView(_:#didFinish:)](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview) - tells the delegate that navigation is complete (завершена).

```swift
extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        // реализуем свайпы вперед и назад
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
```

---

### [#UIGestureRecognizer](https://developer.apple.com/documentation/uikit/uigesturerecognizer)

The base class for concrete #gesture #recognizers. 

- [#UISwipeGestureRecognizer](https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer) - a discrete gesture recognizer that interprets swiping gestures in one or more directions.
- [.#direction](https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer/1619178-direction) - the permitted direction of the swipe for this gesture recognizer.
- [#addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) - прикрепляет a gesture recognizer to the view.

```swift
    func swipeObservers() {
        // создаем наблюдателей для каждого свайпа
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
       self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipes(gester: UISwipeGestureRecognizer) {
        switch gester.direction {
        case .right:
            label.text = "Right swipe was recognized"
        default:
            break
        }
    }
```

- [#UITapGestureRecognizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer) - a discrete gesture recognizer that interprets single or multiple taps.
- [#numberOfTapsRequired](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer/1623581-numberoftapsrequired) - the number of taps necessary for gesture recognition.
- [#require(toFail:)](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624203-require) - creates a dependency relationship between the gesture recognizer and another gesture recognizer when the objects are created.

```swift
func tapObservers() {
        // создаем наблюдателей для каждого тапа
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapAction))
        // кол-во отслеживаемых тапов
        tripleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tripleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        // для того чтобы проигнорировать двойной тап, если тапаем трижды
        doubleTap.require(toFail: tripleTap)
        
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap )
    }
    
        @objc func tripleTapAction() {
        label.text = "Triple taped was recognized"
    }
    @objc func doubleTapAction() {
        label.text = "Double taped was recognized"
    }
```

---

### UIPageView
[Пример использования](https://github.com/artemiosdev/Small-projects/tree/main/UIPageView/UIPageView). 

C его помощью можно сделать ознакомительный функционал ввиде некой презентации для пользователя который впервые скачал ваше приложение

- [#UIPageViewController](https://developer.apple.com/documentation/uikit/uipageviewcontroller) - a container view controller  that manages navigation between pages of content, where a child view controller manages each page

- [#UIPageViewControllerDataSource](https://developer.apple.com/documentation/uikit/uipageviewcontrollerdatasource ) – протокол UIPageViewControllerDataSource принимается объектом, который предоставляет контроллеры просмотра контроллеру просмотра страницы по мере необходимости в ответ на жесты навигации. 

Благодаря ему будем листать нашу презентацию. С ним идут 2 обязательных для протокола метода (`viewControllerBefore` and `viewControllerAfter`, вперед и назад по презентации)

```swift
extension PageViewController: UIPageViewControllerDataSource {
    // возврат к странице которая была до текущей (назад)

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    // переход к след странице после текущей (вперед)
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
}
```

- [#viewDidAppear(_:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621423-viewdidappear) - уведомляет контроллер представления о том, что его представление было добавлено в иерархию представлений.
```swift
    // срабатывает сразу же после загрузки и отображения view
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPresentation()
    }
```

- [class #UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) - интерфейс к базе данных пользователя по умолчанию, где вы постоянно сохраняете пары ключ-значение при запуске вашего приложения. 
- [#set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1408905-set) - sets the value of the specified default key to the specified Boolean value.
- [#dismiss(animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621505-dismiss) - oтклоняет контроллер представления, который был представлен модально контроллером представления.

```swift
    @IBAction func closePresentation(_ sender: UIButton) {
        // создадим экземпляр class UserDefaults
        // некий ключ по которому будем закрывать презентацию
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "presentationWasViewed")
        // метод закрывающий view controller
        dismiss(animated: true, completion: nil)
    }
```

- [#instantiateViewController(withIdentifier:)](https://developer.apple.com/documentation/uikit/uistoryboard/1616214-instantiateviewcontroller) - cоздает контроллер представления с указанным идентификатором и инициализирует его данными из раскадровки. На основе storyboard with identifier.

- [#present(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present) - presents a view controller modally.
```swift     
     func startPresentation() {
        let userDefaults = UserDefaults.standard
        // если key есть в системе, то будет true
        let presentationWasViewed = userDefaults.bool(forKey: "presentationWasViewed")
        if presentationWasViewed == false {
            // создаем нужный нам для отображения view controller
            if let pageViewPresentation = storyboard?.instantiateViewController(
                withIdentifier: "PageViewController") as? PageViewController {
                // используем инициализатор
                present(pageViewPresentation, animated: true, completion: nil)
            }
        }
     }
```

- [#setViewControllers(_:direction:animated:completion:)](https://developer.apple.com/documentation/uikit/uipageviewcontroller/1614087-setviewcontrollers) - sets the view controllers to be displayed.
```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let contentViewController = showViewControllerAtIndex(0) {
            // создает массив из view controllers
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
```

