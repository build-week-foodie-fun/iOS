//
//  SearchVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class SearchVC: UIViewController {

	//MARK: - IBOutlets
	
	private let locationManager = CLLocationManager()
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	
}

// MARK: - CLLocation Manager Delegate

extension SearchVC: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedWhenInUse else {
			return
		}
		
		locationManager.startUpdatingLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		locationManager.stopUpdatingLocation()
	}
}
