### Modern Auto Layout, Building Adaptive Layouts For iOS 

#### Keith Harrison

Version: 6 (2021-11-09)

Layout - расположение; frame - костяк, рамка

### Auto Layout Tools

<img alt="image" src="images/auto layout6.jpeg" width = 70%/>

• Update Frames - предупреждает вас, когда положение или
размер вида на холсте не соответствуют вычисленным значениям автоматической компоновки. На нем оранжевым цветом показаны ограничения на выход из положения. Используйте инструмент чтобы обновить рамки, чтобы обновить выбранные виды до расчетных значений.
• Align Tool - полезен, когда вы хотите создать ограничения, которые выравнивают края, центры или базовые линии текста нескольких видов. Также используется для центрирования представлений в их superview.
• Add New Constraints - для создания ограничений на горизонтальное или вертикальное расстояние между видами, придающий view фиксированный размер, ширина или высота, придание view равной ширины или высоты, установка соотношения сторон видов и выравнивание видов по краю, базовой линии или центру (например, с помощью инструмента выравнивание).
• Resolve Auto Layout Issues - добавьте или сбросьте ограничения в зависимости от положения view на холсте. Не так полезно, как кажется, поскольку оно редко делает то, что вы хотите, при решении проблем. Я вижу, что люди
иногда используют это, чтобы привязать представление к супервизору, используя “Сброс к Предлагаемые ограничения”, чтобы быстро добавить начальные, конечные, верхние и нижние ограничения. Я рекомендую проигнорировать это.
• Embed In - встраивание выбранного контроллера просмотра в контроллер навигации или панели вкладок. Вставляйте выбранные виды в другой вид со вставкой или без нее, в scroll view или stack view

### Layout Essentials

### The View Hierarchy
Содержимое для окна поступает из root view контроллера представления. Вы создаете свой пользовательский интерфейс, добавляя представления к этому root view:

<img alt="image" src="images/auto layout7.jpeg" width = 70%/>

**Screen (UIScreen)**

Все устройства iOS имеют main экран, но вы также можете подключить их к внешнему external экрану. Вы получаете доступ к main экрану и любым подключенным экранам, используя свойства типа класса UIScreen:

```swift
let mainScreen = UIScreen.main // UIScreen
let screens = UIScreen.screens // [UIScreen]
```

**Window (UIWindow)**

The window является экземпляром класса UIWindow и находится в корне иерархии view, которая содержит пользовательский интерфейс нашего приложения. Большинство приложений имеют единое окно для отображения контента на главном экране устройства.
Вы могли бы создать второе окно для отображения содержимого на внешнем экране. По умолчанию, когда вы создаете окно, оно отображается на главном экране , если вы не назначите другой экран. Обычно вам не нужно думать об окне вашего приложения. Когда ваше приложение
запускается, оно создает для вас окно при загрузке основной раскадровки и увеличьте его размер, чтобы заполнить главный экран. Если вы не используете раскадровку, несколько строк кода в делегате приложения выполняют работу по созданию окна и начального корневого контроллера представления. Смотрите раздел Removing The Main Storyboard for the details

**Root View Controller (UIViewController)**

The root view controller обычно является подклассом пользовательского контроллера представления и
предоставляет содержимое представления для окна. Обычно вы либо загружаете его из своей основной раскадровки, либо создаете вручную в приложении или
делегате сцены. В любом случае, превращение его в root view controller window добавляет view controller’s view to the window.
Видимый пользовательский интерфейс не обязательно должен исходить от одного root view controller. Обычно root view controller является контейнером для других view controller. Таким образом, иерархия view представляет собой комбинацию view из родительского view контейнера и view из дочерних view controllers. Контроллеры навигации и панели вкладок - это два примера из UIKit, но вы также можете создать свой собственный.







### Chapter 2. Layout Before Auto Layout

<img alt="image" src="images/auto layout1.jpeg" width = 70%/>

### Autoresizing Mask
When you use Interface Builder to set springs and struts, you’re changing that views `autoresizingMask`.

<img alt="image" src="images/auto layout2.jpeg" width = 70%/>

`myView.autoresizingMask = [.flexibleWidth,.flexibleHeight]`

Comparing the autoresizing mask to springs and struts in Interface Builder can be confusing. Setting the width spring in Interface Builder is the same as including the `.flexibleWidth` in the mask. Setting the top strut in Interface Builder fixes the margin, the opposite of including `.flexibleTopMargin` in the mask.

When creating views in code the default mask value is `.none` (no resizing). Interface Builder sets the top and left struts by default which is equivalent to an autoresizing mask with flexible bottom and right margins. If you look back at the springs and struts we set for the green view can you guess what the resulting autoresizing mask was? We set the left, top and right struts and the width spring in Interface Builder. This combination gives us a flexible width and a flexible bottom margin. To create this autoresizing mask in code, we would write:

`greenView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]`

### The Limits Of Autoresizing Masks

<img alt="image" src="images/auto layout3.jpeg" width = 70%/>

### Creating A Custom Subclass Of UIView

We need to fix the frames of the blue and red subviews. We can do that by creating a custom subclass of UIView for the green superview

```swift
// TileView.swift
import UIKit
final class TileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        // add view setup code here
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Adjust subviews here
    }
}
```

- [init(frame: CGRect)](https://developer.apple.com/documentation/coregraphics/cgrect) called when we create the view in code. Структура, которая содержит местоположение и размеры прямоугольника.
- [init?(coder: NSCoder)](https://developer.apple.com/documentation/foundation/nscoder) вызывается при загрузке представления из файла nib или storyboard. Абстрактный класс, который служит основой для объектов, позволяющих архивировать и распространять другие объекты

The `init?(coder: NSCoder)` является обязательным инициализатором для UIView. Xcode сообщает об ошибке, если вы не включаете ее, даже если вы никогда не используете nib or storyboard.

```swift
required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")
}
```

We need to create red and blue subviews in TileView.

```swift
private let redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
    
}()

private let blueView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    return view
}()

private func setupView() {
    addSubview(blueView)
    addSubview(redView)
}

var padding: CGFloat = 25.0 {
    didSet {
        setNeedsLayout()
    }
}
```

Если пользователь нашего представления изменит отступы, нам нужно обновить макет. Вы никогда не вызываете `layoutSubviews` самостоятельно. Вместо этого мы
сообщаем UIKit, что наш макет нуждается в обновлении с помощью `setNeedsLayout()`, и он вызывает наши `layoutSubviews` во время следующего цикла обновления.

В layoutSubviews установите положение и размер двух вложенных представлений с учетом заполнения:

```swift
    override func layoutSubviews() {
        // Size of this container view
        // bounds - прямоугольник границ, который описывает местоположение
        // и размер вида в его собственной системе координат
        let containerWidth = bounds.width
        let containerHeight = bounds.height
        
        // Calculate width and height of each item
        // including the padding
        let numberOfItems: CGFloat = 2
        let itemWidth = (containerWidth - (numberOfItems + 1) *
                         padding) / numberOfItems
        let itemHeight = containerHeight - 2 * padding
        
        // Set the frames of the two subviews
        blueView.frame = CGRect(x: padding, y: padding, width: itemWidth, height: itemHeight)
        redView.frame = CGRect(x: 2 * padding + itemWidth, y: padding, width: itemWidth, height: itemHeight)
    }
```

<img alt="image" src="images/auto layout4.jpeg" width = 70%/>

В итоге получаем код:

```swift

import UIKit

final class TileView: UIView {
    var padding: CGFloat = 25.0 {
        didSet {
            // обновляет макет
            setNeedsLayout()
        }
    }
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(blueView)
        addSubview(redView)
    }
    
    override func layoutSubviews() {
        // Size of this container view
        // bounds - прямоугольник границ, который описывает местоположение
        // и размер view в его собственной системе координат
        let containerWidth = bounds.width
        let containerHeight = bounds.height
        
        // Calculate width and height of each item
        // including the padding
        let numberOfItems: CGFloat = 2
        let itemWidth = (containerWidth - (numberOfItems + 1) *
                         padding) / numberOfItems
        let itemHeight = containerHeight - 2 * padding
        
        // Set the frames of the two subviews
        blueView.frame = CGRect(x: padding, y: padding, width: itemWidth, height: itemHeight)
        redView.frame = CGRect(x: 2 * padding + itemWidth, y: padding, width: itemWidth, height: itemHeight)
    }
}
```

<img alt="image" src="images/auto layout5.jpeg" width = 70%/>

### Designable And Inspectable Custom Views

26 стр

<img alt="image" src="images/auto layout.jpeg" width = 70%/>
<img alt="image" src="images/auto layout.jpeg" width = 70%/>
<img alt="image" src="images/auto layout.jpeg" width = 70%/>
<img alt="image" src="images/auto layout.jpeg" width = 70%/>
<img alt="image" src="images/auto layout.jpeg" width = 70%/><img alt="image" src="images/auto layout.jpeg" width = 70%/>
<img alt="image" src="images/auto layout.jpeg" width = 70%/>