//
//  RemoteNotificationTests.swift
//  
//
//  Created by Ryan Schumacher on 7/30/19.
//

import XCTest

#if canImport(UIKit)
import UIKit
@testable import IntermediaryAppDelegate

final class RemoteNotificationTests: XCTestCase {

    func testRegisterForRemoteNotification() {
        let appDelegate = RemoteNotificationTestsAppDelegate()
        let intermediaryAppDelegate = RemoteNotificationIntermediaryAppDelegate([appDelegate])

        let data: Data = "Some Random Text Here".data(using: .ascii)!
        intermediaryAppDelegate.application(UIApplication.shared,
                                didRegisterForRemoteNotificationsWithDeviceToken:data)
        XCTAssert(appDelegate.didRegisterForRemoteNotification)
        XCTAssert(appDelegate.deviceToken == data)

        // Test Empty IntermediaryAppDelegate
        let emptyAppDelegate = RemoteNotificationIntermediaryAppDelegate([])
        emptyAppDelegate.application(UIApplication.shared,
                                didRegisterForRemoteNotificationsWithDeviceToken:data)
    }

    func testDidFailToRegisterForRemoteNotifications() {
        let appDelegate = RemoteNotificationTestsAppDelegate()
        let intermediaryAppDelegate = RemoteNotificationIntermediaryAppDelegate([appDelegate])

        intermediaryAppDelegate.application(UIApplication.shared,
                                            didFailToRegisterForRemoteNotificationsWithError: RemoteNotificationTestsAppDelegate.TestError.testError)
        XCTAssert(appDelegate.didFailToRegisterForRemoteNotification)

        if case RemoteNotificationTestsAppDelegate.TestError.testError = appDelegate.error! {
            // Good condition
        } else {
            XCTFail()
        }



        // Test Empty IntermediaryAppDelegate
        let emptyAppDelegate = RemoteNotificationIntermediaryAppDelegate([])
        emptyAppDelegate.application(UIApplication.shared,
                                     didFailToRegisterForRemoteNotificationsWithError: RemoteNotificationTestsAppDelegate.TestError.testError)

    }

    func testDidReceiveRemoteNotification() {
        let appDelegate = RemoteNotificationTestsAppDelegate()
        let intermediaryAppDelegate = RemoteNotificationIntermediaryAppDelegate([appDelegate])

        var didCallBack0 = false
        let userInfo = ["MyKey": "MyValue"]
        intermediaryAppDelegate.application(UIApplication.shared,
                                            didReceiveRemoteNotification: userInfo,
                                            fetchCompletionHandler: { _ in didCallBack0 = true })
        XCTAssert(appDelegate.didReceiveRemoteNotification)
        XCTAssert(appDelegate.userInfo!["MyKey"] as? String == userInfo["MyKey"])
        XCTAssert(didCallBack0)

        // Test Empty IntermediaryAppDelegate
        let emptyAppDelegate = RemoteNotificationIntermediaryAppDelegate([])

        var didCallBack1 = false
        emptyAppDelegate.application(UIApplication.shared, didReceiveRemoteNotification: [:],
                                     fetchCompletionHandler: { _ in didCallBack1 = true })
        XCTAssert(didCallBack1)

    }

}

class RemoteNotificationTestsAppDelegate: UIResponder, UIApplicationDelegate {

    enum TestError: Error {
        case testError
    }

    var didRegisterForRemoteNotification = false
    var deviceToken: Data?
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        didRegisterForRemoteNotification = true
        self.deviceToken = deviceToken
    }

    var didFailToRegisterForRemoteNotification = false
    var error: Error?
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        didFailToRegisterForRemoteNotification = true
        self.error = error
    }

    var didReceiveRemoteNotification = false
    var userInfo: [AnyHashable: Any]?
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        didReceiveRemoteNotification = true
        self.userInfo = userInfo
        completionHandler(.failed)

    }


}


#endif
