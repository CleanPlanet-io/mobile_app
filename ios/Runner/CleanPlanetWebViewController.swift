//
//  CleanPlanetWebViewController.swift
//  Runner
//
//  Created by Sagar on 06/05/22.
//

import UIKit
import WebKit
class CleanPlanetWebViewController: UIViewController {
	let cleanplanet = "cleanplanet"
	let config = WKWebViewConfiguration()
	let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
	var webView: WKWebView?
	var didFinish = false
	var dtubeKeyValidationHandler: ((String) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		config.userContentController.add(self, name: cleanplanet)
		webView = WKWebView(frame: rect, configuration: config)
		webView?.navigationDelegate = self
		guard
			let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "public")
		else { return }
		let dir = url.deletingLastPathComponent()
		webView?.loadFileURL(url, allowingReadAccessTo: dir)
	}

	func validateDTubeKey(
		username: String,
		key: String,
		handler: @escaping (String) -> Void
	) {
		dtubeKeyValidationHandler = handler
		OperationQueue.main.addOperation {
			self.webView?.evaluateJavaScript("validateDTubeKey('\(username)', '\(key)')")
		}
	}
}

extension CleanPlanetWebViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		didFinish = true
	}
}

extension CleanPlanetWebViewController: WKScriptMessageHandler {
	func userContentController(
		_ userContentController: WKUserContentController,
		didReceive message: WKScriptMessage
	) {
		guard message.name == cleanplanet else { return }
		guard let dict = message.body as? [String: AnyObject] else { return }
		guard let type = dict["type"] as? String else { return }
		switch type {
			case "validateDTubeKey":
				guard
					let isValid = dict["valid"] as? Bool,
					let username = dict["username"] as? String,
					let error = dict["error"] as? String,
					let response = ValidateDTubeKeyResponse.jsonStringFrom(dict: dict)
				else { return }
				debugPrint("Is it valid? \(isValid ? "TRUE" : "FALSE")")
				debugPrint("user name is \(username)")
				debugPrint("Error is \(error)")
				dtubeKeyValidationHandler?(response)
			default: debugPrint("Do nothing here.")
		}
	}
}
