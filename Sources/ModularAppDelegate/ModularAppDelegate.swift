
#if canImport(UIKit)
import UIKit

open class ModularAppDelegate: UIResponder, UIApplicationDelegate {

    var delegates: [UIApplicationDelegate] = []

    public init(_ delegates: [UIApplicationDelegate]) {
        self.delegates = delegates
    }

    // MARK: Initializing App
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        return delegates.reduce(into: true) { result, delegate in
            if delegate.application?(application, willFinishLaunchingWithOptions: launchOptions) == false {
                result = false
            }
        }
    }

    open func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return delegates.reduce(into: true) { result, delegate in
            if delegate.application?(application, didFinishLaunchingWithOptions: launchOptions) == false {
                result = false
            }
        }
    }

    open func applicationDidFinishLaunching(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationDidFinishLaunching?(application)
        }
    }

    // MARK: UISceneSession Lifecycle

    open func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.

        for delegate in delegates {
            if let result = delegate.application?(application, configurationForConnecting: connectingSceneSession, options: options) {
                return result
            }
        }

        // Fail if no UISceneConfiguration can be found
        assertionFailure("No Module Impliments method `application(configurationForConnecting: options:)")
        fatalError("No Module Impliments method `application(configurationForConnecting: options:)")
    }

    open func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

        delegate.forEach {
            $0.application?(application, didDiscardSceneSessions: sceneSessions)
        }
    }

    // MARK: App Lifecycle Events



}

#endif
