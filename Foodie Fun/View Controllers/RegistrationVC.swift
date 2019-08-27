//
//  RegistrationVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmPwTextField: UITextField!
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	//MARK: - IBActions
	
	@IBAction func CreateAccountBtnTapped(_ sender: Any) {
		guard let username = usernameTextField.optionalText, let password = passwordTextField.optionalText, confirmPassword() else { return }
		let loginRequest = LoginRequest(username: username, password: password)
		
		NetworkManager.shared.register(newUser: loginRequest) { (loginId, error) in
			if let error = error {
				NSLog(error)
			}
			
			guard loginId != nil else { return }
			SettingsController.shared.persist(credentials: loginRequest)
			
			self.continuetoNextScreen()
		}
	}
	
	//MARK: - Helpers
	
	private func confirmPassword() -> Bool {
		guard let password = passwordTextField.optionalText, let confirmPw = confirmPwTextField.optionalText, password == confirmPw else {
			let alert = UIAlertController(title: "Passwords mismatch", message: nil, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
				self.confirmPwTextField.text = ""
				self.passwordTextField.text = ""
				self.passwordTextField.becomeFirstResponder()
			}))
			self.present(alert, animated: true)
			
			return false
		}
		return true
	}
	
	private func continuetoNextScreen() {
		if SettingsController.shared.isFreshInstall {
			navigationController?.popViewController(animated: true)
		} else {
			if let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() {
				self.present(searchVC, animated: true, completion: nil)
			}
		}
	}
	
}
