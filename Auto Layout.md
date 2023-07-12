### Modern Auto Layout, Building Adaptive Layouts For iOS 

<a id="contents" />Оглавление

- [Appendix.  Main concepts](#appendix)
- [Глава №2. Layout Before Auto Layout.](#chapter2)
- [Глава №3. Getting Started With Auto Layout.](#chapter3)
- [Глава №4. Using Interface Builder.](#chapter4)
- [Глава №5. Creating Constraints In Code.](#chapter5)
- [Глава №6. Safe Areas And Layout Margins.](#chapter6)
- [Глава №7. Layout Priorities and Content Size.](#chapter7)
- [Глава №8. Stack Views.](#chapter8)
- [Глава №9. .](#chapter9)
- [Глава №10. .](#chapter10)
- [Глава №11. .](#chapter11)
- [Глава №12. .](#chapter12)
- [Глава №13. .](#chapter13)
- [Глава №14. .](#chapter14)

---

[К оглавлению](#contents)

###  <a id="appendix" />  Appendix.  Main concepts

Simple rule of thumb for answering the question **How Many Constraints Do I Need?**

> **To fix the size and position of each view in a layout we
needed at least two horizontal and two vertical constraints
for every view**.

### Auto Layout Tools

<img alt="image" src="images/auto layout6.jpeg" width = 50%/>

Layout - расположение; frame - рамка

- Update Frames - предупреждает вас, когда положение или
размер вида на холсте не соответствуют вычисленным значениям автоматической компоновки. На нем оранжевым цветом показаны ограничения на выход из положения. Используйте инструмент чтобы обновить рамки, чтобы обновить выбранные виды до расчетных значений.

- Align Tool - полезен, когда вы хотите создать ограничения, которые выравнивают края, центры или базовые линии текста нескольких видов. Также используется для центрирования представлений в их superview.

- Add New Constraints - для создания ограничений на горизонтальное или вертикальное расстояние между видами, придающий view фиксированный размер, ширина или высота, придание view равной ширины или высоты, установка соотношения сторон видов и выравнивание видов по краю, базовой линии или центру (например, с помощью инструмента выравнивание).

- Resolve Auto Layout Issues - добавьте или сбросьте ограничения в зависимости от положения view на холсте. Не так полезно, как кажется, поскольку оно редко делает то, что вы хотите, при решении проблем. Я вижу, что люди
иногда используют это, чтобы привязать представление к супервизору, используя “Сброс к Предлагаемые ограничения”, чтобы быстро добавить начальные, конечные, верхние и нижние ограничения. Я рекомендую проигнорировать это.

- Embed In - встраивание выбранного контроллера просмотра в контроллер навигации или панели вкладок. Вставляйте выбранные виды в другой вид со вставкой или без нее, в scroll view или stack view

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

**Views (UIView)**

Контент, отображаемый вашим приложением, берется из его views. Эти views могут быть обычным старым UIView, чем-то более сложным, например табличным представлением,
одним из многих элементов управления UIKit или даже нашими пользовательскими views. Все эти views,
включая window, являются подклассами базового класса UIView. View имеет не более одного superview, но может иметь ноль, один или несколько subviews. Свойство superview UIView может быть равно нулю, если вы
не добавили view в иерархию views. Swift обрабатывает значения, которые могут быть равны нулю, делая их optional. Таким образом, superview - это optional UIView:

`var superview: UIView? { get }`

Обратите внимание, что у этого свойства нет параметра setter, поэтому вы не можете изменить его напрямую. Добавление или удаление subviews задает superview subviews. View отслеживает свои непосредственные subviews в массиве элементов UIView:

`var subviews: [UIView] { get }`

Порядок view в массиве имеет решающее значение, поскольку он задает порядок отображения
от конца к началу. Таким образом, вид с индексом 0 находится сзади, а последний view в массиве - спереди.
Добавьте subview просмотр к родительскому view, вызвав метод `addSubview` родительского view. Это добавляет subview в конец массива subview, поэтому он отображается спереди. Существуют другие методы для добавления subview в определенной позиции или до или после другого subview. Несколько примеров:

```swift
yellowView.addSubview(greenView)
greenView.insertSubview(blueView, at: 0)
greenView.insertSubview(whiteView, aboveSubview: blueView)
greenView.insertSubview(redView, belowSubview: whiteView)
```

Note that you add or insert subviews to the superview, but when you want to remove a subview you use `removeFromSuperview` on the subview:
`whiteView.removeFromSuperview()`

You can also bring a view to the front, send a view to the back or swap the position of two views:

```swift
greenView.bringSubview(toFront: whiteView)
greenView.sendSubview(toBack: blueView)
greenView.exchangeSubview(at: 0, withSubviewAt: 1)
```

If you use Interface Builder to create your layouts, it handles the view hierarchy for you

<img alt="image" src="images/auto layout8.jpeg" width = 60%/>

#Clip to Bounds - Обрезка по границам property for the green view in Interface Builder:

<img alt="image" src="images/auto layout9.jpeg" width = 60%/>

or   `greenView.clipsToBounds = true`

Помните, что для того, чтобы ваши view были видны, они также должны в конечном итоге стать частью иерархии views, в корне которой находится главное window. Вы можете проверить это с помощью `window` свойства `UIView`. Если это свойство равно нулю для view, то оно не отображается на экране.

### View Geometry

There are four properties of UIView that control the size and position of a view:
- #frame-рамка: The rectangle прямоугольник that gives the position and size of the view in the coordinate system of its superview.
- #bounds-границы: The rectangle that gives the внутренние size of the view in its coordinate system.
- #center: The center point of the view in the coordinate system of its superview.
- #transform-преобразование: применяемое для масштабирования rotate или поворота scale view

<img alt="image" src="images/auto layout10.jpeg" width = 50%/>

The coordinate systems for iOS and macOS не совпадают. The origin (0,0) is in the top-left corner for iOS and the bottom-left corner for macOS.

```swift
// Rotate by 45 degrees (angle in radians)
greenView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)

// Scale width x 2 and height x 0.5
greenView.transform = CGAffineTransform(scaleX: 2, y: 0.5)

// Reset transform to identity
greenView.transform = CGAffineTransform.identity
```

45-degree rotation transform ( `(π / 4) * 180 / π  = 180 / 4 = 45`):

<img alt="image" src="images/auto layout11.jpeg" width = 50%/>

Apple warns that when a view has a transform преобразуют, отличающееся от identity transform, the `frame` is undefined неопределен. If you need to get the size, изменить size or move a view with a transform use the `bounds` and `center`.

Some examples to show how to use the frame, bounds and center to manage the size and position of a view:

```swift
// Use frame to set initial size and position of view
let greenView = UIView(frame: CGRect(x: 25, y: 25, width: 125, height: 125))

// Use bounds to change size of a view without moving
// center of view
greenView.bounds.size = CGSize(width: 50, height: 50)

// Use center to move a view
greenView.center = CGPoint(x: 100, y: 100)
```

При использовании автоматической компоновки вы никогда не должны напрямую изменять frame, bounds or center of a view. Используйте constraints для описания вашего layout и позвольте движку компоновки позаботиться о размере и расположении ваших views

### Core Graphics Data Types
#### CGFloat For Numeric Values

Use a `CGFloat` for view sizes, spacing, and positions. It’s a Double on 64-bit platforms and a Float on 32-bit platforms.

`let spacing: CGFloat = 25.0`

`let padding: CGFloat = 8.0`

If you mix types you will need to cast to CGFloat:

`let offset = 10 // Int by default`

`let x = padding + CGFloat(offset) // x is of type CGFloat`

45-degree rotation transform ( `(π / 4) * 180 / π  = 180 / 4 = 45`):
Note also the type property `CGFloat.pi` for the mathematical
constant (3.14159. . . ):

`let rotation = CGFloat.pi/4` // 45 градусов

#### CGPoint для определения координат
Структура со значениями x и y (оба CGFloat) для двумерных координат точки. Начало координат (0,0) находится в верхнем левом углу на iOS.

```swift
struct CGPoint {
    var x: CGFloat
    var y: CGFloat
}
let startPoint = CGPoint(x: 25, y: 25)
```

#### CGSize For Width And Height
A struct with a width and height value.

```swift
struct CGSize {
    var width: CGFloat
    var height: CGFloat
}
let size = CGSize(width: 325, height: 175)
```

### CGRect For Rectangles

Структура, которая определяет прямоугольник с началом координат и размером. Frame and bounds view имеют тип CGRect. Вы можете создать CGRect из CGPoint и CGSize, но у него также есть инициализаторы, которые
принимают четыре значения  (x, y, width, height) непосредственно как типы Int, Double или CGFloat:

```swift
// Rectangle
struct CGRect {
    var origin: CGPoint
    var size: CGSize
}

let origin = CGPoint(x: 25, y: 25)
let size = CGSize(width: 325, height: 175)
let rect1 = CGRect(origin: origin, size: size)
let rect2 = CGRect(x: 25, y: 25, width: 325, height: 175)
```

There are functions for working with insets, offsets, intersections
and unions:

Существуют функции для работы со вставками, смещениями, пересечениями и объединениями:

```swift
let container = CGRect(x: 100, y: 100, width: 200, height: 100)
let inset = container.insetBy(dx: 20, dy: 20) 
// {x 120 y 120 w 160 h 60}

let offset = container.offsetBy(dx: 20, dy: 20)
// {x 120 y 120 w 200 h 100}
```

Note that each struct also has a static type property to represent zero:
```swift
let zeroPoint = CGPoint.zero // {x 0 y 0}
let zeroSize = CGSize.zero // {w 0 y 0}
let zeroRect = CGRect.zero // {x 0 y 0 w 0 h 0}
```

### Points vs. Pixels

Система координат iOS (UIKit) использует точки, а не физические пиксели экрана. Способ сопоставления точки с физическим пикселем зависит от разрешения устройства. На ранних устройствах iPhone одна точка была равна одному пикселю. Более поздние устройства имеют экраны с более высоким разрешением, где одна точка масштабируется до в 2 или 3 раза больше пикселей.
Автоматическая компоновка всегда работает в точках, но коэффициент масштабирования становится важным для любых изображений, которые вы используете в своем приложении. Таким образом, для изображения размером 50 × 50 пикселей при стандартном разрешении (1x) потребуется изображение размером @2x 100 × 100 пикселей для iPhone 8. И изображение размером @ 3x 150 × 150 пикселей для iPhone 8 Plus. В таблицах показаны размер точки UIKit и масштабный коэффициент, а также собственный размер пикселя и масштабный коэффициент каждого устройства. 

<img alt="image" src="images/auto layout12.jpeg" width = 60%/>

<img alt="image" src="images/auto layout13.jpeg" width = 60%/>

Если вы хотите узнать размер UIKit или масштабный коэффициент scale factor экрана, используйте `bounds` и `scale` properties of the UIScreen. Свойства `nativeBounds` и `nativeScale` дают вам фактический
размер пикселя и масштаб scale.

---

[К оглавлению](#contents)

###  <a id="chapter2" /> Глава № 2. Layout Before Auto Layout

<img alt="image" src="images/auto layout1.jpeg" width = 70%/>

### Autoresizing Mask
When you use Interface Builder to set springs and struts, you’re changing that views `autoresizingMask`.

<img alt="image" src="images/auto layout2.jpeg" width = 60%/>

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

<img alt="image" src="images/auto layout4.jpeg" width = 60%/>

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

<img alt="image" src="images/auto layout5.jpeg" width = 50%/>

### Designable And Inspectable Custom Views

Одним из недостатков нашего пользовательского представления является то, что мы больше не видим дизайн
в Interface Builder. Xcode поддерживает предварительный просмотр пользовательских представлений “designable - настраиваемый/определяемый” в Interface Builder в режиме реального времени, добавляя
ключевое слово `@IBDesignable` перед определением класса. Вы также можете сделать свойства view доступными для редактирования в Interface Builder, добавив ключевое слово `@IBInspectable`

1. Давайте сделаем наш пользовательский класс view настраиваемым в Interface Builder 
```swift
@IBDesignable
final class Titleview: UIView { ... }
```

We can also make the padding parameter inspectable (проверяемый) so we can change it in Interface Builder:

```swift
    @IBInspectable var padding: CGFloat = 25.0 {
        didSet {
            setNeedsLayout()
        }
    }
```

3. The red and blue subviews should now show up in Interface Builder. Try changing the padding in the inspector:

<img alt="image" src="images/auto layout14.jpeg" width = 70%/>

### Using The View Controller To Layout Subviews

Если у вас простой макет, можно избежать создания пользовательского подкласса UIView только для переопределения layoutSubviews. Класс UIViewController
имеет два метода, которые вы можете использовать для настройки макета:

- `viewWillLayoutSubviews`: вызывается до того, как view controller’s view начнет компоновать свои subviews
- `viewDidLayoutSubviews`: вызывается после того, как view controller’s view завершит компоновку своих subviews

Реализация обоих этих методов по умолчанию ничего не делает. Как и в случае layoutSubviews, система может вызывать эти методы много раз во время life of a view controller, поэтому избегайте выполнения в них ненужной работы.
Для любого значительного объема макета я предпочитаю создавать custom view, но вы можете использовать `viewDidLayoutSubviews`, чтобы внести небольшие изменения в представление после того, как view controller has finished its layout

add a corner radius to our tile view that’s a percentage
of the view width

```swift
// ViewController.swift
import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var tileView: TileView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 5% radius
        let radius = tileView.bounds.width / 20
        tileView.layer.cornerRadius = radius
    }
}
```

<img alt="image" src="images/auto layout15.jpeg" width = 50%/>

### Layout Without Storyboards

#### Removing The Main Storyboard
1. Main.storyboard “Move to Trash” to delete the file

2. We need to delete the storyboard from the settings for the
target

<img alt="image" src="images/auto layout16.jpeg" width = 70%/>

3. Scene Delegate “Move to Trash” to delete the file

4. To completely remove the scene delegate we also need to remove the scene configuration from the `Info.plist` file. Find the entry named “Application Scene Manifest”, open it and delete the “Scene Configuration”

<img alt="image" src="images/auto layout17.jpeg" width = 70%/>

5. Delete the ViewController.swift

6. Create new file RootViewController.swift

7. Without the main storyboard, we need to take care of creating the main window. Find the AppDelegate.swift `didFinishLaunchingWithOptions` method, в нем и будем настраивать

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // here
        return true
    }
```

8. Add the window variable if you’re not using a scene delegate.
`var window: UIWindow?`

9. In the body of the method create the main window using the size of the main screen. (By default a new window uses the main screen of the device): 
`window = UIWindow(frame: UIScreen.main.bounds)`

10. Optionally set the color of the window (default is black). 
`window?.backgroundColor = .white`

11. Create your [root view controller](https://developer.apple.com/documentation/uikit/uiwindow/1621581-rootviewcontroller) and add it to the window. This action takes care of adding the view controller’s view to the window 
`window?.rootViewController = RootViewController()`

12. Чтобы отобразить окно, установите его в качестве ключевого window и сделайте его видимым: 
`window?.makeKeyAndVisible()`

```swift
// весь код
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
// ...   
}
```

### How View Controllers Load Their View

A view controller stores its root view in its `view` property. Вновь созданный view controller загружает свой view не сразу, поэтому свойство `view` по умолчанию равно nil.
Если вы обращаетесь к view, когда оно равно nil, view controller вызывает метод с подходящим названием `loadView()` для загрузки view. Эта “ленивая загрузка” view означает, что оно загружается только при необходимости (обычно потому, что оно вот-вот появится на экране).
Не имеет значения, как вы создаете свой view controller loadView() метод всегда вызывается для загрузки view. Если метод loadView() находит файл nib или storyboard, загружает view и любые subviews из него.
Если файла нет, создает обычный UIView

Не вызывайте loadView самостоятельно. Если вы хотите принудительно загрузить представление, вызовите `loadViewIfNeeded()`. Чтобы проверить, загрузил ли
контроллер представления свое представление, не вызывая
loadView() для его загрузки, используйте `isViewLoaded`

How does `loadView()` find a nib file for a view controller? It first checks the `nibName` property of the view controller. If you create your view controller with a storyboard UIKit sets the `nibName` for you using a nib file stored in the storyboard.
If you’re creating your view controller in code, you must вызвать initializer `init(nibName:bundle:)` c указанием the nib file
name and bundle (пакет) to use. Some examples:

```swift
// Load from RootViewController.xib in main bundle
let controller = RootViewController(nibName: "RootViewController", bundle: Bundle.main)

// Default to main bundle
let controller = RootViewController(nibName: "RootViewController", bundle: nil)
```

If the view controller class and nib file are in a framework bundle:
```swift
let controller = RootViewController(nibName:
"RootViewController", bundle: Bundle(for: RootViewController.self))
```

Если вы не задаете nibName, loadView() выполняет поиск файла, используя имя класса view controller. Например, если нашим классом view controller является RootViewController, он выполняет попытки в следующем порядке:
- RootView.nib - this only works for classes that end in Controller.
- RootViewController.nib
Вы также можете использовать файлы nib, зависящие от конкретной платформы:
- RootViewController~ipad.nib - iPad specific nib file
- RootViewController~iphone.nib - iPhone specific nib file
Обратите внимание, что использование инициализатора UIViewController по умолчанию - это то же самое, что
вызов указанного инициализатора с именем nib и bundle как nil:
```swift
// The following are equivalent
let controller = RootViewController(nibName: nil, bundle: nil)
let controller = RootViewController()
```

For view controllers created in a storyboard the view is loaded from the storyboard при его создании:
```swift
if let vc = storyboard?.instantiateViewController(
withIdentifier: "MyViewController") {
// setup and present
}
```

### Using A Nib File
If you’re not creating your view controller with a storyboard, you can still use Interface Builder to create its views in a автономный nib file

1. Add a new file to the project (File › New › File... ) and choose the `View` template from the User Interface section

<img alt="image" src="images/auto layout18.jpeg" width = 70%/>

2. Name the file using as your view controller, for example RootViewController.xib, and save it in the project folder.
3. Select the “File’s Owner” placeholder in the document outline to the left of the canvas. Using the Identity Inspector set the class to the class of the view controller (RootViewController in my case)

<img alt="image" src="images/auto layout19.jpeg" width = 70%/>

4. Connect the view in the nib file to the view property of the view controller. Control-drag from the File’s Owner placeholder to the view and select the view outlet:

<img alt="image" src="images/auto layout20.jpeg" width = 40%/>

С данным xib можно работать, и добавлять на него элементы из библиотеки, все тоже что и в storyboard.

### Overriding loadView
If you don’t load your views from a storyboard or nib file, you can create them manually in code in the view controller. One possible way to do this is to override `loadView()`. 

```swift
import UIKit

final class RootViewController: UIViewController {
    override func loadView() {
        let rootView = UIView()
        rootView.backgroundColor = .yellow
        view = rootView
        // other view setup...
    }
}
```

Если вы переопределяете loadView(), вы должны создать по крайней мере root view  и назначить его свойству `view` view controller. Представление не обязательно должно
быть простым UIView. Это может быть UIScrollView или любой другой подкласс UIView. Он может содержать столько подвидов, сколько вы захотите, при условии, что вы в конечном итоге назначите его `view`.

### viewDidLoad and Friends

• viewWillAppear: Called when the view controller’s view is about
to be added to the view hierarchy. Unlike viewDidLoad this method
can be called multiple times in the life of a view controller. There’s
a corresponding viewWillDisappear called when the view is about
to be removed from the view hierarchy.
• viewDidAppear: Called after view controller’s view is added to
the view hierarchy and displayed on-screen. Like viewWillAppear
this method can be called multiple times and has a corresponding
method, viewDidDisappear, called after removing the view.

- viewDidLoad: вызывается после того, как view controller загрузил свое view, но еще не добавил его в иерархию view. Вызывается только один раз в жизни view controller
- viewWillAppear: вызывается, когда view controller’s view собирается быть добавлено в иерархию view. В отличие от viewDidLoad, этот метод может вызываться несколько раз в течение жизни view controller’s view. Существует соответствующий viewWillDisappear, вызываемый, когда представление собирается быть удалено из иерархии view.
- viewDidAppear: вызывается после добавления view controller’s view в иерархию view и отображения на экране. Как и viewWillAppear этот метод может вызываться несколько раз и имеет соответствующий метод viewDidDisappear, вызываемый после удаления view.

Как viewDidLoad, так и viewWillAppear имеют ту же проблему, которую мы видели с loadView. View еще не является частью иерархии view, поэтому мы не можем полагаться на его размер. К моменту вызова viewDidAppear наше root view находится в иерархии view, но оно уже отображается, поэтому любые изменения, которые мы вносим, могут быть видны пользователю.

### Куда поместить layout code ?
Итак, куда мы должны поместить layout code view controller, которому нужен размер root view? Мы уже видели ответ. view controller вызывает свои методы `viewWillLayoutSubviews` и `viewDidLayoutSubviews` до и после того, как его root view размещает свои subviews. Мы можем переопределить эти методы, чтобы создать наш view layout. Давайте используем это в нашем root view controller для layout нашего зеленого view 

```swift
import UIKit

final class RootViewController: UIViewController {
    private let padding: CGFloat = 50.0

    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }

    override func viewWillLayoutSubviews() {
        if greenView.superview == nil {
            view.addSubview(greenView)
            let width = view.bounds.width - 2 * padding
            greenView.frame = CGRect(x: padding, y: padding, width: width, height: 3 * padding)
        }
    }
}
```

<img alt="image" src="images/auto layout21.jpeg" width = 40%/>

Some points of interest:
1. I made the green view a private property of the view controller and used a closure to create and configure it.
2. Я использую `viewDidLoad` для выполнения одноразовой настройки view, которая не имеет никаких зависимостей от root view size. В этом случае мне нужно только установить цвет фона.
3. In `viewWillLayoutSubviews` we can finally calculate and set the width of the green view. Мы выполняем вычисление один раз, если мы еще не добавили зеленый view в иерархию view hierarchy:

`if greenView.superview == nil {`

If the green view has no superview, we add it to the root view
and calculate its width and set the frame. The autoresizing mask
Маска автоматического изменения размера позаботится обо всем остальном. It matters little in this case, but since a
view controller may call viewWillLayoutSubviews many times.

Стоит отметить, что при работе с программными layout
часто проще пропустить autoresizing mask маску автоматического изменения размера и установить рамку frame непосредственно в layout subviews. Например, мы могли бы переписать view controller для последнего примера следующим образом:

```swift
import UIKit

final class RootViewController: UIViewController {
    private let padding: CGFloat = 50.0
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(greenView)
    }
    override func viewWillLayoutSubviews() {
        let width = view.bounds.width - 2 * padding
        greenView.frame = CGRect(x: padding, y: padding, width: width, height: 3 * padding)
    }
}
```

### Working With A Scene Delegate

Работа со сценами действительно изменяет способ загрузки системой пользовательского интерфейса для window. Если вы используете storyboards, window scene по умолчанию загружает пользовательский интерфейс из main storyboard. Вы настраиваете scenes using the “Application Scene Manifest” dictionary in the Info.plist file

<img alt="image" src="images/auto layout22.jpeg" width = 70%/>

The relevant keys:
- “Enable Multiple Windows”: изменение этого параметра позволяет вам подключиться к нескольким windows. The default is NO.
- “Delegate Class Name”: Each window scene must have a scene delegate. The default Xcode iOS templates includes a scene delegate (SceneDelegate.swift) class for you.
- “Storyboard Name”: The storyboard used to load the scene’s начального user interface.

Let’s create a modified version of our Xcode programmatic layout template that works with a scene delegate 

1. Create a new Xcode project from the iOS App application template and as before remove the Main.storyboard file and delete the entry from the Info.plist file.
2. This time do not delete the “Scene Configuration” entry from the Info.plist file. We want to keep the scene configuration but we
don’t want the scene to load its user interface from a storyboard.
Delete the “Storyboard Name” entry from the scene configuration
3. Вместо создания главного окна в делегате приложения мы создаем его в делегате сцены (**SceneDelegate.swift**). Код почти идентичен, за исключением того, что мы создаем окно, используя сцену окна, переданную нам in the first parameter of the `scene(_:willConnectTo:options:)` method:

```swift
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            return
        }

        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}
```

### Key Points To remember
Some key points to remember from this chapter when using manual frame-based layout:
- Автоматическое изменение размера имеет некоторые ограничения, но это быстрый способ изменить размер view вместе с его родительским элементом. Как мы увидим, авторазмер также хорошо работает наряду с Auto Layout
- Create a custom subclass of UIView to override `layoutSubviews` and take full control of the layout. Custom subviews help разделить комплексный view на управляемые components and move view and layout code из of your view controller. Use `@IBDesignable` and `@IBInspectable` to preview custom views in Interface Builder.
- Use `viewWillLayoutSubviews` or `viewDidLayoutSubviews` as alternatives to creating a custom view subclass.
- When using programmatic layouts, особенно при ручном расчете кадров будьте осторожны с тем, что и где вы делаете. Помните, что view еще не является частью иерархии view в loadView, viewDidLoad или viewWillAppear, поэтому вы не можете предполагать, что оно достигло своего окончательного размера. К счастью, автоматическая компоновка в основном позволяет избежать этой проблемы.

### Test Your Knowledge

<img alt="image" src="images/auto layout25.jpeg" width = 70%/>

1. Challenge2-1

<img alt="image" src="images/auto layout23.jpeg" width = 70%/>

2. Challenge2-2. Фигура такая же, расположение кодом

```swift
// AppDelegate.swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}
```

```swift
// ViewController.swift
import UIKit

class ViewController: UIViewController {
    private enum ViewMetrics {
        static let externalPadding: CGFloat = 50.0
        static let internalPadding: CGFloat = 25.0
        static let redHeight: CGFloat = 100.0
    }
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.autoresizingMask = [.flexibleWidth,.flexibleTopMargin,.flexibleBottomMargin]
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        greenView.addSubview(redView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if greenView.superview == nil {
            view.addSubview(greenView)
            
            let containerWidth = view.bounds.width
            let containerHeight = view.bounds.height
            
            let greenWidth = containerWidth - 2 * ViewMetrics.externalPadding
            let greenHeight = containerHeight - 2 * ViewMetrics.externalPadding
            greenView.frame = CGRect(x: ViewMetrics.externalPadding, y: ViewMetrics.externalPadding, width: greenWidth, height: greenHeight)
            
            let redWidth = greenWidth - 2 * ViewMetrics.internalPadding
            let redY = (greenHeight - ViewMetrics.redHeight) / 2
            redView.frame = CGRect(x: ViewMetrics.internalPadding, y: redY, width: redWidth, height: ViewMetrics.redHeight)
        }
    }
}
```

3. Challenge 2.3 Creating A Custom View and Challenge 2.4 Making Your View Designable

Using A Custom View

<img alt="image" src="images/auto layout26.jpeg" width = 70%/>

Мое не идеальное решение, без storyboard (удален полностью), гибкие размеры на полное заполнение так и не удалось сделать, параметры autoresizingMask не работают, попытка переделать\внедрить код автора в данный код успехов не принесла, пока не ясно как это сделать.

```swift
// AppDelegate.swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RGBView()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}
```

```swift
//  RGBView.swift
import UIKit

class RGBView: UIViewController {
    private let spacing: CGFloat = 20.0
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        // не работают, результат не дают
        //        view.autoresizingMask = [.flexibleWidth,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin ]
        return view
    }()
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        // не работают, результат не дают
        //        view.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin ]
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        // не работают, результат не дают
        //        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin ]
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .white
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        let width = view.bounds.width - 2 * spacing
        redView.frame = CGRect(x: spacing, y: 2 * spacing, width: width, height: 5 * spacing)
        greenView.frame = CGRect(x: spacing, y: 8 * spacing, width: width, height: 5 * spacing)
        blueView.frame = CGRect(x: spacing, y: 14 * spacing, width: width, height: 5 * spacing)
    }
}
```

<img alt="image" src="images/auto layout27.jpeg" width = 50%/>

Решение автора, с помощью storyboard

```swift
// AppDelegate.swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}

// ViewController
import UIKit
final class ViewController: UIViewController {
}
```

```swift
// RGBView.swift
import UIKit

@IBDesignable
final class RGBView: UIView {

    @IBInspectable
    var spacing: CGFloat = 20 {
        didSet {
            setNeedsLayout()
        }
    }

    private let redBar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private let greenBar: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    private let blueBar: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    private var barViews = [UIView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        barViews = [redBar, greenBar, blueBar]
        barViews.forEach { addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let barCount = CGFloat(barViews.count)
        if barCount > 0 {
            let barHeight = (bounds.height - (spacing * (barCount - 1))) / barCount
            var y = 0 as CGFloat
            for view in barViews {
                view.frame = CGRect(x: 0, y: y, width: bounds.width, height: barHeight)
                y += barHeight + spacing
            }
        }
    }
}
```
Identity Inspector ViewController -> class View Controller
Identity Inspector RGBView -> class RGBView

<img alt="image" src="images/auto layout28.jpeg" width = 70%/>

---

[К оглавлению](#contents)

###  <a id="chapter3" /> Глава № 3. Getting Started With Auto Layout

С  Auto Layout вы никогда напрямую не устанавливаете размер и положение view. Вы описываете, каким вы хотите видеть layout, и позволяете автоматической компоновке создавать frames за вас.

Example: The top of the red view should be 16 points below the bottom of the green view.

<img alt="image" src="images/auto layout29.jpeg" width = 70%/>

<img alt="image" src="images/auto layout30.jpeg" width = 35%/>

Мы могли бы написать ограничение, чтобы поместить верхнюю часть красного вида на 16 пунктов ниже нижней части зеленого вида:
`redView.top == greenView.bottom x 1.0 + 16.0`

Мы также могли бы написать это же ограничение, поместив нижнюю часть greenview на 16 пунктов выше верхней части red view с отрицательной константой:
`greenView.bottom == redView.top x 1.0 - 16.0`

### Constraint Attributes

[NSLayoutConstraint.Attribute](https://developer.apple.com/documentation/uikit/nslayoutconstraint/attribute) - часть визуального представления объекта, которая должна использоваться для получения значения constraint.

```swift
case left
Левая сторона прямоугольника выравнивания объекта.

case right
Правая сторона прямоугольника выравнивания объекта.

case top
Верхняя часть прямоугольника выравнивания объекта.

case bottom
Нижняя часть прямоугольника выравнивания объекта.

case leading
Передний край прямоугольника выравнивания объекта.

case trailing
Задний край прямоугольника выравнивания объекта.

case width
Ширина прямоугольника выравнивания объекта.

case height
Высота прямоугольника выравнивания объекта.

case centerX
Центр вдоль оси X прямоугольника выравнивания объекта.

case centerY
Центр по оси Y прямоугольника выравнивания объекта.

case lastBaseline
Базовая линия объекта.

case firstBaseline
Базовая линия объекта.

case leftMargin
Левое поле объекта.

case rightMargin
Правое поле объекта.

case topMargin
Верхнее поле объекта.

case bottomMargin
Нижнее поле объекта.

case leadingMargin
Ведущее поле объекта.

case trailingMargin
Задняя маржа объекта.

case centerXWithinMargins
Центр по оси x между левым и правым краями объекта.

case centerYWithinMargins
Центр по оси Y между верхним и нижним полями объекта.

case notAnAttribute
Значение-заполнитель, указывающее, что второй элемент constraint и второй атрибут не используются ни в каких вычислениях.
```

<img alt="image" src="images/auto layout31.jpeg" width = 35%/>

Используйте `.leading` и `.trailing` вместо `.left` и `.right` для поддержки языков справа налево (RTL). When using an RTL language the `.leading` edge is on the **right** and the `.trailing` edge is on the **left**.

you can align text on the first or last baseline:

<img alt="image" src="images/auto layout32.jpeg" width = 50%/>

View также имеет полный набор атрибутов полей margin для случаев, когда вы хотите вставить содержимое по краям представления view edges: 

<img alt="image" src="images/auto layout33.jpeg" width = 35%/>

We are using pseudo-code to write constraints in this
chapter, we’ll see the real syntax later

```swift
// Aligning the leading edges of views
redView.leading == greenView.leading

// Aligning view centers (x-axis)
redView.centerX == greenView.centerX

// Vertical spacing between views
redView.top == greenView.bottom + 8.0

// Two views with equal width
redView.width == greenView.width

// Height of view is half the height of another view
redView.height == 0.5 x greenView.height

// Red view is never wider than green view
redView.width <= greenView.width

// Aspect Ratio - соотношение сторон
greenView.height = 0.5 x greenView.width

// Setting a constant size
redView.height = 50.0
redView.width = 75.0
```

Interface Builder не позволяет вам создавать бессмысленные ограничения, но при создании ограничений в коде имейте в виду, что не все комбинации атрибутов имеют смысл

```swift
// ERROR - don't mix horizontal with vertical
redView.leading == greenView.bottom + 16.0

// ERROR - cannot mix size with edge or center
greenView.width == redView.leading

// ERROR - cannot set edge or center to a constant
redView.centerY = 100.0

// ERROR - don't mix leading/trailing with left/right
redView.left == greenView.trailing + 16.0
```

### Who Owns A Constraint?

Каждое view имеет свойство `constraints`, которое представляет собой массив constraints, принадлежащих этому view. Свойство доступно только для чтения:

`var constraints: [NSLayoutConstraint] { get }`

Rule: A constraint принадлежащее view может только включать само это view или его подвиды subviews.

Если вы создаете ограничение между двумя view, они должны иметь общий superview, чтобы владеть ограничением. Пример:

<img alt="image" src="images/auto layout34.jpeg" width = 40%/>

Распределение, кому принадлежат constraints

<img alt="image" src="images/auto layout35.jpeg" width = 60%/>

Let’s start with pinning a single view to the edges of its superview with some padding

<img alt="image" src="images/auto layout36.jpeg" width = 40%/>

First we can fix the position (origin) of the green view with leading and top constraints to the superview. I’m using 50 points for the padding. Adding trailing and bottom constraints fixes the size (width and height). So we needed four constraints, 2 horizontal + 2 vertical

```swift
greenView.leading == superview.leading + 50 // 1
greenView.top == superview.top + 50 // 2
superview.trailing == greenView.trailing + 50 // 3
superview.bottom == greenView.bottom + 50 // 4
```

Что, если вместо этого мы напрямую зафиксируем ширину и
высоту:

<img alt="image" src="images/auto layout37.jpeg" width = 40%/>

Replacing the trailing and bottom constraints with constant width and height constraints:

```swift
greenView.leading == superview.leading + 50 // 1
greenView.top == superview.top + 50 // 2
greenView.width == 567 // 3
greenView.height == 275 // 4
```

Что произойдет, если мы повернем устройство из альбомной ориентации в портретную?

<img alt="image" src="images/auto layout38.jpeg" width = 40%/>

!!! Использование постоянных constraints по ширине и высоте не позволяет view адаптироваться к изменениям размера его superview. По возможности избегайте добавления постоянных constraints по ширине и высоте для
ваших view. Предпочитайте делать их относительно
какого-либо другого измерения в вашем макете.

### Equal Sizing

<img alt="image" src="images/auto layout39.jpeg" width = 40%/>

constraint for the spacing between the two views:

`redView.leading == greenView.trailing + 50 // 3`

<img alt="image" src="images/auto layout40.jpeg" width = 40%/>

`greenView.width == redView.width // 8`


For example, replacing the top constraint (4) with a constraint
that aligns the tops of the green view and red view with each other:

`greenView.top == redView.top // 4`

We could also replace the bottom constraint (6) for the red view with an equal height constraint:

`greenView.height == redView.height // 6`

<img alt="image" src="images/auto layout41.jpeg" width = 40%/>

### Views With An Intrinsic (внутренним) Size

Если мы используем эту label в макете, нам нужно только добавить ограничения, чтобы зафиксировать положение. Механизм компоновки использует естественный размер метки, если на метку не действуют никакие другие ограничения по размеру. Итак, нужно два ограничениям для
фиксации положения

```swift
label.leading == superview.leading + 50 // 1
label.top == superview.top + 50 // 2
```

Мы, используем только два ограничения. Где находятся два других ограничения для фиксации размера? Когда мы
более подробно рассмотрим внутренний размер содержимого, мы увидим, что механизм компоновки добавляет дополнительные ограничения по ширине и высоте для нас, исходя из естественного размера метки. Таким образом, в этом макете по-прежнему используются два горизонтальных и два вертикальных ограничения.

<img alt="image" src="images/auto layout42.jpeg" width = 40%/>

Это прекрасно, но что, если мы хотим, чтобы метка
заполняла всю ширину экрана

<img alt="image" src="images/auto layout43.jpeg" width = 40%/>

```swift
label.leading == superview.leading + 50 // 1
label.top == superview.top + 50 // 2
superview.trailing == label.trailing + 50 // 3
```

Эти три ограничения позволяют увеличивать высоту надписи вниз по экрану по мере увеличения текста или размера шрифта.

---

to center this text label in the yellow view

```swift
textLabel.centerX == yellowView.centerX // 1
textLabel.centerY == yellowView.centerY // 2
```

<img alt="image" src="images/auto layout44.jpeg" width = 40%/>

---

Какое из этих ограничений расположило бы зеленый вид на 8 пунктов ниже желтого?

`yellowView.bottom = greenView.top - 8.0`

---

Match the constraints that describe the same relationship:

```swift
// Constraint A
greenView.leading == redView.trailing + 8.0
// Constraint C
redView.trailing == greenView.leading - 8.0

// and
// Constraint B
redView.leading == greenView.trailing + 8.0
// Constraint D
greenView.trailing == redView.leading - 8.0
```

---

[К оглавлению](#contents)

###  <a id="chapter4" /> Глава № 4. Using Interface Builder

### Constraints Tool
<img alt="image" src="images/auto layout45.jpeg" width = 50%/>

В каждом из полей с интервалами есть выпадающее меню, в котором вы можете выбрать один из возможных видов соседей. При создании интервала между двумя дочерними видами вы также можете выбрать использование “standard” интервала.

### Align Tool

Например, чтобы отцентрировать три кнопки по горизонтали в желтом superview.

<img alt="image" src="images/auto layout46.jpeg" width = 50%/>

### Control-Dragging In The Canvas

Вы можете быстро создать ограничение на холсте Interface Builder, перетащив элемент управления внутри элемента или между двумя элементами:

<img alt="image" src="images/auto layout47.jpeg" width = 60%/>

### Control-Dragging In The Document Outline

<img alt="image" src="images/auto layout48.jpeg" width = 60%/>

Когда вы создаете ограничение на leading, trailing, top or bottom интервал для root view, вы можете выбрать между safe area or margin  root view . Если вы хотите, чтобы constraint распространялось на края root view, вам нужно использовать инспектор атрибутов, чтобы отредактировать ограничение и переключиться с safe area to the superview

#### What About The Autoresizing Mask?

Что происходит с маской автоматического изменения размера (autoresizing mask), когда вы добавляете ограничения для view? Когда вы добавляете новое view в Interface Builder, у него нет ограничений. Он начинает с маски автоматического изменения размера с leading и top: 
Режим  layout в инспекторе размеров показывает вам, что делает Interface Builder. По умолчанию он делает вывод, что он должен использовать маску автоматического изменения размера (autoresizing mask), когда нет ограничений. Как только вы добавляете ограничение, связанное с представлением, режим компоновки меняется на “Inferred (Constraints)” и интерфейс отключает и скрывает маску. 
Это позволяет избежать любого конфликта между добавляемыми нами ограничениями и маской автоматического изменения размера.
Don’t try to mix constraints with autoresizing for the same view in Interface Builder

### Editing A Constraint

Мы можем кликнуть на constraint на холсте, и появится меню с изменениями, elation, the constant value, the priority, and the multiplier. И в боковом меню можно внести точные правки в constraint

<img alt="image" src="images/auto layout49.jpeg" width = 50%/>

1. В первом разделе показаны элементы, используемые ограничением, и вы можете изменить отношение. Выпадающие меню для первого и второго элементов позволяют вам изменить атрибут, используемый для ограничения, переключиться между margin or edge, поменять местами элементы или перейти к использованию superview or safe area:
2. Измените constant, priority or multiplier. Используйте [+] слева от константы, чтобы добавить изменение.
3. Добавьте идентификатор для этого ограничения, который отображается в журналах. 
4. Interface Builder не включает placeholder constraints в созданное вами приложение. Вы можете использовать их, чтобы избежать предупреждений Interface Builder об отсутствующих constraints, которые вы хотите добавить во время выполнения.
5. Снимите флажок “Installed” для constraints, которые вы хотите активировать во время выполнения, или установите только для некоторых вариантов характеристик. 

### Creating Outlets For Constraints

<img alt="image" src="images/auto layout50.jpeg" width = 70%/>

You can also create the property yourself in the view controller. Mark it with `@IBOutlet` and then right-click on the view controller in the document outline and drag from the outlet to the constraint:

<img alt="image" src="images/auto layout51.jpeg" width = 70%/>

Once created there are limited changes you can make to a constraint in your code. You can activate or deactivate it, change the priority, or change the constant:

```swift
// Deactivate a constraint
centerXConstraint.isActive = false

// Change priority
centerXConstraint.priority = .defaultLow

// Change constant value
centerXConstraint.constant = 50.0
```

You cannot change the items or attributes involved in the constraint, the relation or the multiplier.

---

Add a constraint that gives the red and green views equal height:
1. Control-drag from the red view to the green view (or наоборот) in the canvas or document outline and choose Equal Heights

<img alt="image" src="images/auto layout52.jpeg" width = 40%/>

<img alt="image" src="images/auto layout54.jpeg" width = 70%/>

---

Centering The Buttons

<img alt="image" src="images/auto layout53.jpeg" width = 50%/>

---

### Полезный функционал 

Чтобы выделить объект, когда он находится за стопкой других элементов, удерживайте нажатой клавиши
`Control + Shift`, а затем щелкните по объекту. Выберите нужный элемент во всплывающем меню, отображающем полный вид иерархии

<img alt="image" src="images/auto layout55.jpeg" width = 35%/>

Нажмите на вид на холсте, чтобы выбрать его, а затем удерживайте нажатой клавишу `Option`. Наведите указатель мыши на другие виды сцены, чтобы увидеть расстояния между views

To quickly copy an object in the canvas, hold down the `Option` key and then click on and drag the object.

When adjusting the position of a view in the canvas, the arrow keys move the view one point at a time. Hold the `Shift` key to move by five points at a time.

When creating constraints in the canvas or document outline use the `Shift` key to add multiple constraints

There are some configuration options for the canvas in the Xcode
`Editor › Canvas` menu:

<img alt="image" src="images/auto layout56.jpeg" width = 70%/>

Не позволяйте вашим storyboards становиться слишком большими. Interface Builder замедляет работу, и если вы сотрудничаете с другими разработчиками, становится все
труднее избегать конфликтов. Используйте редактор  `Editor › Refactor To Storyboard`, чтобы разбить ее на более мелкие сцены со ссылками на раскадровку.

Используйте `Cmd + =`, чтобы изменить размер метки, кнопки, изображения и т.д. чтобы соответствовать размеру содержимого

Вы можете просмотреть свой макет на разных устройствах и
в разных ориентациях в Interface Builder. Получите доступ к предварительному просмотру `Editor › Preview`. Предварительный просмотр происходит намного быстрее, чем запуск симулятора или запуск на устройстве. Используйте `[+]` в левом нижнем углу окна, чтобы добавить устройства.

### Challenge 4.1 - Nested View Layout

Чтобы сделать высоту одного view в процентах % от высоты другого view, требуется выполнить два шага. Сначала вам нужно создать constraint равной высоты между двумя view. Затем отредактируйте constraint, чтобы изменить
множитель на требуемую пропорцию

<img alt="image" src="images/auto layout57.jpeg" width = 70%/>

### Challenge 4.2 - Sibling View Layout

Просто добавляем constraints для каждого view по всем сторонам, и приравниваем heights и все. Выставлять margins, приоритеты и общие настройки это ошибочный путь решения

<img alt="image" src="images/auto layout58.jpeg" width = 70%/>

### Challenge 4.3 - Proportional Centering

Button “1” is at 0.5 the center of the safe area. Button “2” is at the center. Button “3” is at 1.5 the center of the safe area.

<img alt="image" src="images/auto layout59.jpeg" width = 70%/>

### Challenge 4.4 Changing Constraints

В storyboard мы задаем одно положение кнопки, затем при ее нажатии задается другое положение и она опускается. 

<img alt="image" src="images/auto layout60.jpeg" width = 70%/>

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func button(_ sender: UIButton) {
        centerConstraint.constant = 0
    }
}
```

---

[К оглавлению](#contents)

###  <a id="chapter5" /> Глава № 5. Creating Constraints In Code

Apple gives you three choices when it comes to creating your constraints in code:
- Use the `NSLayoutConstraint class`.
- Use the Visual Format Language.
- Use Layout Anchors.

The old `addConstraint` and `removeConstraint` methods не нужно использовать.

### Ключевые понятия главы

- Add your views to the view hierarchy **before** activating their constraints.
- Activate and deactivate your constraints. Don’t use the old add and remove constraint methods (`addConstraint` and `removeConstraint`).
- Use the `NSLayoutConstraint` class methods to activate and deactivate your constraints in batches. It’s faster and you’re less likely to miss setting `isActive` on a constraint:

```swift
NSLayoutConstraint.activate([
// constraints
])
```

- Using `removeFromSuperview` to remove a view from the view hierarchy also removes any constraints involving that view or any of its subviews.
- Hiding a view doesn’t deactivate its constraints.
- Don’t forget to disable the translation of the autoresizing mask into constraints when you create a view in code:
`translatesAutoresizingMaskIntoConstraints = false`
- Use **layout anchors** when creating your constraints in code.

---

Pаспространенная ошибка - активировать ограничение между двумя subviews до того, как вы добавите их оба в иерархии представлений. Это вызывает ошибку времени выполнения, потому что нет общего superview, которому принадлежало бы ограничение. Не забудьте добавить оба
views в одну и ту же иерархию view, прежде чем активировать ограничение.

When you create a constraint in code, it’s inactive by default. Неактивные ограничения не имеют собственного view , поэтому механизм компоновки их не видит. `isActive` property.

`widthConstraint.isActive = true`

Установка `isActive` в значение `true` добавляет ограничение к массиву ограничений ближайшего общего superview views, задействованного в ограничении.
В этот момент ограничение становится видимым для механизма компоновки при расчете макета.
Установка `isActive` в значение `false` удаляет ограничение из списка ограничений массивa , и ограничение больше не влияет на макет

`redView.widthAnchor.constraint(equalTo: greenView.widthAnchor).isActive = true`

The `NSLayoutConstraint` class has a better way to activate a group of constraints.

```swift
NSLayoutConstraint.activate([ redView.widthAnchor.constraint(equalTo: greenView.widthAnchor),

redView.heightAnchor.constraint(equalTo: greenView.heightAnchor), // other constraints...
])
```

There’s a similar method to deactivate a group of constraints:

```swift
NSLayoutConstraint.deactivate(constraints)
```

### Disabling The Autoresizing Mask

Маска автоматического изменения размера (Autoresizing Mask) view определяет, как изменяются его размер и
положение при изменении размера superview. Возможно, вы удивитесь, узнав, что под обложкой маска автоматически преобразуется в набор Auto Layout constraints. Если мы не будем осторожны, эти автоматически созданные constraints могут вступить в конфликт с нашими constraints.

When you create a view in code, you need to выключить the mask yourself if you want to add constraints for that view:

```swift
let myView = UIView()
myView.translatesAutoresizingMaskIntoConstraints = false
```

Иначе будет ошибка данного типа

```swift
Frames[93001:7847043] [LayoutConstraints] Unable to simultaneously satisfy constraints.
...
("<NSAutoresizingMaskLayoutConstraint:0x60c0000888e0 h=&-&v=&-& UIView:0x7f846e3135f0.width == 168 (active)>",
...
)
```

### Creating Constraints With NSLayoutConstraint (не рекомендуется)

Наиболее неприятный способ создания ограничения.
Использование инициализатора `NSLayoutConstraint`:

```swift
    NSLayoutConstraint(item: view1,
    attribute: attr1,
    relatedBy: relation,
    toItem: view2,
    attribute: attr2,
    multiplier: m,
    constant: c)
```

Возвращает неактивное ограничение между двумя элементами (view1 и view2). Ограничение создает связь между атрибутом первого view и атрибутом второго view. Отношение может быть `.equal`, `.lessThanOrEqual` or `.greaterThanOrEqua`, поэтому ограничение является одним из этих отношений:

```swift
view1.attr1 == view2.attr2 x m + c
view1.attr1 <= view2.attr2 x m + c
view1.attr1 >= view2.attr2 x m + c
```

Если ограничение предназначено для одного элемента, используйте nil, `notAnAttribute` для второго элемента и атрибута:

```swift
// redView.width == 150.0
NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, 

attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0)
```

<img alt="image" src="images/auto layout61.jpeg" width = 50%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let padding: CGFloat = 50.0
    private let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(redView)

        NSLayoutConstraint.activate([
            // redView.leading == view.leading + padding
            NSLayoutConstraint(item: redView, attribute: .leading, relatedBy: .equal, toItem: view, 
            attribute: .leading, multiplier: 1.0, constant: padding),

            // view.trailing == redView.trailing + padding
            NSLayoutConstraint(item: view!, attribute: .trailing, relatedBy: .equal, toItem: redView, 
            attribute: .trailing, multiplier: 1.0, constant: padding),

            // redView.top == view.top + padding
            NSLayoutConstraint(item: redView, attribute: .top, relatedBy: .equal, toItem: view, 
            attribute: .top, multiplier: 1.0, constant: padding),

            // view.bottom = redView.bottom + padding
            NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: redView, 
            attribute: .bottom, multiplier: 1.0, constant: padding)
        ])
    }
}
```

`var view: UIView!` опционал, рекомендуется не использовать вообще это старое API

### Visual Format Language (не рекомендуется)

Язык визуального формата (VFL) позволяет вам записывать ограничения, используя строку формата в стиле ASCII-art. Это позволяет вам создать набор constraints более лаконично и визуально. Это не лучше чем обычный инициализатор NSLayoutConstraint выше

To create constraints with VFL you use the `NSLayoutConstraint` class method `constraints(withVisualFormat:options:metrics:views:)`. It returns an array of constraints we can then activate:

```swift
NSLayoutConstraint.constraints(
withVisualFormat format: String,
options opts: NSLayoutFormatOptions = [],
metrics: [String : Any]?,
views: [String: Any])
```

Take a look at the format string: `"H|-(padding)-[redView]-(padding)-|"`. The views всегда заключены в квадратные скобки. Вертикальные полосы ( | ) - это края superview, а -
ограничение интервала. Константа для интервала указана в круглых скобках и взята из словаря метрик. 

The format `redView(==greenView)` делает высоту красного вида равной высоте зеленого вида

<img alt="image" src="images/auto layout62.jpeg" width = 50%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(redView)
        view.addSubview(greenView)

        /*
         Build a dictionary of the views we will use when creating
         constraints. The dictionary keys are the strings we use
         in the VFL format string when creating the constraints.
         */
        let views = [
            "redView" : redView,
            "greenView" : greenView
        ]

        /*
         Build a dictionary of any magic numbers we use in the visual
         format string.
         */
        let metrics = [
            "padding" : 50.0,
            "spacing" : 25.0
        ]

        /*
         Create the horizontal constraints that pin the red and green view leading and
         trailing edges to the root view.

         + The `|` represents the edge of the super view.
         */
        let hRedConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[redView]-(padding)-|",
        options: [], metrics: metrics, views: views)

        let hGreenConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[greenView]-(padding)-|",
        options: [], metrics: metrics, views: views)

        /*
         Create the vertical constraints
         */
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: 
        "V:|-(padding)-[redView(==greenView)]-(spacing)-[greenView]-(padding)-|", 
        options: [], metrics: metrics, views: views)

        let constraints = hRedConstraints + hGreenConstraints + vConstraints
        NSLayoutConstraint.activate(constraints)
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
```

### Layout Anchors

The `NSLayoutAnchor` class is a factory class for creating
`NSLayoutConstraint` objects using a fluent API. Use these
constraints to programatically define your layout using Auto Layout.

UIView имеет anchor макета для каждого из атрибутов ограничения. Каждый anchor макета является подклассом `NSLayoutAnchor` с методами для непосредственного создания ограничений для других anchors макета того
же типа.
Вы не используете класс `NSLayoutAnchor` напрямую. Вместо этого вы используете один из его подклассов в зависимости от того, хотите ли вы создать ограничение по горизонтали, вертикали или размеру

### Horizontal Constraints

Use layout anchors of type `NSLayoutXAxisAnchor` to create horizontal constraints:
- `centerXAnchor`
- `leadingAnchor` and `trailingAnchor`
- `leftAnchor` and `rightAnchor`

For example, to create a constraint that center aligns two views:

`redView.centerXAnchor.constraint(equalTo: greenView.centerXAnchor)`

Prefer the `leadingAnchor` and `trailingAnchor` over the `leftAnchor` and `rightAnchor`. The leading and trailing anchors are aware of Right-To-Left (RTL) languages and
flip the interface when necessary.

### Vertical Constraints

Use layout anchors of type `NSLayoutYAxisAnchor` to create vertical constraints:
- `centerYAnchor`
- `bottomAnchor` and `topAnchor`
- `firstBaselineAnchor` and `lastBaselineAnchor`

Например, чтобы создать constraint, которое помещает верхнюю часть top greenView на 25 пунктов ниже bottom redView:

`greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 25)`

### Size Based Constraints
Use layout anchors of type `NSLayoutDimension` to create size-based constraints:
- `heightAnchor` and `widthAnchor`

For example, to create a constraint that fixes the width of a view to 50 points:

`redView.widthAnchor.constraint(equalToConstant: 50.0)`

To make the height of redView twice the height of greenView:

`redView.heightAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: 2.0)`

### Creating Constraints With Layout Anchors

```swift
// anchor (==, >=, <=) otherAnchor
anchor.constraint(equalTo:otherAnchor)
anchor.constraint(greaterThanOrEqualTo:otherAnchor)
anchor.constraint(lessThanOrEqualTo:otherAnchor)

// anchor == otherAnchor + constant
anchor.constraint(equalTo:otherAnchor constant:8.0)

// dimensionAnchor == otherDimensionAnchor * multiplier, dimension - размер
widthAnchor.constraint(equalTo:otherWidthAnchor,
multiplier:2.0)

// dimensionAnchor == otherDimensionAnchor * multiplier + constant
widthAnchor.constraint(equalTo:otherWidthAnchor, multiplier:1.0, constant:20.0)
```

Несколько удобных методов, которые используют
стандартный системный интервал (standard system spacing) вместо constant. Для горизонтальных ограничений
существует три метода определения стандартного системного интервала после anchor:

```swift
constraint(equalToSystemSpacingAfter anchor:multiplier:)

constraint(greaterThanOrEqualToSystemSpacingAfter anchor:multiplier:)

constraint(lessThanOrEqualToSystemSpacingAfter
anchor:multiplier:)
```

The multiplier применяется к системному интервалу spacing. Например, расположить greenView горизонтально с интервалом, в два раза превышающим системный, после redView

```swift
greenView.leadingAnchor.constraint(equalToSystemSpacingAfter: 
redView.trailingAnchor, multiplier: 2.0)
```

Аналогичный набор методов охватывает вертикальные ограничения, создающие standard spacing ниже anchor. Например, blueView со стандартным интервалом ниже redView:

```swift
blueView.topAnchor.constraint(equalToSystemSpacingBelow:
redView.bottomAnchor, multiplier: 1.0)
````

Вы можете создавать ограничения только между anchors одного и того же типа.  Компилятор проверяет это, чтобы предотвратить создание вами бессмысленных constraints. Например, создание constraint между leading anchor and a bottom anchor is an error:

```swift
redView.leadingAnchor.constraint(equalTo:
view.bottomAnchor)
```

```bash
Cannot convert value of type
'NSLayoutAnchor<NSLayoutYAxisAnchor>' 
to expected argument type 'NSLayoutAnchor<NSLayoutXAxisAnchor>'
````

### A Layout Anchor Example

<img alt="image" src="images/auto layout62.jpeg" width = 50%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
````

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let padding: CGFloat = 50.0
    private let spacing: CGFloat = 25.0

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(redView)
        view.addSubview(greenView)

        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),

            view.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: padding),

            redView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: spacing),

            view.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: padding),

            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor)
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
````

---

### Какой способ добавления constraints выбрать?

**NSLayoutConstaint** наиболее подробный и наименее читаемым способом создания constraints. Здесь нет безопасности типов, поэтому легко допустить ошибки.

**Visual Format Language** более лаконичен и удобочитаем, но необходимость настройки словарей view и метрик сопряжена с трудностями. Apple не обновляет его, и не расширила его для поддержки новых концепций, таких как поля макета и безопасная зона.

**Layout anchors** самый безопасный и удобный формат. Рекомендуется

### Constraints In A Custom View. Example app

<img alt="image" src="images/auto layout62.jpeg" width = 50%/>

Name the our custom view class StopGoView, make sure it’s a subclass of `UIView`.

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
````

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let stopGoView: StopGoView = {
        let view = StopGoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(stopGoView)

        NSLayoutConstraint.activate([
            stopGoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stopGoView.topAnchor.constraint(equalTo: view.topAnchor),
            stopGoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stopGoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
````

StopGoView.swift
```swift
import UIKit

final class StopGoView: UIView {
    private let padding: CGFloat = 50.0
    private let spacing: CGFloat = 25.0

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        addSubview(redView)
        addSubview(greenView)

        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),

            trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: padding),

            redView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: spacing),
            bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: padding),

            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor)
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
````

---

### Challenge 5.1 Nested View Layout

<img alt="image" src="images/auto layout63.jpeg" width = 60%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
````

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let externalPadding: CGFloat = 50.0
    private let internalSpacing: CGFloat = 25.0

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(greenView)
        greenView.addSubview(redView)

        NSLayoutConstraint.activate([
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: externalPadding),
            greenView.topAnchor.constraint(equalTo: view.topAnchor, constant: externalPadding),
            view.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: externalPadding),
            view.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: externalPadding),

            redView.leadingAnchor.constraint(equalTo: greenView.leadingAnchor, constant: internalSpacing),
            greenView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: internalSpacing),
            redView.centerYAnchor.constraint(equalTo: greenView.centerYAnchor),
            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: 0.2)
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
````

---

### Challenge 5.2 The Tile View

<img alt="image" src="images/auto layout64.jpeg" width = 50%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let padding: CGFloat = 50.0
    // for height 25%
    private let tileProportion: CGFloat = 0.25

    private let tileView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(tileView)

        NSLayoutConstraint.activate([
            tileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tileView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: padding),
            tileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: tileProportion)
            ])
    }
}
```

TileView.swift
```swift
import UIKit

final class TileView: UIView {
    private let padding: CGFloat = 25.0

    private let blueView = UIView.makeView(color: .blue)
    private let redView = UIView.makeView(color: .red)

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

        NSLayoutConstraint.activate([
            blueView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            blueView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            redView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: redView.bottomAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: padding),

            redView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: padding),
            redView.widthAnchor.constraint(equalTo: blueView.widthAnchor)
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
```

---

[К оглавлению](#contents)

###  <a id="chapter6" />Глава 6. Safe Areas And Layout Margins

### Key Points To Remember
If you’re only supporting iOS 11 or later:
- Create constraints to the safe area layout guide of the superview for content subviews that you don’t want to be covered by bars or clipped by the rounded corners of an iPhone X style device.
- If you want some extra padding inside the safe area create your
constraints to the margins of the superview. (Margins allow for the safe area by default in iOS 11).
- Use the directional layout margins for right-to-left language support. `directionalLayoutMargins` - интервал по умолчанию, используемый при размещении содержимого в view с учетом текущего направления языка (current language direction).
- You can change the margins of the root view.

If you need to support iOS 9 or iOS 10:
- If you create your layout in Interface Builder you can continue to
constrain your content to the safe area layout guide. Interface Builder takes care of making this backward compatible for iOS 9 and iOS 10.
- If you create your constraints in code you need to take care of falling back to using the top and bottom layout guides and leading and trailing edges when the safe area layout guide is not available.
- Remember that margins don’t take into account the top and bottom layout guides in iOS 9 and iOS 10. If you constrain your content to a margin, a parent view may cover your content.
- You cannot change the margins of the root view.

In both cases:
-  Create constraints to the edges of the superview for background subviews where you don’t care if something clips or covers the view. For example, a background image that you want to fill the screen.

### Safe Area Layout Guide

Apple added safe area layout guides in iOS 11 to define a rectangle safe for you to show content. The status, navigation, and tab bars never не перекрывают the safe area.

Example: [iPhone 14 Screen Sizes](https://useyourloaf.com/blog/iphone-14-screen-sizes/)

<img alt="image" src="images/iPhone 14 Pro Max.jpeg" width = 50%/>


<img alt="image" src="images/iPhone 14.jpeg" width = 50%/>

The safe area layout guide is a property of the view. It’s a UILayoutGuide with a layoutFrame and a set of layout anchors that mark out the safe area of the view. В общем, вы хотите сохранить свой контент в безопасной зоне. При использовании Auto Layout вы создаете свои ограничения для привязок layout anchors. Например, чтобы привязать leading and trailing edges краям безопасной области safe area of a view:

```swift
let guide = view.safeAreaLayoutGuide
redView.leadingAnchor.constraint(equalTo: guide.leadingAnchor)
redView.trailingAnchor.constraint(equalTo:
guide.trailingAnchor)
```

The `safeAreaInsets` property of UIView дает вам размер безопасной области, вставленной от края view. Если view полностью находится внутри безопасной области, в нем нет вставок.

```swift
// UIEdgeInsets
let safeInsets = view.safeAreaInsets
```

View должно быть загружено и выведено на экран, чтобы установить его безопасную область (поэтому не полагайтесь на вставки в `viewDidLoad`). Вы не можете изменить руководство по компоновке безопасной зоны (safe area
layout) или вставки безопасной зоны (safe area insets). Чтобы увеличить размер безопасной области для view controller, используйте свойство `additionalSafeAreaInsets`. Например, увеличить верхнюю вставку, чтобы создать пользовательскую панель инструментов-toolbar:

```swift
additionalSafeAreaInsets = UIEdgeInsets(top: toolbarHeight, left: 0, bottom: 0, right: 0)
```

If your view controller needs to know when the safe area changes use the view controller method `viewSafeAreaInsetsDidChange()` or in a custom view use `safeAreaInsetsDidChange()`

### Using The Safe Area With Interface Builder 

<img alt="image" src="images/auto layout65.jpeg" width = 70%/>

You can also control-drag diagonally in the canvas from the red
view to the yellow root view.

В режиме радактирования constraint можно сменить на superview игнорируя рамки safe area

### Using The Safe Area In Code

<img alt="image" src="images/auto layout66.jpeg" width = 60%/>

The safe area layout guide is a property of the view
`let guide = view.safeAreaLayoutGuide`

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let rootViewController = ViewController()
        rootViewController.title = NSLocalizedString("Title", comment: "Title")
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
```

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let externalPadding: CGFloat = 50.0
    private let internalSpacing: CGFloat = 25.0

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(redView)
        view.addSubview(greenView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: externalPadding),
            greenView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: externalPadding),

            guide.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: externalPadding),
            guide.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: externalPadding),

            redView.topAnchor.constraint(equalTo: guide.topAnchor, constant: externalPadding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: internalSpacing),

            guide.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: externalPadding),

            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor)
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
```

### Проверка наличия safe area

Плохая новость, если вы создаете свой макет в коде, заключается в том, что вам нужно самостоятельно справиться с этим резервным вариантом, проверив доступность. Давайте изменим для нашего последнего проекта на iOS 9

Мы используем руководство safe area layout guide, которое недоступно до iOS 11. Следующая строка кода больше не будет компилироваться:

`let guide = view.safeAreaLayoutGuide`

Чтобы исправить это, мы можем протестировать доступность iOS 11 перед использованием
safe area layout guide. В противном случае мы возвращаемся к созданию ограничений с помощью верхних и нижних направляющих компоновки (устаревшие свойства, для старых версий ios).

Example:
```swift
if #available(iOS 11.0, *) {
  // Running iOS 11 OR NEWER
} else {
  // Earlier version of iOS
}

// or
if #available(iOS 11, *) {
let guide = view.safeAreaLayoutGuide
  // Create constraints using safe area
} else {
  // fallback to top and bottom layout guides
  // and leading and trailing edges.
}
```

UIViewController+SafeAnchor.swift. Вычисляются доступные constraints и далее в ViewController.swift они будут применены в `NSLayoutConstraint.activate([ ...])`

```swift
import UIKit

@available(iOS 7.0, tvOS 9.0, *)
public extension UIViewController {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return topLayoutGuide.bottomAnchor
        }
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomLayoutGuide.topAnchor
        }
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.leadingAnchor
        } else {
            return view.leadingAnchor
        }
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.trailingAnchor
        } else {
            return view.trailingAnchor
        }
    }
}
```

ViewController.swift

```swift
import UIKit

final class ViewController: UIViewController {
    private let externalPadding: CGFloat = 50.0
    private let internalSpacing: CGFloat = 25.0

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(redView)
        view.addSubview(greenView)

        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: safeTopAnchor, constant: externalPadding),
            safeBottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: externalPadding),
            redView.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: externalPadding),
            greenView.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: externalPadding),
            safeTrailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: externalPadding),
            safeTrailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: externalPadding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: internalSpacing),
            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor)
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
```

<img alt="image" src="images/auto layout66.jpeg" width = 50%/>

### Layout Margins

The `layoutMarginsGuide` property of a view is a layout guide with the usual set of layout anchors for creating constraints with the margin (краям/полям) of the view. 

Благодаря Shift можно выбрать несколько constraints, удерживая клавишу Option мы переключаем значения constraints на значение с margins и выбираем нужные

<img alt="image" src="images/auto layout67.jpeg" width = 50%/>

<img alt="image" src="images/auto layout68.jpeg" width = 50%/>

Ты можешь отключить safe area относительные margins for a view with the Size Inspector in Interface Builder. The default setting is enabled "Safe Area Relative Margins"

In code use the `insetsLayoutMarginsFromSafeArea` property of the view:
```swift
if #available(iOS 11, *) {
    // default is true
    view.insetsLayoutMarginsFromSafeArea = false
}
```

### Changing The Size Of Margins
A new `UIView` has default layout margins by 8 points on
all sides. You can change the default margin for a view using the size inspector in Interface Builder "Layout Margins"

You have two choices depending on whether you need to deploy to targets earlier than iOS 11 - “Fixed” or “Language Directional”

If you need to support iOS 10 or earlier use the “Fixed” layout margins to set left, top, right and bottom insets (`UIEdgeInsets`)

If your minimum deployment target is iOS 11 use the “Language Directional” layout margins which replace the left and right insets with leading and trailing insets (`NSDirectionalEdgeInsets`)

example with Interface Builder

<img alt="image" src="images/auto layout69.jpeg" width = 70%/>

### Changing The Root View Margins (iOS 11)

В отличие от других views, система управляет margins of a view controller’s root view. По умолчанию он устанавливает минимальные левое и правое поля 16 или 20 точек в зависимости от ширины view. Верхнее и нижнее поля
по умолчанию равны нулю.

Начиная с iOS 11, вы можете изменять layout margins в root view и контролировать, устанавливает ли система minimum margin. Свойство `systemMinimumLayoutMargins` view controller задает минимальные системные поля:

```swift
// iPhone X (iOS 11) portrait
print(systemMinimumLayoutMargins)
NSDirectionalEdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0)
```

Set `viewRespectsSystemMinimumLayoutMargins` to false in the view controller if you want a margin less than the system minimum. 

```swift
if #available(iOS 11, *) {
    viewRespectsSystemMinimumLayoutMargins = false
    view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
}
```

### Using Margins In Programmatic Layouts

<img alt="image" src="images/auto layout70.jpeg" width = 50%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: 
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
// внутреннее поле в red view
    private let margin: CGFloat = 50.0

    private let nestedView: NestedView = {
        let view = NestedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(nestedView)
        changeNestedMargins(inset: margin)

        NSLayoutConstraint.activate([
            nestedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nestedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nestedView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            nestedView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
    }

    private func changeNestedMargins(inset: CGFloat) {
        nestedView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: inset, leading: inset, 
        bottom: inset, trailing: inset)
    }
}

    /* or for support ios 9 and early version
    private func changeNestedMargins(inset: CGFloat) {
        if #available(iOS 11, *) {
            nestedView.directionalLayoutMargins =
            NSDirectionalEdgeInsets(top: inset, leading: inset,
                                    bottom: inset, trailing: inset)
        } else {
            nestedView.layoutMargins = UIEdgeInsets(top: inset,
                                                    left: inset, bottom: inset, right: inset)
        }
    }
     */
```

NestedView.swift
```swift
import UIKit

final class NestedView: UIView {
    var nestedColor: UIColor = .green {
        didSet {
            nestedView.backgroundColor = nestedColor
        }
    }

    private lazy var nestedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = nestedColor
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
        addSubview(nestedView)
        NSLayoutConstraint.activate([
            nestedView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nestedView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            nestedView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            nestedView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
    }
}
```

### Layout Guides

Использование скрытых разделителей spacer или фиктивных views - это хорошо используемый метод компоновки для управления расстоянием между views или группами views компоновки layout. Недостатком является то, что разделительные views по-прежнему являются реальными views в иерархии views, потребляющими память и способными реагировать на события. Введение
класса `UILayoutGuide` в iOS 9 позволяет нам выполнять ту же работу без накладных расходов. К сожалению, вы не можете создавать руководства по компоновке в Interface Builder


<img alt="image" src="images/auto layout71.jpeg" width = 70%/>

### Equal Spacing With Layout Guides

Create the three layout guides, т.е наши фиктивные view для пространства. In setupView:

```swift
let leadingGuide = UILayoutGuide()
let middleGuide = UILayoutGuide()
let trailingGuide = UILayoutGuide()
```

Remember that layout guides are not part of the view hierarchy. **! We don’t add them to the view hierarchy with `addSubview`**. Use the `addLayoutGuide` method to add the guides to the root view:

```swift
view.addLayoutGuide(leadingGuide)
view.addLayoutGuide(middleGuide)
view.addLayoutGuide(trailingGuide)
```

<img alt="image" src="images/auto layout72.jpeg" width = 35%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, 
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private lazy var cancelButton: UIButton = {
        let title = NSLocalizedString("Cancel", comment: "Cancel button")
        let button = UIButton.customButton(title: title, titleColor: .white, tintColor: .red, 
        background: UIImage(named: "buttonTemplate"))
        button.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var okButton: UIButton = {
        let title = NSLocalizedString("OK", comment: "OK buton")
        let button = UIButton.customButton(title: title, titleColor: .white, tintColor: .green, 
        background: UIImage(named: "buttonTemplate"))
        button.addTarget(self, action: #selector(okAction(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(cancelButton)
        view.addSubview(okButton)

        let leadingGuide = UILayoutGuide()
        let middleGuide = UILayoutGuide()
        let trailingGuide = UILayoutGuide()

        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)

        NSLayoutConstraint.activate([

// leading layout guide which controls the space
// between the leading edge and the cancel button
            view.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor),
            leadingGuide.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor),

// Add constraints for the middle guide
// to set the spacing between the two buttons
            cancelButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor),
            middleGuide.trailingAnchor.constraint(equalTo: okButton.leadingAnchor),

// trailing layout guide for the space between 
// the OK button and the trailing edge
            okButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor),
            trailingGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            cancelButton.widthAnchor.constraint(equalTo: okButton.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor),

            cancelButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            okButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
}

extension ViewController {
    @objc private func cancelAction(_ sender: UIButton) {
        print("Cancel")
    }

    @objc private func okAction(_ sender: UIButton) {
        print("OK")
    }
}

extension UIButton {
    static func customButton(title: String, titleColor: UIColor, tintColor: UIColor, background: UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.setBackgroundImage(background, for: .normal)
        button.tintColor = tintColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }
}
```

Обратите внимание, что в отличие от spacer views в Interface Builder, мы не заботимся о фиксации высоты и вертикального положения layout guides, поскольку ни то, ни другое не влияет на наш макет.

### Keyboard Layout Guide

`UIKeyboardLayoutGuide` 

<img alt="image" src="images/auto layout73.jpeg" width = 60%/>

Настройка макета для использования клавиатуры означает регистрацию для получения уведомлений notifications, которые сообщают вам, когда система показывает или скрывает клавиатуру. Мы увидим пример использования уведомлений с клавиатуры для перемещения содержимого в сторону от клавиатуры, когда рассмотрим виды прокрутки scroll views (содержимое поднимается/опускается при отображении/скрытии клавиатуры ). Ограничив constraining our views to the keyboard layout guide, нам теперь больше не нужно прослушивать уведомления с клавиатуры или вручную корректировать нашу layout.
В простых ситуациях нам может потребоваться constrain the bottom нашего view содержимого как top anchor of the keyboard layout guide:

```swift
contentView.bottomAnchor.constraint(equalTo:
view.keyboardLayoutGuide.topAnchor)
```

!!! В iOS 15 (релиз данного функционала) встречались многие баги по работе с `UIKeyboardLayoutGuide`, возможно они актуальны и сейчас. 

### Adding A Toolbar Above The Keyboard

<img alt="image" src="images/auto layout74.jpeg" width = 70%/>

By default, the keyboard layout guide does не отслеживает незакрепленную плавающую floating keyboard (данная фича есть в ipad).

[Пример кода](https://github.com/kharrison/ALBookCode/tree/main/sample-code/safe-areas-layout-margins/Keyboard-v1/)

AppDelegate.swift
```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
}
```

SceneDelegate.swift
```swift
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
}
```

toolbar -> it’s a custom view built with a horizontal stack view containing three buttons

Toolbar.swift
```swift
import UIKit

final class Toolbar: UIView {
    private lazy var favouriteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart", 
        withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let button = UIButton(configuration: config, primaryAction: UIAction { _ in
            print("Favourite")
        })
        return button
    }()

    private lazy var editButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "square.and.pencil", 
        withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let button = UIButton(configuration: config, primaryAction: UIAction { _ in
            print("Edit")
        })
        return button
    }()

    private lazy var deleteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let button = UIButton(configuration: config, primaryAction: UIAction { _ in
            print("Delete")
        })
        button.role = .destructive
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [favouriteButton, editButton, deleteButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGroupedBackground
        stackView.layer.cornerRadius = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
```

RootViewController.swift здесь 2 простых constraints в NSLayoutConstraint, ниже еще один пример, с изменениями

```swift
import UIKit

final class RootViewController: UIViewController {
    private lazy var toolbar: Toolbar = {
        let toolbar = Toolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
       
    private func setupView() {
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            toolbar.centerXAnchor.constraint(equalTo: view.keyboardLayoutGuide.centerXAnchor)
        ])
    }
}
```

### Tracking The Undocked Keyboard

Чтобы сохранить toolbar панель инструментов с отстыкованной клавиатурой undocked keyboard, нам нужно настроить руководство по раскладке клавиатуры для отслеживания отстыкованной клавиатуры:

`view.keyboardLayoutGuide.followsUndockedKeyboard = true`

Наши исправленные ограничения, привязывающие панель инструментов к top centre of the layout guide, почти выполняют свою работу. Панель инструментов прилипает к верхней части отсоединенной клавиатуры, когда мы перемещаем ее по экрану. Однако есть некоторые проблемы. Панель инструментов исчезает за кадром, когда клавиатура находится в верхней части экрана. Более серьезная проблема возникает, когда мы разделяем
экран iPad

Направляющая клавиатуры соответствует области клавиатуры, которая закрывает вид пользователя. По мере перемещения клавиатуры по разделителю разделенного экрана ширина направляющей уменьшается до нуля. Это проблема, поскольку я ограничил панель инструментов центром направляющей клавиатуры.

Проблема с отстыкованной плавающей клавиатурой заключается в том, что нет единого набора ограничений, которые будут работать при перемещении клавиатуры по
экрану. Что нам нужно, так это адаптивные adaptive constraints, которые активируются в зависимости
от положения клавиатуры.

### Adaptive Keyboard Constraints

The `UIKeyboardLayoutGuide` is more than your usual layout guide. It’s a subclass of `UITrackingLayoutGuide` which can automatically activate and deactivate constraints depending on how near (or far) it is from an edge.

Вы не активируете/деактивируете ограничения самостоятельно. Вместо этого вы передаете свои ограничения одному из двух методов:

```swift
// Add tracked constraints to guide
setConstraints(_:activeWhenNearEdge:)
setConstraints(_:activeWhenAwayFrom:)
```

Оба эти метода принимают массив ограничений и `NSDirectionalRectEdge`.  The tracking guide автоматически активирует или деактивирует ограничения, когда направляющая приближается к указанным краям (leading, trailing, top, bottom) или удаляется от них.

<img alt="image" src="images/auto layout75.jpeg" width = 80%/>

```swift
// Constraints when near top edge
view.keyboardLayoutGuide.setConstraints([nearTop],
                                        activeWhenNearEdge: .top)
                                        
// Constraints when away from top edge
view.keyboardLayoutGuide.setConstraints([awayFromTop],
                                        activeWhenAwayFrom: .top)
                                        
// Constraints when away from leading and trailing edges
view.keyboardLayoutGuide.setConstraints([inMiddle],
                                        activeWhenAwayFrom: [.leading, .trailing])
```


[Пример кода](https://github.com/kharrison/ALBookCode/tree/main/sample-code/safe-areas-layout-margins/Keyboard-v2/)

Как и пример выше, он такой же, просто применены настройки незакрепленной клавиатуры.

AppDelegate.swift
```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
}
```

SceneDelegate.swift
```swift
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
}
```

RootViewController.swift
```swift
import UIKit

final class RootViewController: UIViewController {
    private lazy var toolbar: Toolbar = {
        let toolbar = Toolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(toolbar)
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        
        let awayFromTop = toolbar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        awayFromTop.identifier = "KB-awayFromTop"
        view.keyboardLayoutGuide.setConstraints([awayFromTop], activeWhenAwayFrom: .top)
        
        let nearTop = toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        nearTop.identifier = "KB-nearTop"
        view.keyboardLayoutGuide.setConstraints([nearTop], activeWhenNearEdge: .top)
        
        let inMiddle = toolbar.centerXAnchor.constraint(equalTo: view.keyboardLayoutGuide.centerXAnchor)
        inMiddle.identifier = "KB-inMiddle"
        view.keyboardLayoutGuide.setConstraints([inMiddle], activeWhenAwayFrom: [.leading, .trailing])
        
        let nearLeading = toolbar.leadingAnchor.constraint(equalTo: view.keyboardLayoutGuide.leadingAnchor)
        nearLeading.identifier = "KB-nearLeading"
        view.keyboardLayoutGuide.setConstraints([nearLeading], activeWhenNearEdge: .leading)
        
        let nearTrailing = toolbar.trailingAnchor.constraint(equalTo: view.keyboardLayoutGuide.trailingAnchor)
        nearTrailing.identifier = "KB-nearTrailing"
        view.keyboardLayoutGuide.setConstraints([nearTrailing], activeWhenNearEdge: .trailing)
    }
}
```

Toolbar.swift . Он без изменений, из примера выше, дублирую для удобства чтения.
```swift
import UIKit

final class Toolbar: UIView {
    private lazy var favouriteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let button = UIButton(configuration: config, primaryAction: UIAction { _ in
            print("Favourite")
        })
        return button
    }()

    private lazy var editButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "square.and.pencil", 
        withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let button = UIButton(configuration: config, primaryAction: UIAction { _ in
            print("Edit")
        })
        return button
    }()

    private lazy var deleteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let button = UIButton(configuration: config, primaryAction: UIAction { _ in
            print("Delete")
        })
        button.role = .destructive
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [favouriteButton, editButton, deleteButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGroupedBackground
        stackView.layer.cornerRadius = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
```

### Away From The Top Edge

Давайте начнем с верхнего края. Когда клавиатура находится вдали от верхнего края, я хочу, чтобы панель инструментов располагалась поверх keyboard layout guide

```swift
  let awayFromTop = toolbar.bottomAnchor.constraint(equalTo:
  view.keyboardLayoutGuide.topAnchor)
        awayFromTop.identifier = "KB-awayFromTop"
        view.keyboardLayoutGuide.setConstraints([awayFromTop], activeWhenAwayFrom: .top)
```

Когда направляющая клавиатуры находится вдали от верхнего края, мы активируем ограничение,  bottom anchor of the toolbar to the top anchor of the guide. Когда направляющая клавиатуры приблизится к верхнему краю, мы отключаем constraint. Также добавлены идентификаторы для удобства debugging the guide.

### Near The Top Edge

Когда клавиатура приблизится к верхнему краю, я хочу, чтобы панель инструментов опустилась
в нижнюю часть экрана. Нам нужно ограничение, которое фиксирует the bottom
anchor of the toolbar to the bottom anchor of the safe area layout guide

```swift
let nearTop = toolbar.bottomAnchor.constraint(equalTo:
view.safeAreaLayoutGuide.bottomAnchor)
        nearTop.identifier = "KB-nearTop"
        view.keyboardLayoutGuide.setConstraints([nearTop], activeWhenNearEdge: .top)
```

### In The Middle
When the keyboard is away from both the leading and trailing edges. I want the toolbar horizontally centered with the keyboard.

```swift
        let inMiddle = toolbar.centerXAnchor.constraint(equalTo:
        view.keyboardLayoutGuide.centerXAnchor)
        inMiddle.identifier = "KB-inMiddle"
        view.keyboardLayoutGuide.setConstraints([inMiddle], activeWhenAwayFrom: [.leading, .trailing])
```

Don’t forget that this constraint is only active when the keyboard guide is away from both the leading and trailing edges. It deactivates if we are near either the leading or trailing edges.

### Near Leading

Когда мы приближаемся к leading edge краю, мы привязываем leading anchor панели инструментов к leading anchor of the keyboard guide

```swift
let nearLeading = toolbar.leadingAnchor.constraint(equalTo: 
view.keyboardLayoutGuide.leadingAnchor)
nearLeading.identifier = "KB-nearLeading"
view.keyboardLayoutGuide.setConstraints([nearLeading], 
activeWhenNearEdge: .leading)
```

### Near Trailing
When we are near the trailing edge мы привязываем the trailing anchor of the toolbar к the trailing anchor of the keyboard guide:

```swift
let nearTrailing = toolbar.trailingAnchor.constraint(equalTo: 
view.keyboardLayoutGuide.trailingAnchor)
nearTrailing.identifier = "KB-nearTrailing"
view.keyboardLayoutGuide.setConstraints([nearTrailing],
activeWhenNearEdge: .trailing)
```

### Docked Keyboard
When we have the keyboard docked, it’s near the bottom and away from all other edges. That means my away from top and in the middle constraints are active pinning the toolbar to the top and horizontal center of the keyboard:

<img alt="image" src="images/auto layout76.jpeg" width = 50%/>

### Советы по отладке Debugging
Вам необходимо учитывать конфигурации состыкованного, отстыкованного и разделенного экрана. Для каждой позиции клавиатуры вам нужно достаточное
количество ограничений для корректной раскладки без создания конфликтов. Находясь на разделенном экране, не забудьте протестировать приложение как слева, так и справа от разделителя.
Отладчик просмотра оказывает огромную помощь в понимании того, какие ограничения активны при перемещении отстыкованной клавиатуры. Я настоятельно рекомендую вам добавить идентификаторы id к каждому из ограничений. Я добавил к своим идентификаторам ограничений префикс `KB-` чтобы я мог легко фильтровать их по поиску в отладчике.

### Challenge 6.1 Margins In Interface Builder (only storyboard)

<img alt="image" src="images/auto layout77.jpeg" width = 80%/>

### Challenge 6.2 Backwards Compatibility With Interface Builder

Устаревшая информация о поддержке старый версий (ios 10 и ранее). 

### Challenge 6.3 Programmatic Margins

<img alt="image" src="images/auto layout78.jpeg" width = 70%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions 
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let rootViewController = RootViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
```

RootViewController.swift
```swift
import UIKit

final class RootViewController: UIViewController {

    private let spacing: CGFloat = 50.0
    private let internalPadding: CGFloat = 25.0

    private let tileView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(tileView)

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, 
        trailing: spacing)
        tileView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: internalPadding, leading: internalPadding, 
        bottom: internalPadding, trailing: internalPadding)

        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tileView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tileView.topAnchor.constraint(equalTo: guide.topAnchor),
            tileView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
            ])
    }
}
```

TileView.swift
```swift
import UIKit

final class TileView: UIView {

    private let internalSpacing: CGFloat = 25.0
    private let blueView = UIView.coloredView(.blue)
    private let redView = UIView.coloredView(.red)

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

        NSLayoutConstraint.activate([
            blueView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            blueView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            blueView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            redView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            redView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            redView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            redView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: internalSpacing),
            blueView.widthAnchor.constraint(equalTo: redView.widthAnchor)
            ])
    }
}

private extension UIView {
    static func coloredView(_ color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
```

### Challenge 6.4 Backwards Compatibility In Code

Устаревшая информация о поддержке старый версий (ios 10 и ранее). 

---

[К оглавлению](#contents)

###  <a id="chapter7" /> Глава 7. Layout Priorities and Content Size

### Key Points To Remember

Simple rule of thumb for answering the question **How Many Constraints Do I Need?**

> **To fix the size and position of each view in a layout we
needed at least two horizontal and two vertical constraints
for every view**.

Note the at least as the two constraints per view “rule” only works with **required, equality constraints**. Once we introduce optional and inequality constraints it gets more complicated.

- All constraints have a layout priority from 1 to 1000. By default,
constraints are `.required` which corresponds to a value of 1000.
- Constraints with a priority less than `.required` are **optional**. The layout engine - механизм компоновки сначала пытается удовлетворить ограничения с более высоким приоритетом, но всегда старается максимально приблизиться к необязательным ограничениям.
- Combine optional constraints with required inequality неравенства constraints, чтобы максимально приблизить вид к размеру или положению, не нарушая других ограничений.
- После того как вы добавили ограничение к view, вы не сможете изменить его priority from required to optional или наоборот.

Мы  можем ослабить наше  правило при работе с view, которые имеют внутренний размер содержимого. Это включает в себя многие стандартные элементы управления UIKit, labels, switches, and buttons.

- Внутренний размер содержимого view (intrinsic content size) - это естественный размер, который должен быть у view, чтобы соответствовать его содержимому.  
- По умолчанию UIKit добавляет для нас ограничения по ширине и высоте, которые задают внутренний размер.
- Вы всегда можете переопределить внутренний размер, добавив ограничения.
- Они могут "сопротивляться" сжатию/растягиванию/охвату решается приоритетами.

- Может ли мой макет когда-нибудь стать слишком большим, чтобы поместиться в доступном пространстве? Если это так, решите, какой вид сжимать в первую очередь, и отдайте ему приоритет с наименьшим сопротивлением сжатию (CompressionResistance).
-  Может ли мой макет когда-нибудь стать слишком маленьким, чтобы поместиться в доступном пространстве? Если да, решите, какой вид растягивать в первую очередь, и присвоите ему наименьший приоритет при просмотре содержимого (ContentHugging).


---

### Layout Priorities
Optional And Required Priorities.  
All constraints have a layout priority from 1 to 1000. The priority is of type UILayoutPriority and UIKit helpfully defines constants for arbitrary “low” and “high” values which it uses as default values:

- **.fittingSize (50)**

- **.defaultLow (250)**

- **.defaultHigh (750)**

- **.required (1000)**

Constraints with a priority lower than `.required (1000)` are optional.

Чтобы закрепить что-либо можно перетащить его на view и выбрать стороны используем Option + Shift

<img alt="image" src="images/auto layout79.jpeg" width = 60%/>

### Creating Optional Constraints In Code

Вариант с storyboard

<img alt="image" src="images/auto layout80.jpeg" width = 100%/>

Вариант с programmatic layout.  
AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions 
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

RootViewController.swift
```swift
import UIKit

final class RootViewController: UIViewController {
    private let sunView = UIImageView(named: "Sun", backgroundColor: .orange)
    private let snowView = UIImageView(named: "Snow", backgroundColor: .blue)

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This label should be below the tallest of the two images"
        label.font = UIFont.systemFont(ofSize: 32.0)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(sunView)
        view.addSubview(snowView)
        view.addSubview(captionLabel)

        let margins = view.layoutMarginsGuide
        // the optional top constraint for the label
        let captionTopConstraint = captionLabel.topAnchor.constraint(equalTo: margins.topAnchor)
        // Set the priority to .defaultLow (250) to make it optional
        captionTopConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            sunView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            sunView.topAnchor.constraint(equalTo: margins.topAnchor),

            snowView.topAnchor.constraint(equalTo: margins.topAnchor),
            snowView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            captionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
// constraints that position the label at least
// a standard amount of spacing below the two images
captionLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: sunView.bottomAnchor, multiplier: 1.0),
            captionLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: snowView.bottomAnchor, 
            multiplier: 1.0),

            captionTopConstraint
            ])
    }
}

// we need two properties in the view controller
// for the image views
private extension UIImageView {
    convenience init(named name: String, backgroundColor: UIColor) {
        self.init(image: UIImage(named: name))
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
```

### Intrinsic Content Size (Размер внутреннего содержимого или же natural size)

All views have an `intrinsicContentSize` property. This
is a `CGSize` with a width and a height. A view can use the
value `UIViewNoIntrinsicMetric` when it has no intrinsic
size for a dimension.

Common UIKit controls like the button, label, switch, stepper, segmented control, and text field have both an intrinsic width and height.

### UIButton

<img alt="image" src="images/auto layout81.jpeg" width = 55%/>

```swift
let button = UIButton(type: .custom)
button.setTitle("Hello", for: .normal)
button.backgroundColor = .green
button.intrinsicContentSize // (w 41 h 34)
```

<img alt="image" src="images/auto layout82.jpeg" width = 60%/>

```swift
button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
button.intrinsicContentSize // (w 81 h 42)
```

```swift
// corner radius
button.layer.cornerRadius = 10.0
button.intrinsicContentSize // (w 81 42)
```

### UILabel

```swift
label.intrinsicContentSize // (w 853 h 20.5)
label.bounds.size // (w 343 h 20.5)
```

Если вы ограничиваете ширину label, но оставляете высоту свободной и устанавливаете значение `numberOfLines` равным 0, размер внутреннего содержимого label регулируется в соответствии с количеством строк, необходимым для отображения полного текста.

### UISlider and UIProgressView

They only have an intrinsic height, not a width. You must add constraints to fix the width of the track. 

```swift
let slider = UISlider()
slider.intrinsicContentSize // (w -1 h 33)
```

### UIImageView

```swift
let imageView = UIImageView()
// empty image view doesn’t have intrinsic content size
imageView.intrinsicContentSize // (w -1 h -1)

imageView.image = UIImage(named: "Star")
imageView.intrinsicContentSize // (w 100 h 100)
```

### Custom Views
When you create a custom subclass of UIView, you can choose to override `intrinsicContentSize` and return a size based on the content of your custom view. If your view doesn’t have a natural size for one dimension return `UIViewNoIntrinsicMetric` for that dimension:

```swift
// Custom view with an intrinsic height of 100 points
class CustomView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 100)
    }
    // ...
}
```

If the intrinsic content size of your custom view changes tell the layout engine by calling `invalidateIntrinsicContentSize()`.

### Content Mode

Свойство `contentMode` UIView управляет тем, как настраивать view при изменении его границ bounds. По умолчанию система не будет перерисовывать view каждый
раз при изменении границ. Это было бы расточительно.

You can also set the content mode of a view in code:

```swift
imageView.contentMode = .scaleAspectFit
```

#### Scaling the View - Масштабирование

- **.scaleToFill**: Растягивает содержимое, чтобы заполнить доступное пространство, без сохранения соотношения сторон. Режим по умолчанию.
- **.scaleAspectFit**: Масштабирует содержимое в соответствии с пространством, сохраняя соотношение сторон.
- **.scaleAspectFill**: Масштабируйте содержимое, чтобы заполнить пространство, сохраняя соотношение сторон. Содержимое может оказаться больше границ
view, что приведет к отсечению.

<img alt="image" src="images/auto layout83.jpeg" width = 80%/>

#### Positioning the View

<img alt="image" src="images/auto layout84.jpeg" width = 80%/>

- **.center**
- **.top, .bottom, .left, .right**
- **.topLeft, .topRight, .bottomLeft, .bottomRight**

### Defaults When Creating Views
Most views have a `.defaultLow` (250) content hugging priority when created and a compression resistance of `.defaultHigh` (750). These defaults apply to both horizontal and vertical priorities.

| Views   |     Content Hugging     |  Compression Resistance |
|----------|:-------------:|------:|
| UIView UIButton UITextField UITextView UISlider UISegmentedControl |  250 | 750 |
| UILabel UIImageView |    250 (Code) 251 (IB)  |   750 |
| UISwitch UIStepper UIDatePicker UIPageControl | 750 |    750 |

1. Элементы управления, такие как switch, stepper, data picker и page control, всегда должны отображаться в их естественном размере, поэтому используйте `.defaultHigh
(750)` priorities.
2. Если вы создаете UILabel или UIImageView с помощью Interface Builder, они имеют приоритет охвата содержимого **251**. Если вы создадите их в коде, вы получите значение по умолчанию **250**. Конструктор интерфейсов предполагает, что в большинстве случаев вы хотите, чтобы метки и изображения сохраняли свой естественный
размер содержимого.

<img alt="image" src="images/auto layout85.jpeg" width = 60%/>

#### Working With Priorities In Code
```swift
    private let sunImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Sun"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        view.backgroundColor = .orange
        return view
    }()
```

All the code

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

```swift
import UIKit

final class RootViewController: UIViewController {
    private let sunImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Sun"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        view.backgroundColor = .orange
        return view
    }()

    private let caption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A sunny day"
        label.font = UIFont.systemFont(ofSize: 64.0)
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(sunImage)
        view.addSubview(caption)

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            sunImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            sunImage.topAnchor.constraint(equalTo: margins.topAnchor),

           caption.leadingAnchor.constraint(equalToSystemSpacingAfter: sunImage.trailingAnchor, multiplier: 1.0), 
           caption.topAnchor.constraint(equalTo: margins.topAnchor),
            caption.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
    }
}
```

### Test Your Knowledge

#### Challenge 7.1 Twice As Big If Possible.

Both labels are using the 24 pt system font. The author label must be at least 160 points wide (but it can be wider)

Storyboard:

<img alt="image" src="images/auto layout87.jpeg" width = 100%/>

Code:

<img alt="image" src="images/auto layout86.jpeg" width = 70%/>

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
    
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
````

RootViewController.swift
```swift
import UIKit

final class RootViewController: UIViewController {
    private let fontSize: CGFloat = 24.0
    private let minimumWidth: CGFloat = 160.0

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }()

    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .purple
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        authorLabel.text = "William Shakespeare"
        quoteLabel.text = "To be, or not to be, that is the question"
    }

    private func setupView() {
        view.addSubview(authorLabel)
        view.addSubview(quoteLabel)

        let optionalWidthConstraint = quoteLabel.widthAnchor.constraint(equalTo: authorLabel.widthAnchor, 
        multiplier: 2.0)
        optionalWidthConstraint.priority = .defaultHigh

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            authorLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            quoteLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            quoteLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            quoteLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: authorLabel.trailingAnchor, 
            multiplier: 1.0),
            authorLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: minimumWidth),
            optionalWidthConstraint
            ])
    }
}
````

#### Challenge 7.2 Stretch Or Squeeze?

Кнопка должна оставаться в своем естественном размере, а размер надписи должен быть изменен, чтобы заполнить
доступную ширину. При необходимости текст может растягиваться на несколько строк.

<img alt="image" src="images/auto layout88.jpeg" width = 70%/>

Storyboard:

<img alt="image" src="images/auto layout89.jpeg" width = 100%/>

Code:

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions 
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
````

RootViewController.swift
```swift
import UIKit

final class RootViewController: UIViewController {
    private let fontSize: CGFloat = 24.0

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Share", comment: "Share button title"), for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        button.addTarget(self, action: #selector(shareQuote(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .purple
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        quoteLabel.text = "To be, or not to be, that is the question"
        setupView()
    }

    private func setupView() {
        view.addSubview(shareButton)
        view.addSubview(quoteLabel)

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            shareButton.topAnchor.constraint(equalTo: margins.topAnchor),
            quoteLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            quoteLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            quoteLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: shareButton.trailingAnchor, multiplier: 1.0)
            ])
    }

    @objc private func shareQuote(_ sender: UIButton) {
        print("Share quote")
    }
}
````

#### Challenge 7.3 A Big As Possible Square

<img alt="image" src="images/auto layout90.jpeg" width = 60%/>

Storyboard:

<img alt="image" src="images/auto layout91.jpeg" width = 100%/>

Code:

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
````

RootViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(backgroundView)

        let optionalWidth = backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        optionalWidth.priority = .defaultHigh

        NSLayoutConstraint.activate([
            // center the background view in the root view
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            // Aspect ratio 1:1 - makes the background view square
            backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor),

            // width and height can grow up to the size of the root view
            backgroundView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            backgroundView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor),

            // Pull the width as close as possible to the width
            // of the root view (without violating other required constraints)
            optionalWidth
            ])
    }
}
````

---

[К оглавлению](#contents)

###  <a id="chapter8" /> Глава №8. Stack Views

A stack view doesn’t automatically scroll its contents like a table or collection view.

Now select all  buttons or another things and embed them in a stack view using the **[Embed In]** tool in the toolbar at the bottom of the Interface Builder window. Or use the menu **Editor › Embed in › Stack View**.

<img alt="image" src="images/auto layout92.jpeg" width = 70%/>

<img alt="image" src="images/auto layout93.jpeg" width = 70%/>

### Embedding Stack Views In Stack Views

<img alt="image" src="images/auto layout94.jpeg" width = 60%/>

<img alt="image" src="images/auto layout95.jpeg" width = 70%/>

The stack view defaults to the `.horizontal` axis. Отключаем маску автоматического изменения размера (autoresizing mask) только для представления rootStackView, а не для кнопок и метки buttonStackView. Получается, что rootStackView отключает преобразование маски автоматического изменения размера для представлений, которыми оно управляет. Таким образом, buttonStackView заботится о кнопках, а rootStackView управляет пbuttonStackView.

AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
```

RootViewController.swift
```swift
import UIKit

final class RootViewController: UIViewController {
    private enum ViewMetrics {
        static let fontSize: CGFloat = 24.0
        static let spacing: CGFloat = 16.0
    }

    private let redButton = UIButton.customButton(title: "Red", color: .red, fontSize: ViewMetrics.fontSize)
    private let greenButton = UIButton.customButton(title: "Green", color: .green, fontSize: ViewMetrics.fontSize)
    private let blueButton = UIButton.customButton(title: "Blue", color: .blue, fontSize: ViewMetrics.fontSize)

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [redButton, greenButton, blueButton])
        stackView.spacing = ViewMetrics.spacing
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Pick a color"
        label.font = UIFont.systemFont(ofSize: ViewMetrics.fontSize)
        return label
    }()

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [colorLabel, buttonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = ViewMetrics.spacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rootStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
}

private extension UIButton {
    static func customButton(title: String, color: UIColor, fontSize: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return button
    }
}
```

Stack View Arranged Views
A stack view manages the layout of views in its arrangedSubviews property. This can be confusing at first as a stack view also has a subviews
property inherited from UIView.

### Stack View Arranged Views
Представление стека управляет расположением view в своем свойстве **`arrangedSubviews`**. Поначалу это может сбить с толку, поскольку view стека также имеет свойство `subviews`, унаследованное от UIView.

```swift
let stackView = UIStackView(arrangedSubviews: [view1, view2, view3])
stackView.addArrangedSubview(view4)
stackView.insertArrangedSubview(view5, at: 0)
```

Don’t use addSubview when you want addArrangedSubview. Adding the view to subviews makes it visible as part of the view hierarchy, but the layout is not managed by the stack view so it will be missing constraints:
```swift
// Add to subviews
stackView.addSubview(redButton)
// Add to arrangedSubviews and subviews
stackView.addArrangedSubview(redButton)
```

### Removing views from a stack view
You can use `removeArrangedSubview(_:)` to remove a view from a stack view **but be careful**. This removes the view from `arrangedSubviews`, and the stack view  больше не управляет макетом view. The view не удаляется из subviews поэтому все еще видно, если вы не скроете его или не удалите с помощью `removeFromSuperview()`.

```swift
// remove from arrangedSubviews (view still visible)
stackView.removeArrangedSubview(redButton)
// remove from arrangedSubviews and subviews
redButton.removeFromSuperview()
```

Чтобы удалить view из `arrangedSubviews`, так и из `subviews` за один раз, используйте `removeFromSuperview`.
Возможно, вам будет проще скрыть представление, установив свойство `isHidden`, а не удаляя его.  The stack view заботится только о видимых views и не добавляет ограничений для скрытого view.

### Stack View Axis
A stack view has a **horizontal** axis by default. 
```swift
// Set the axis to vertical
stackView.axis = .vertical
// Change to horizontal
stackView.axis = .horizontal
```

### Stack View Distribution
A stack view pins the first and last views in its arranged subviews to the edges/margins of the stack view along the axis of the stack view. For a **horizontal stack** view, this is the **leading and trailing** edge/margin of the stack view. For a **vertical stack** view the** top and bottom** edge/margin.

По умолчанию stack view добавляет ограничения по краям
stack view. Для ограничений с полями stack view установите свойство `layoutMarginsRelativeArrangement`.

Распределение упорядоченных subviews, чтобы
заполнить пространство вдоль оси свойством `distribution`:

<img alt="image" src="images/auto layout96.jpeg" width = 60%/>

- **`.fill`** (распределение по умолчанию): пытается заполнить доступное пространство, сохраняя размер просмотров на уровне их внутреннего содержимого. Если пространство не заполнено, это растягивает view с наименьшим приоритетом охвата содержимого (intrinsic content size). Если views слишком велики, он сжимает view с наименьшим приоритетом сопротивления сжатию.
- **`.fillEqually`**: изменяет размеры всех views до одинакового размера, достаточного для заполнения
пространства вместе с любым интервалом между views.
- **`.fillProportionally`**: пропорционально изменяет размеры views на основе их внутреннего размера содержимого  (intrinsic content size), сохраняя относительный размер каждого view.
- **`.equalSpacing`**: Если места достаточно, это позволяет сохранить размер содержимого views в соответствии с их внутренним размером и заполнить пространство, равномерно заполнив интервал между views. В противном случае view сжимается с наименьшим
приоритетом сопротивления сжатию (compression resistance priority), чтобы сохранить минимальный интервал свойства `spacing`.
- **`.equalCentering`**: увеливает расстояние между views, чтобы попытаться создать равное расстояние между центрами каждого вида. При необходимости
представление с наименьшим приоритетом сжатия содержимого сжимается (compression resistance priority), чтобы сохранить минимальный интервал свойства `spacing`.

### Stack View Alignment
alignment - выра́внивание.  
The `alignment` property изменяет способ выравнивания view перпендикулярно оси to the stack view axis. 
The `.fill` alignment is the default and together with the .center alignment works  работает для обеих ориентаций stack view:

<img alt="image" src="images/auto layout97.jpeg" width = 50%/>

The .fill alignment stretches and squeezes the arranged views perpendicular to the stack view axis to fill the available space. If the stack view is not constrained perpendicular to the axis, the arranged views take their intrinsic content size, and the largest arranged view sets the stack view size in that direction,

Выравнивание `.fill` растягивает и сжимает упорядоченные views перпендикулярно оси stack view, чтобы заполнить доступное пространство. Если stack view не ограничено перпендикулярно оси, упорядоченные views принимают свой внутренний размер содержимого, а самый большой упорядоченный view устанавливает размер stack view в этом направлении.  

The `.top`, `.bottom`, `.firstBaseline`, `.lastBaseline` alignments only apply to horizontal stack views:  

<img alt="image" src="images/auto layout98.jpeg" width = 50%/>

For vertical stack views you can use `.leading` and `.trailing` alignments.

### Stack View Spacing

Свойство `spacing` задает расстояние между расположенными subviews вдоль the axis of the stack view. For the `fill`, `fill equally` and `fill proportionally` distributions, используется именно этот интервал, а stack view растягивает или сжимает view по размеру.

For the `.equalSpacing` or `.equalCentering` distributions это минимальное используемое расстояние. The padding between views может превышать этот интервал, но  stack view сжимает views, если это необходимо, чтобы сохранить хотя бы минимальный интервал spacing.

```swift
// Set the spacing to 16 points
stackView.spacing = 16
```

Используйте отрицательное значение для перекрытия views. Порядок расположения view в subviews управляет отображением views от фона к переднему плану.

### Custom Spacing (iOS 11)

Свойство `spacing` равномерно применяет интервалы к упорядоченным to the arranged subviews of the stack view. Если вы хотите, чтобы расстояние между subviews менялось нужны дополнительные шаги. Взгляните на этот макет с пятью метками:

Начиная с iOS 11 вы можете настроить интервал-spacing между views. Interface Builder не поддерживает это, поэтому вам нужно настроить stack view в коде.
Предположим, у нас есть stack view, настроенное на 8 точек интервала. Чтобы получить дополнительный интервал после заголовка и перед  нижним label. Вы всегда устанавливаете интервал после упорядоченного arranged subview. Нет способа установить интервал перед view.

```swift
// available in iOS 11
stackView.setCustomSpacing(32.0, after: headerLabel)
stackView.setCustomSpacing(32.0, after: bottomLabel)
```

<img alt="image" src="images/auto layout99.jpeg" width = 50%/>

### Standard and Default Spacing (iOS 11)
Apple also added two new properties on the `UIStackView` class in iOS 11 that define default and system spacing:

```swift
class let spacingUseDefault: CGFloat
class let spacingUseSystem: CGFloat
```

Вы не используете напрямую значения, возвращаемые этими свойствами. Вы используете их
для установки или сброса custom spacing после view. Например, чтобы использовать
system defined spacing после top label:

```swift
stackview.setCustomSpacing(UIStackView.spacingUseSystem, after: topLabel)
```

To reset the spacing after this label back to the value of the spacing property (removing the custom spacing):

```swift
stackview.setCustomSpacing(UIStackView.spacingUseDefault, after: topLabel)
```

### Baseline Relative Arrangement / Базовое относительное расположение

Это свойство имеет смысл только тогда, когда вы работаете с текстом vertical stack view. Установите значение true, чтобы пространство отображалось на основе базовых линий текста (last to first), а не к краям view (bottom to top).
Предположим, у нас есть вертикальный стек с тремя текстовыми метками и стандартным интервалом. По умолчанию это размещает метки на расстоянии 8 пунктов друг от друга измеряется от их краев:

If you’re using Interface Builder the setting is in the attributes inspector for a stack view just under the spacing: Baseline Relative.

If you’re building a stack view in code set it directly on the stack view (the default is false):

```swift
stackView.isBaselineRelativeArrangement = true
```

### Stack View Margins (поля)
A stack view has a `layoutMargin` property  такое же, как и любое другое представление чтобы добавить расстояние между краями stack view и его упорядоченным subviews.
По умолчанию stack view не использует поля. Это создает
расположение относительно его краев.

Установите для свойства `layoutMarginsRelativeArrangement` значение true, чтобы макет stack view относительно его полей. Например, чтобы было 8 points поля между краями stack view и его arranged subviews:

```swift
// 8 point margins
stackView.isLayoutMarginsRelativeArrangement = true
stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
```

### Stack Views And Layout Priorities

layout in code

1. The default content hugging priority when creating image views and labels in code is defaultLow (250). When we create the name label property in the view controller we need to increase the vertical content hugging priority to 251:

```swift
private let nameLabel: UILabel = {
let label = UILabel()
label.font = UIFont.boldSystemFont(ofSize: ViewMetrics.nameFontSize)
label.numberOfLines = 0
label.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
return label
}()
```

2. When creating the image view, we set the content mode and increase the horizontal content hugging priority to 251:

```swift
private let profileImageView: UIImageView = {
let imageView = UIImageView()
imageView.contentMode = .top
imageView.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
return imageView
}()
```

3. The bio label uses the default priorities:

```swift
private let bioLabel: UILabel = {
let label = UILabel()
label.font = UIFont.systemFont(ofSize:
ViewMetrics.bioFontSize)
label.numberOfLines = 0
return label
}()
```

4. With the views created we can create the vertical label stack view:

```swift
private lazy var labelStackView: UIStackView = {
let stackView = UIStackView(arrangedSubviews:
[nameLabel, bioLabel])
stackView.axis = .vertical
stackView.spacing = UIStackView.spacingUseSystem
return stackView
}()
```

5. Then the horizontal profile stack view:

```swift
private lazy var profileStackView: UIStackView = {
let stackView = UIStackView(arrangedSubviews:
[profileImageView, labelStackView])
stackView.translatesAutoresizingMaskIntoConstraints = false
stackView.spacing = UIStackView.spacingUseSystem
return stackView
}()
```

Note that we need to disable the auto resizing mask constraints for the top stack view.

6. Then from viewDidLoad we setup the root view margins and add the profile stack view to the view hierarchy:

```swift
view.directionalLayoutMargins = NSDirectionalEdgeInsets( top: ViewMetrics.margin, 
leading: ViewMetrics.margin, bottom: ViewMetrics.margin, 
trailing: ViewMetrics.margin)
view.addSubview(profileStackView)
```

7. Finally, we can add the constraints when the view loads to pin the top stack view to the margins:

```swift
let margin = view.layoutMarginsGuide
NSLayoutConstraint.activate([
profileStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
profileStackView.topAnchor.constraint(equalTo:
margin.topAnchor), 
profileStackView.trailingAnchor.constraint(equalTo:
margin.trailingAnchor)
])
```

<img alt="image" src="images/auto layout100.jpeg" width = 50%/>

Весь код:  
AppDelegate.swift
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: 
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        let profile = Profile(name: "Sue Appleseed", bio: "Deep sea diver. Donut maker. Tea drinker.", avatar: nil)
        let profileViewController = ProfileViewController()
        profileViewController.profile = profile

        let navigationController = UINavigationController(rootViewController: profileViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
```

Profile.swift
```swift
import UIKit

struct Profile {
    let name: String
    let bio: String
    let avatar: UIImage?
}
```

ProfileViewController.swift
```swift
import UIKit

final class ProfileViewController: UIViewController {
    private enum ViewMetrics {
        static let margin: CGFloat = 20.0
        static let nameFontSize: CGFloat = 18.0
        static let bioFontSize: CGFloat = 17.0
    }

    var profile: Profile? {
        didSet {
            configureView()
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: ViewMetrics.nameFontSize)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: ViewMetrics.bioFontSize)
        label.numberOfLines = 0
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return imageView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()

    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, labelStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "sky")
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.margin, 
        leading: ViewMetrics.margin, bottom: ViewMetrics.margin, trailing: ViewMetrics.margin)
        view.addSubview(profileStackView)

        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            profileStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            profileStackView.topAnchor.constraint(equalTo: margin.topAnchor),
            profileStackView.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
        ])
    }

    private func configureView() {
        if let image = profile?.avatar {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(named: "placeholder")
        }

        title = profile?.name
        nameLabel.text = profile?.name
        bioLabel.text = profile?.bio
    }
}
```

### Dynamically Updating Stack Views

Stack views автоматически обновляют макет своих arranged subviews , когда вы вносите изменения. Это включает в себя:

- Adding or removing an arranged subview.
- Changing the isHidden property on any of the arranged subviews.
- Changing the axis, alignment, distribution or spacing properties.  

Более того, вы можете анимировать любое из этих изменений.

### Animating Changes To A Stack View
To animate changes you make to a stack view embed them in a UIView animation block. For example, to create an animation that takes 0.25 seconds to run:

```swift
UIView.animate(withDuration: 0.25) {
  // Change stack view properties here
}
```
Or if using property animators introduced with iOS 10:

```swift
UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [], animations: { 
  // Change stack view properties here 
}, completion: nil)
```

Приятной особенностью stack views является то, что они автоматически корректируют макет, когда вы скрываете или показываете arranged views.

### Adding Background Views
How would you give your stack view a background color? If you try to set the background color in Interface Builder or in code, and you’re not running on at least iOS 14, it may surprise you that it does nothing. The reason is that a stack view is a non-rendering subclass of UIView.  
Его задача заключается в управлении макетом views, которые вы добавляете в arrangedSubviews.

До iOS 14 stack view использовало CATransformLayer и
игнорировало любые свойства, поддерживаемые CALayer. Apple перешла на использование CALayer в iOS 14, поэтому stack view теперь отображают цвет фона и другие свойства CALayer. See Stack View Background Color (iOS 14).

### Adding A Background View

1. Connect an outlet in the view controller to the root container stack view in the storyboard. Use the assistant editor to control-drag from the stack view into the controller:
    `@IBOutlet private var containerStackView: UIStackView!`
    
2. Add a setupView() method to create and add the background view to the stack view. Add constraints to pin the background view to the edges of the stack view.

```swift
    private func setupView() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .purple
        backgroundView.layer.cornerRadius = 10.0
        
// Мы делаем backgroundView первым view в subviews, 
// чтобы он отображался позади других subviews.
containerStackView.insertSubview(backgroundView, at: 0)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }
```

Adding a background view to a stack view to make it into an extension of UIStackView

Let’s create a method to add an unarranged view to a stack view. This method creates the view, sets its color and radius, adds it to the subviews array at the specified index and then activates constraints to pin it to the edges of the stack view:

UIStackView+Extension.swift
```swift
import UIKit

public extension UIStackView {
    @discardableResult
    func addBackground(color: UIColor, radius: CGFloat = 0) -> UIView {
        return addUnarrangedView(color: color, radius: radius, at: 0)
    }

    @discardableResult
    func addForeground(color: UIColor, radius: CGFloat = 0) -> UIView {
        let index = subviews.count
        return addUnarrangedView(color: color, radius: radius, at: index)
    }

    @discardableResult
    func addUnarrangedView(color: UIColor, radius: CGFloat = 0, at index: Int = 0) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.layer.cornerRadius = radius
        insertSubview(view, at: index)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return view
    }
}
```

Это сокращает код настройки view до одной строки в нашем view controller:  `containerStackView.addBackground(color: .purple, radius: 10.0)`

Весь файл:  
ViewController.swift
```swift
import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var containerStackView: UIStackView!
    @IBOutlet private var imageStackView: UIStackView!
    @IBOutlet private var axisSwitch: UISwitch!

    @IBAction func axisChanged(_ sender: UISwitch) {
        if #available(iOS 10, *) {
            let animator = UIViewPropertyAnimator(duration: 2.0, dampingRatio: 0.2, animations: {
                self.configureAxis()
            })
            animator.startAnimation()
        } else {
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0,
            options: [], animations: {
                self.configureAxis()
            }, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureAxis()
    }

    private func setupView() {
        containerStackView.addBackground(color: .purple, radius: 10.0)
    }

    private func configureAxis() {
        imageStackView?.axis = axisSwitch.isOn ? .vertical : .horizontal
        if let lastImageView = imageStackView.arrangedSubviews.last {
            lastImageView.isHidden = !axisSwitch.isOn
        }
    }
}
```

<img alt="image" src="images/auto layout101.jpeg" width = 60%/>

### Stack View Background Color (iOS 14)

Since in iOS 14 we now have a full CALayer we can also set other properties like the cornerRadius on the stack view layer. If you’re still supporting iOS 13 or earlier it’s best to do that inside an availability check to avoid runtime warnings when you have a CATransformLayer. Fallback to manually adding a background view for iOS 13 and earlier

Поскольку в iOS 14 у нас теперь есть полноценный `CALayer`, мы также можем установить другие свойства, такие как `cornerRadius`, на слой stack view. Если вы все еще поддерживаете iOS 13 или более раннюю версию, лучше всего сделать это в рамках проверки доступности, чтобы избежать предупреждений во время выполнения, когда у вас есть старый `CATransformLayer`. Резервный
вариант ручного добавления фонового просмотра для iOS 13 и более ранних версий:

```swift
if #available(iOS 14.0, *) {
  // Our stack view has a CALayer so we can set a
  // background color and use layer properties
  containerStackView.backgroundColor = .purple
  containerStackView.layer.cornerRadius = 10.0
} else {
  // Fallback to manually adding the background
  containerStackView.addBackground(color: .purple, radius: 10.0)
}
```

261

<img alt="image" src="images/auto layout102.jpeg" width = 50%/>

<img alt="image" src="images/auto layout103.jpeg" width = 50%/>

<img alt="image" src="images/auto layout104.jpeg" width = 50%/>

<img alt="image" src="images/auto layout105.jpeg" width = 50%/>

<img alt="image" src="images/auto layout106.jpeg" width = 50%/>

<img alt="image" src="images/auto layout107.jpeg" width = 50%/>

<img alt="image" src="images/auto layout108.jpeg" width = 50%/>

<img alt="image" src="images/auto layout109.jpeg" width = 50%/>

<img alt="image" src="images/auto layout110.jpeg" width = 50%/>

```swift

```

<img alt="image" src="images/.jpg"  width = 70%/>

<img alt="image" src="images/.jpeg"/>