//
//  LoginVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let loginRequest = SettingsController.shared.userCredentials {
			loginUser(loginRequest)
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		usernameTextField.becomeFirstResponder()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		SettingsController.shared.isSaveCredentials = true
	}
	
	//MARK: - IBActions
	
	@IBAction func signInBtnTapped(_ sender: Any) {
		guard let username = usernameTextField.optionalText, let password = passwordTextField.optionalText else { return }
		let loginRequest = LoginRequest(username: username, password: password)
		
		loginUser(loginRequest)
	}
	
	//MARK: - Helpers
	
	private func loginUser(_ loginRequest: LoginRequest) {
		NetworkManager.shared.login(credentials: loginRequest) { (login, error) in
			if let error = error {
				NSLog(error)
			}
			
			guard let login = login else { return }
			SettingsController.shared.persist(credentials: loginRequest)
			SettingsController.shared.loginProcedure(login)
			
			DispatchQueue.main.async {
				if SettingsController.shared.isFreshInstall {
					SettingsController.shared.isFreshInstall = false
					self.performSegue(withIdentifier: "TutorialSegue", sender: nil)
				} else if let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() {
					self.present(mainVC, animated: true, completion: nil)
				}
			}
		}
	}
}

