Третья  часть коспекта, из-за ограничей Github был разделен единый файл коспекта на части.
[Вернуться к первой части коспекта](https://github.com/artemiosdev/Swift-Manual-my-notes)

[Вернуться ко второй части коспекта](https://github.com/artemiosdev/Swift-Manual-my-notes/blob/main/READMEpart2.md)

<a id="contents" />Оглавление

ЧАСТЬ V Фреймворки

- [Глава №. Core Data](#coredata)


---

[К оглавлению](#contents)

###  <a id="coredata" /> Глава №. Core Data

[#CoreData](https://developer.apple.com/documentation/coredata) – нативный фреймворк от Apple для хранения данных пользователя у него на устройстве. Это не база данных.

<img alt="image" src="images/СoreDataStack1.jpg"/>

<img alt="image" src="images/coredata.jpg"/>

<img alt="image" src="images/coredata1.jpg"/>

Необходимый код в проекте для работы с CoreData. Можно добавить при создании приложения, или уже к созданному опционально. Вставляется код ниже в файлы, создается файл с расширением `.xcdatamodeld`

AppDelegate.swift
```swift
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
...

// MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MyCars")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
```

SceneDelegate.swift
```swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

...

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}
```



