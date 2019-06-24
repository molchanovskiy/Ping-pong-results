//
//  AuthenticationManager.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import RealmSwift

class AuthenticationManager {
	
	// MARK: - Variables
	
	static let shared = AuthenticationManager()
	
	// MARK: - Initialization
	
	init() {
		
	}
	
	// MARK: - Functions
	
	/**
	Presents UIAlertViewController with two text fields and action button
	
	- parameter presentingViewController: UIViewController which will present alert
	- parameter createAccount: boolean value to determinate if view is sign in or sign up user
	- parameter completion:  A block type used for APIs which asynchronously vend an `RLMSyncUser`.
	*/
	func presentLoginInView(presentingViewController:UIViewController, createAccount:Bool = false, onCompletion completion: @escaping UserCompletionBlock) {
		
		var alertTitle = "Sign In to your Cloud"
		var alertText = "Type your credentials!"
		var actionButtonTitle = "Sign In"
		if createAccount {
			alertTitle = "Create account and login."
			alertText = "Type your credentials!"
			actionButtonTitle = "Sign Up"
		}
		let alertController = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: {
			alert -> Void in
			let textField = alertController.textFields![0] as UITextField
			let passwordTextField = alertController.textFields![0] as UITextField
			let creds = SyncCredentials.usernamePassword(username: textField.text!, password: passwordTextField.text!, register: createAccount)
			
			SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: completion)
		}))
		
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
			textField.placeholder = "Username"
		})
		alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
			textField.placeholder = "Password"
			textField.isSecureTextEntry = true
		})
		presentingViewController.present(alertController, animated: true, completion: nil)
	}
	
	/**
	Presents UIAlertViewController, action sign out realm user
	
	- parameter presentingViewController: UIViewController which will present alert
	*/
	func signOut(presentingViewController:UIViewController, comletiton: @escaping ((Bool)->Void)) {
		if let user = SyncUser.current {
			let alertController = UIAlertController(title: "Logout", message: "", preferredStyle: .alert);
			alertController.addAction(UIAlertAction(title: "Yes, Logout", style: .destructive, handler: {
				alert -> Void in
				user.logOut()
				RealmManager.shared.realm = try! Realm()
				comletiton(true)
			}))
			alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { alert -> Void in comletiton(false)}))
			presentingViewController.present(alertController, animated: true, completion: nil)
		}
	}
	
	/**
	Checks if user is logged in or not
	
	- returns: true or false
	*/
	func isLoggedIn() -> Bool {
		return (SyncUser.current != nil) ? true : false
	}
	
}
