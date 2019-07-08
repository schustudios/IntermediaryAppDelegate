
#if canImport(UIKit)
import UIKit

open class ModularAppDelegate: UIResponder, UIApplicationDelegate {

    var modules: [UIApplicationDelegate] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

#endif
