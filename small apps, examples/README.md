Здесь содержатся примеры маленьких приложений, с целью знакомства и изучения различной функциональности. В каждом из приложений есть готовые шаблоны/примеры использования. Ниже описание:

- **[WeeklyFinderArt](https://github.com/artemiosdev/Swift-Manual-my-notes/tree/main/small%20apps%2C%20examples/WeeklyFinderArt/WeeklyFinderArt)** - работа с [Calendar()](https://developer.apple.com/documentation/foundation/calendar) day, month, year, [DateComponents()](https://developer.apple.com/documentation/foundation/datecomponents), [DateFormatter()](https://developer.apple.com/documentation/foundation/dateformatter), вывод даты [dateFormat](https://developer.apple.com/documentation/foundation/dateformatter/1413514-dateformat), взаимодействие с клавиатурой [touchesBegan()](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan/) - сообщает этому объекту, что в представлении или окне произошло одно или несколько новых касаний.

<img alt="gif" src="images/WeeklyFinderArt.gif" height = 510 width = 233 />

---

- **[TemperatureConverter](https://github.com/artemiosdev/Swift-Manual-my-notes/tree/main/small%20apps%2C%20examples/TemperatureConverter/TemperatureConverter/TemperatureConverter)** - используется [UISlider](https://developer.apple.com/documentation/uikit/uislider), округление [round()](https://www.advancedswift.com/rounding-floats-and-doubles-in-swift/) 

<img alt="gif" src="images/TemperatureConverter.gif" height = 510 width = 233 />

---

- **[PassDataProjectArt](https://github.com/artemiosdev/Swift-Manual-my-notes/tree/main/small%20apps%2C%20examples/PassDataProjectArt/PassDataProjectArt)** - UITextField c login и password, выбор segue  учитывая идентификатор [performSegue(withIdentifier:, sender:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performsegue), возврат segue на другой экран с помощью  unwind Segue реализуется как к элементом, так и с View (предпочтительнее). Взаимодействие с [UIStoryboardSegue](https://developer.apple.com/documentation/uikit/uistoryboardsegue/) (destination, source, identifier). Передача данных с одного View на другой, [prepare(for segue: UIStoryboardSegue, sender: )](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621490-prepare) этот метод уведомляет view controller о том, что переход вот-вот будет выполнен. . Взаимодействие с клавиатурой [touchesBegan()](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan/) - сообщает этому объекту, что в представлении или окне произошло одно или несколько новых касаний.

<img alt="gif" src="images/PassDataProjectArt.gif" height = 510 width = 233 />

---

- **[UILabelAndUIButton](https://github.com/artemiosdev/Swift-Manual-my-notes/tree/main/small%20apps%2C%20examples/UILabel/UILabel)**, пример использования [UIButton](https://developer.apple.com/documentation/uikit/uibutton) и [UILabel](https://developer.apple.com/documentation/uikit/uilabel), свойства элементов, верстка кодом `(isHidden, font, text, setTitle, titleLabel?.text, textColor, setTitleColor, backgroundColor)`

<img alt="gif" src="images/UILabelAndUIButton.gif" height = 510 width = 233 />

---

- **[UISegmentedControl, UISlider, UITextField, UIScrollView, UIDatePicker, UISwitch, UIPickerView](https://github.com/artemiosdev/Swift-Manual-my-notes/tree/main/small%20apps%2C%20examples/UISegmentedControl/UISegmentedControl)**, пример использования [UISegmentedControl](https://developer.apple.com/documentation/uikit/uisegmentedcontrol), добавить кодом segment [segmentedContol.insertSegment](https://developer.apple.com/documentation/uikit/uisegmentedcontrol/1618588-insertsegment).

[UISlider](https://developer.apple.com/documentation/uikit/uislider) (`.value,.minimumValue, .maximumValue, .maximumTrackTintColor, .minimumTrackTintColor,  .thumbTintColor`). 

[UITextField ]( https://developer.apple.com/documentation/uikit/uitextfield) 
Есть делегат  [UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate) с помощью которого можно отслеживать взаимодействия пользователя с текстовым полем. 

[UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller/) an object that displays an alert message.

[UIAlertAction](https://developer.apple.com/documentation/uikit/uialertaction )
action that can be taken when the user taps a button in an alert.
Создаем кнопку с предупреждением.

Метод [present()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present) вызывает на экран наше предупреждение.

[UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)
View, которое позволяет прокручивать и масштабировать содержащиеся в нем view. 

[UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
барабан выбора, даты, времени. [DateFormatter()](https://developer.apple.com/documentation/foundation/dateformatter/) - форматирование даты для вывода. 

[UISwitch](https://developer.apple.com/documentation/uikit/uiswitch)
использования switch для скрытия/отображения элементов на экране, (`.isOn, .onTintColor, .thumbTintColor`) 

[UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview)
вращающийся барабан с возможностью выбора среди элементов. [UIPickerViewDelegate](https://developer.apple.com/documentation/uikit/uipickerviewdelegate), и [UIPickerViewDataSource](https://developer.apple.com/documentation/uikit/uipickerviewdatasource). Отдельная кнопка в PickerView [#UIToolbar](https://developer.apple.com/documentation/uikit/uitoolbar) и [#UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem). При выборе textField за место клавиатуры по умолчанию, вызывается PickerView.

<img alt="gif" src="images/UISegmentedControl.gif" height = 510 width = 233 />

---

- **[UITextView, UIStepper, UIActivityIndicatorView, UIProgressView](https://github.com/artemiosdev/Swift-Manual-my-notes/tree/main/small%20apps%2C%20examples/UITextView/UITextView)**, пример использования [UITextView ](https://developer.apple.com/documentation/uikit/uitextview)

[UITextViewDelegate](https://developer.apple.com/documentation/uikit/uitextviewdelegate) - протокол включающий в себя методы отслеживания тапов, и не только. 

[UIStepper ](https://developer.apple.com/documentation/uikit/uistepper) - элемент управления, для увеличения или уменьшения значения.

[UIActivityIndicatorView](https://developer.apple.com/documentation/uikit/uiactivityindicatorview) - анимация прогресса загрузки данных.

[UIProgressView](https://developer.apple.com/documentation/uikit/uiprogressview) - индикатор прогресса загрузки.

<img alt="gif" src="images/UITextView.gif" height = 510 width = 233 />
