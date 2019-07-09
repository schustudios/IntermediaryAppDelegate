
#if canImport(UIKit)
import UIKit
import CloudKit

open class ModularAppDelegate: UIResponder, UIApplicationDelegate {

    public let delegates: [UIApplicationDelegate]

    public override init() {
        delegates = []
    }
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


    // MARK: Continue User Activity

    open func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return delegates.reduce(into: false) { result, delegate in
            if delegate.application?(application, willContinueUserActivityWithType: userActivityType) == true {
                result = true
            }
        }
    }

    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return delegates.reduce(into: false) { result, delegate in
            if delegate.application?(application, continue: userActivity, restorationHandler: restorationHandler) == true {
                result = true
            }
        }
    }

    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        delegates.forEach {
            $0.application?(application, didUpdate: userActivity)
        }
    }

    open func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        delegates.forEach {
            $0.application?(application,
                            didFailToContinueUserActivityWithType: userActivityType,
                            error: error)
        }
    }

    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

        let selector = #selector(UIApplicationDelegate.application(_:performActionFor:completionHandler:))

        guard delegates.forEach(with: selector, {
            $0.application?(application,
                            performActionFor: shortcutItem,
                            completionHandler: completionHandler)
        }) else {
            return completionHandler(false)
        }
    }
    // MARK: WatchKit
    open func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Void) {
        let selector = #selector(UIApplicationDelegate.application(_:handleWatchKitExtensionRequest:reply:))

        guard delegates.forEach(with: selector, {
            $0.application?(application,
                            handleWatchKitExtensionRequest: userInfo,
                            reply: reply)
        }) else {
            return reply(nil)
        }
    }

    // MARK: HealthKit
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        delegates.forEach {
            $0.applicationShouldRequestHealthAuthorization?(application)
        }
    }

    // MARK: Opening URL Specified Resources
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return delegates.reduce(into: false) { result, delegate in
            if delegate.application?(app, open: url, options: options) == true {
                result = true
            }
        }
    }

    // MARK: Disallowing Specified App Extension Types
    open func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        return delegates.reduce(into: true) { result, delegate in
            if delegate.application?(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier) == false {
                result = false
            }
        }
    }

    // MARK: SiriKit Intents
    open func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let selector = #selector(UIApplicationDelegate.application(_:performFetchWithCompletionHandler:))

        guard delegates.forEach(with: selector, {
            $0.application?(application,
                            performFetchWithCompletionHandler: completionHandler)
        }) else {
            // Fail if no UISceneConfiguration can be found
            assertionFailure("No Module Impliments method `application(_:performFetchWithCompletionHandler:)")
            fatalError("No Module Impliments method `application(_:performFetchWithCompletionHandler:)")
        }
    }

    // MARK: Handling CloudKit Invitations
    open func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        delegates.forEach {
            $0.application?(application, userDidAcceptCloudKitShareWith: cloudKitShareMetadata)
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
