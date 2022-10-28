## [UIKit](https://developer.apple.com/documentation/uikit) 

<img alt="image" src="images/UIKit classes.jpg"/>

[Views and controls](https://developer.apple.com/documentation/uikit/views_and_controls) 

Верстка кодом. Элементы функционала

### [UIButton](https://developer.apple.com/documentation/uikit/uibutton)

#Tint color – цвет оттенка кнопки
#IBOutlet – кастомизация, обращение к свойствам элемента (к примеру кнопки, label и тп)
#IBAction – будет выполнять все действия связанные с элементом  

```swift
// скрываем - true, показываем - false
button.isHidden = true

// текст кнопки
button.setTitle("Clear", for: .normal)

// цвет текста
button.setTitleColor(UIColor.white, for: .normal)

// фон
button.backgroundColor = UIColor.red

```

### [UILabel](https://developer.apple.com/documentation/uikit/uilabel)

```swift
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

```





