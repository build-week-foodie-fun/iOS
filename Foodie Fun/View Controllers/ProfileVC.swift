//
//  ProfileVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var nameLbl: UILabel!
	@IBOutlet weak var postCountLbl: UILabel!
	@IBOutlet weak var followersCountLbl: UILabel!
	@IBOutlet weak var followingCountLbl: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	
	//MARK: - Properties
	
	private var posts = [Review]()
	
	//MARK: - Life Cycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		updateViews()
		loadPosts()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.dataSource = self
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let reviewVC = segue.destination as? ViewReviewVC {
			guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
			reviewVC.review = posts[indexPath.item]
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func updateViews() {
		nameLbl.text = SettingsController.shared.loggedInUser?.username
	}
	
	private func loadPosts() {
		NetworkManager.shared.getAllReviews { (reviews, error) in
			if let error = error {
				NSLog(error)
			}
			
			guard let reviews = reviews else { return }
			let loggedInUserId = SettingsController.shared.loggedInUser?.id
			self.posts = reviews.filter({$0.userId == loggedInUserId})
			DispatchQueue.main.async {
				self.postCountLbl.text = "\(reviews.count)"
				self.collectionView.reloadData()
			}
		}
	}
}

//MARK: - CollectionView Datasource

extension ProfileVC: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? PostCell else { return UICollectionViewCell() }
		
		cell.post = posts[indexPath.item]
		return cell
	}
}
