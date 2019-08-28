//
//  SettingsController.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
import KeychainAccess

class SettingsController {
	static let shared = SettingsController()
	
	private let defaults = UserDefaults.standard
	private let keychain = Keychain(service: "com.build-week.Foodie")
	
	private let tokenKey = "token_key"
	private let userIdKey = "user_id_key"
	private let usernameKey = "username_key"
	private let userPasswordKey = "user_password_key"
	private let saveProfileKey = "save_profile_key"
	private let freshInstallationKey = "fresh_installation_key"
	
	private(set) var userToken: String? {
		get {
			return keychain[tokenKey]
		}
		set {
			guard let newToken = newValue else {
				keychain[tokenKey] = nil
				return
			}
			keychain[tokenKey] = newToken
		}
	}
	
	private(set) var loggedInUser: Login?
	
	private(set) var userCredentials: LoginRequest? {
		get {
			guard let username = keychain[usernameKey], let password = keychain[userPasswordKey] else { return nil }
			return LoginRequest(username: username, password: password)
		}
		set {
			guard let newValue = newValue else {
				keychain[usernameKey] = nil
				keychain[userPasswordKey] = nil
				return
			}
			keychain[usernameKey] = newValue.username
			keychain[userPasswordKey] = newValue.password
		}
	}
	
	var isSaveCredentials: Bool {
		get {
			guard let isSaved = defaults.value(forKey: saveProfileKey) as? Bool else { return false }
			return isSaved
		}
		set {
			if !newValue {
				userCredentials = nil
			}
			defaults.set(newValue, forKey: saveProfileKey)
		}
	}
	
	var isFreshInstall: Bool {
		get {
			guard let isFresh = defaults.value(forKey: freshInstallationKey) as? Bool else { return false }
			return isFresh
		}
		set {
			if !newValue {
				userCredentials = nil
			}
			defaults.set(newValue, forKey: freshInstallationKey)
		}
	}
	
	func persist(credentials: LoginRequest) {
		if isSaveCredentials {
			userCredentials = credentials
		}
	}
	
	func loginProcedure(_ user: Login) {
		loggedInUser = user
		userToken = user.token
	}
}
