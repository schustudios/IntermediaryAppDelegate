
#if canImport(UIKit)
import UIKit

open class ModularAppDelegate: UIResponder, UIApplicationDelegate {

    open var modules: [UIApplicationDelegate] { return [] }

    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Default Return

        return self.modules.reduce(into: true) { result, delegate in
            if delegate.application?(application, didFinishLaunchingWithOptions: launchOptions) == false {
                result = false
            }
        }
    }

}

#endif
