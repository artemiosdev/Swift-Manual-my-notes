### Modern Auto Layout, Building Adaptive Layouts For iOS 

#### Keith Harrison

Version: 6 (2021-11-09)

Layout - расположение; frame - костяк, рамка

### Auto Layout Tools

<img alt="image" src="images/auto layout6.jpeg" width = 50%/>

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

<img alt="image" src="images/auto layout9.jpeg" width = 50%/>

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

### Chapter 2. Layout Before Auto Layout

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

<img alt="image" src="images/auto layout15.jpeg" width = 70%/>

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

<img alt="image" src="images/auto layout20.jpeg" width = 60%/>

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

<img alt="image" src="images/auto layout21.jpeg" width = 50%/>

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

<img alt="image" src="images/auto layout27.jpeg" width = 70%/>

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

### Chapter 3. Getting Started With Auto Layout
What Is Auto Layout?



<img alt="image" src="images/auto layout29.jpeg" width = 70%/>
<img alt="image" src="images/auto layout30.jpeg" width = 70%/>