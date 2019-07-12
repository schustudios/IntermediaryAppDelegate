//
//  RemoteNotificationAppDelegate.swift
//  
//
//  Created by Ryan Schumacher on 7/9/19.
//

#if canImport(UIKit)

import UIKit

public class ModularRemoteNotificationAppDelegate: ModularAppDelegate {

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
#endif

