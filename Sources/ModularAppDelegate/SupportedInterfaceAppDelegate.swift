//
//  SupportedInterfaceAppDelegate.swift
//  
//
//  Created by Ryan Schumacher on 7/8/19.
//

#if canImport(UIKit)

import UIKit

public protocol SupportedInterfaceAppDelegate: ModularAppDelegate { }

extension SupportedInterfaceAppDelegate {
    // MARK: Managing Interface Geometry
    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        for delegate in delegates {
            if let result = delegate.application?(application, supportedInterfaceOrientationsFor: window) {
                return result
            }
        }
        return .all
    }

}
#endif

