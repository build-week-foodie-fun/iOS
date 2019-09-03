//
//  ManageProfileVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ManageProfileVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var autoLoginSwitch: UISwitch!
	
	//MARK: - Properties
	
	private let imagePicker = UIImagePickerController()
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePicker.delegate = self
		updateViews()
	}
	
	//MARK: - IBActions
	
	@IBAction func addPhotoBtnTapped(_ sender: Any) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .photoLibrary
		
		present(imagePicker, animated: true, completion: nil)
	}
	
	@IBAction func toggleAutoLoginTapped(_ sender: Any) {
		SettingsController.shared.isSaveCredentials.toggle()
	}
	
	//MARK: - Helpers
	
	private func updateViews() {
		imgView.image = SettingsController.shared.userProfileImg
		autoLoginSwitch.isOn = SettingsController.shared.isSaveCredentials
	}
}

extension ManageProfileVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {		
		if let possibleImage = info[.editedImage] as? UIImage {
			imgView.image = possibleImage
		} else if let possibleImage = info[.originalImage] as? UIImage {
			imgView.image = possibleImage
		} else {
			return
		}
		SettingsController.shared.userProfileImg = imgView.image
		
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
