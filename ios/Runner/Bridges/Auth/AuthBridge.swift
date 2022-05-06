//
//  AuthBridge.swift
//  Runner
//
//  Created by Sagar on 01/05/22.
//

import UIKit
import Flutter

class AuthBridge {
	var window: UIWindow?
	var cleanPlanet: CleanPlanetWebViewController?

	func initiate(controller: FlutterViewController, window: UIWindow?, cleanPlanet: CleanPlanetWebViewController?) {
		self.window = window
		self.cleanPlanet = cleanPlanet
		let authChannel = FlutterMethodChannel(
			name: "io.cleanplanet.app/auth",
			binaryMessenger: controller.binaryMessenger
		)
		authChannel.setMethodCallHandler({
			[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
			// Note: this method is invoked on the UI thread.
			guard
				call.method == "validateDTube",
				let arguments = call.arguments as? NSDictionary,
				let username = arguments ["username"] as? String,
				let password = arguments["key"] as? String
			else {
				result(FlutterMethodNotImplemented)
				return
			}
			self?.authenticate(username: username, key: password, result: result)
		})
	}

	private func authenticate(username: String, key: String, result: @escaping FlutterResult) {
		guard let cleanPlanet = cleanPlanet else {
			result(FlutterError(code: "ERROR",
													message: "Error setting up DTube",
													details: nil))
			return
		}
		cleanPlanet.validateDTubeKey(username: username, key: key) { response in
			result(response)
		}
	}
}
