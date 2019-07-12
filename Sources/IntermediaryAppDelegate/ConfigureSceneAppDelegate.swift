//
//  ConfigureSceneAppDelegate.swift
//  
//
//  Created by Ryan Schumacher on 7/8/19.
//
#if canImport(UIKit)

import UIKit

@available(iOS 13.0, *)
public protocol ConfigureSceneIntermediaryAppDelegate: IntermediaryAppDelegate, UISceneDelegate { }

@available(iOS 13.0, *)
extension ConfigureSceneIntermediaryAppDelegate {
    // MARK: UISceneSession Lifecycle

    public func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.

        for delegate in delegates {
            if let result = delegate.application?(application, configurationForConnecting: connectingSceneSession, options: options) {
                return result
            }
        }

        // Fail if no UISceneConfiguration can be found
        assertionFailure("No Delegate Impliments method `application(configurationForConnecting: options:)")
        fatalError("No Delegate Impliments method `application(configurationForConnecting: options:)")
    }

    public func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

        delegates.forEach {
            $0.application?(application, didDiscardSceneSessions: sceneSessions)
        }
    }

}
#endif

