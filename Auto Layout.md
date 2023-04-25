### Modern Auto Layout, Building Adaptive Layouts For iOS 

<a id="contents" />Оглавление

- [Appendix.  Main concepts](#appendix)
- [Глава №2. Layout Before Auto Layout.](#chapter2)
- [Глава №3. Getting Started With Auto Layout.](#chapter3)
- [Глава №4. Using Interface Builder.](#chapter4)
- [Глава №5. Creating Constraints In Code.](#chapter5)
- [Глава №6. .](#chapter6)
- [Глава №7. .](#chapter7)
- [Глава №8. .](#chapter8)
- [Глава №9. .](#chapter9)
- [Глава №10. .](#chapter10)
- [Глава №11. .](#chapter11)
- [Глава №12. .](#chapter12)
- [Глава №13. .](#chapter13)
- [Глава №14. .](#chapter14)

---

[К оглавлению](#contents)

###  <a id="appendix" />  Appendix.  Main concepts

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

#### Constraints Tool
<img alt="image" src="images/auto layout45.jpeg" width = 50%/>

В каждом из полей с интервалами есть выпадающее меню, в котором вы можете выбрать один из возможных видов соседей. При создании интервала между двумя дочерними видами вы также можете выбрать использование “standard” интервала.

#### Align Tool

Например, чтобы отцентрировать три кнопки по горизонтали в желтом superview.

<img alt="image" src="images/auto layout46.jpeg" width = 50%/>

#### Control-Dragging In The Canvas

Вы можете быстро создать ограничение на холсте Interface Builder, перетащив элемент управления внутри элемента или между двумя элементами:

<img alt="image" src="images/auto layout47.jpeg" width = 60%/>

#### Control-Dragging In The Document Outline

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

#### Creating Outlets For Constraints

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

#### Полезный функционал 

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

#### Challenge 4.1 - Nested View Layout

Чтобы сделать высоту одного view в процентах % от высоты другого view, требуется выполнить два шага. Сначала вам нужно создать constraint равной высоты между двумя view. Затем отредактируйте constraint, чтобы изменить
множитель на требуемую пропорцию

<img alt="image" src="images/auto layout57.jpeg" width = 70%/>

#### Challenge 4.2 - Sibling View Layout

Просто добавляем constraints для каждого view по всем сторонам, и приравниваем heights и все. Выставлять margins, приоритеты и общие настройки это ошибочный путь решения

<img alt="image" src="images/auto layout58.jpeg" width = 70%/>

#### Challenge 4.3 - Proportional Centering

Button “1” is at 0.5 the center of the safe area. Button “2” is at the center. Button “3” is at 1.5 the center of the safe area.

<img alt="image" src="images/auto layout59.jpeg" width = 70%/>

#### Challenge 4.4 Changing Constraints

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
NSLayoutConstraint.activate([ redView.widthAnchor.constraint(equalTo: greenView.widthAnchor), redView.heightAnchor.constraint(equalTo: greenView.heightAnchor), // other constraints...
])
```

There’s a similar method to deactivate a group of constraints:

```swift
NSLayoutConstraint.deactivate(constraints)
```

#### Disabling The Autoresizing Mask

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

#### Creating Constraints With NSLayoutConstraint (не рекомендуется)

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
NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0)
```

<img alt="image" src="images/auto layout61.jpeg" width = 50%/>

AppDelegate.swiftl
```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
            NSLayoutConstraint(item: redView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: padding),

            // view.trailing == redView.trailing + padding
            NSLayoutConstraint(item: view!, attribute: .trailing, relatedBy: .equal, toItem: redView, attribute: .trailing, multiplier: 1.0, constant: padding),

            // redView.top == view.top + padding
            NSLayoutConstraint(item: redView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: padding),

            // view.bottom = redView.bottom + padding
            NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: redView, attribute: .bottom, multiplier: 1.0, constant: padding)
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        let hRedConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[redView]-(padding)-|", options: [], metrics: metrics, views: views)

        let hGreenConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[greenView]-(padding)-|", options: [], metrics: metrics, views: views)

        /*
         Create the vertical constraints
         */
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[redView(==greenView)]-(spacing)-[greenView]-(padding)-|", options: [], metrics: metrics, views: views)

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

#### Horizontal Constraints

Use layout anchors of type `NSLayoutXAxisAnchor` to create horizontal constraints:
- `centerXAnchor`
- `leadingAnchor` and `trailingAnchor`
- `leftAnchor` and `rightAnchor`

For example, to create a constraint that center aligns two views:

`redView.centerXAnchor.constraint(equalTo: greenView.centerXAnchor)`

Prefer the `leadingAnchor` and `trailingAnchor` over the `leftAnchor` and `rightAnchor`. The leading and trailing anchors are aware of Right-To-Left (RTL) languages and
flip the interface when necessary.

#### Vertical Constraints

Use layout anchors of type `NSLayoutYAxisAnchor` to create vertical constraints:
- `centerYAnchor`
- `bottomAnchor` and `topAnchor`
- `firstBaselineAnchor` and `lastBaselineAnchor`

Например, чтобы создать constraint, которое помещает верхнюю часть top greenView на 25 пунктов ниже bottom redView:

`greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 25)`

#### Size Based Constraints
Use layout anchors of type `NSLayoutDimension` to create size-based constraints:
- `heightAnchor` and `widthAnchor`

For example, to create a constraint that fixes the width of a view to 50 points:

`redView.widthAnchor.constraint(equalToConstant: 50.0)`

To make the height of redView twice the height of greenView:

`redView.heightAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: 2.0)`

#### Creating Constraints With Layout Anchors

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

<img alt="image" src="images/auto layout63.jpeg" width = 50%/>