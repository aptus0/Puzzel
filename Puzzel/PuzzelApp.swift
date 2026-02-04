import SwiftUI

@main
struct PuzzelApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
