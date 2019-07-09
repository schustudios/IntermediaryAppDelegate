//
//  SiriKitAppDelegate.swift
//  
//
//  Created by Ryan Schumacher on 7/9/19.
//

#if canImport(UIKit)

import UIKit

public protocol SiriKitAppDelegate: ModularAppDelegate { }

extension SiriKitAppDelegate {
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
}
#endif
