import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
	var cleanPlanet: CleanPlanetWebViewController?
	let authBridge = AuthBridge()

	override func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		cleanPlanet = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CleanPlanetWebViewController") as? CleanPlanetWebViewController
		cleanPlanet?.viewDidLoad()
		let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
		authBridge.initiate(controller: controller, window: window, cleanPlanet: cleanPlanet)
		GeneratedPluginRegistrant.register(with: self)
		return super.application(application, didFinishLaunchingWithOptions: launchOptions)
	}
}
