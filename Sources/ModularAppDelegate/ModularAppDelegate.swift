
#if canImport(UIKit)
import UIKit

open class ModularAppDelegate: UIResponder, UIApplicationDelegate {

    public let delegates: [UIApplicationDelegate] = []

    public init(_ delegates: [UIApplicationDelegate]) {
        self.delegates = delegates
    }

    // MARK: Initializing App
    open func application(_ application: UIApplication,
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

    @available(iOS 13.0, *)
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

    @available(iOS 13.0, *)
    open func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

        delegates.forEach {
            $0.application?(application, didDiscardSceneSessions: sceneSessions)
        }
    }

    // MARK: App Lifecycle Events

    open func applicationDidBecomeActive(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationDidBecomeActive?(application)
        }
    }

    open func applicationWillResignActive(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationWillResignActive?(application)
        }
    }
    open func applicationDidEnterBackground(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationDidEnterBackground?(application)
        }
    }
    open func applicationWillEnterForeground(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationWillEnterForeground?(application)
        }
    }
    open func applicationWillTerminate(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationWillTerminate?(application)
        }
    }

    // MARK: Environment Changes

    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationProtectedDataDidBecomeAvailable?(application)
        }
    }

    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationProtectedDataWillBecomeUnavailable?(application)
        }
    }

    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationDidReceiveMemoryWarning?(application)
        }
    }

    open func applicationSignificantTimeChange(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationSignificantTimeChange?(application)
        }
    }

    // MARK: App State Restoration

    open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return delegates.reduce(into: false) { result, delegate in
            if delegate.application?(application, shouldSaveApplicationState: coder) == true {
                result = true
            }
        }

    }

    open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return delegates.reduce(into: false) { result, delegate in
            if delegate.application?(application, shouldRestoreApplicationState: coder) == true {
                result = true
            }
        }
    }

    open func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        for delegate in delegates {
            if let result = delegate.application?(application, viewControllerWithRestorationIdentifierPath: identifierComponents, coder: coder) {
                return result
            }
        }

        return nil
    }

    open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        delegates.forEach {
            $0.application?(application, willEncodeRestorableStateWith: coder)
        }
    }

    open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        delegates.forEach {
            $0.application?(application, didDecodeRestorableStateWith: coder)
        }
    }

    // MARK: Downloading Data in the Background
    open func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {

        // This method check each delegate for the capability to respond to this method.

        let selector = #selector(UIApplicationDelegate.application(_:handleEventsForBackgroundURLSession:completionHandler:))

        guard delegates.forEach(with: selector, {
            $0.application?(application,
                            handleEventsForBackgroundURLSession: identifier,
                            completionHandler: completionHandler)
        }) else {
            return completionHandler()
        }

    }

    // MARK: Remote Notification Registration

    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        delegates.forEach {
            $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }

    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        delegates.forEach {
            $0.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }

    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        let selector = #selector(UIApplicationDelegate.application(_:didReceiveRemoteNotification:fetchCompletionHandler:))

        guard delegates.forEach(with: selector, {
            $0.application?(application,
                            didReceiveRemoteNotification: userInfo,
                            fetchCompletionHandler: completionHandler)
        }) else {
            return completionHandler(.failed)
        }
    }



}

extension Array where Element == UIApplicationDelegate {

    /// Checks if each object in the array can respond to the selector, and calls the closure on that element.
    /// Return: Returns True is an element responded, and returns false if no element responded.
    func forEach(with selector: Selector, _ closure: (Element) -> Void) -> Bool {

        // This method check each delegate for the capability to respond to this method.

        return self.reduce(into: false) { result, element in
            if element.responds(to:selector) {
                result = true
                closure(element)
            }
        }
    }
}

#endif
