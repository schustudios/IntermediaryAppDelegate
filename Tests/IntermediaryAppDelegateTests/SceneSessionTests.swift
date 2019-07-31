//
//  File.swift
//  
//
//  Created by Ryan Schumacher on 7/8/19.
//
import XCTest

#if canImport(UIKit)
import UIKit
@testable import IntermediaryAppDelegate

final class SceneSessionTests: XCTestCase {

    @available(iOS 13.0, *)
    func testConfigureForConnection() {
        let delegate = SceneSessionAppDelegate()
        let tmad = SceneSessionIntermediaryAppDelegate([delegate])

        // NOTE: Throws exception on iOS 12 Simulators
        tmad.application(UIApplication.shared, didDiscardSceneSessions: Set<UISceneSession>())
        XCTAssert(delegate.didCallDidDiscardSceneSessions)
    }
}

@available(iOS 13.0, *)
class SceneSessionIntermediaryAppDelegate: IntermediaryAppDelegate, ConfigureSceneIntermediaryAppDelegate { }

@available(iOS 13.0, *)
class SceneSessionAppDelegate: UIResponder, UIApplicationDelegate {
    var didCallDidDiscardSceneSessions = false
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        didCallDidDiscardSceneSessions = true
    }


}
#endif
