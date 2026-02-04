import GoogleMobileAds
import FirebaseCore

final class AdMobInitializer {
    static func initializeSDK() {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
}
