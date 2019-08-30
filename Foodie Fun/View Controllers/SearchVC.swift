//
//  SearchVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	//MARK: - Properties
	
	private var posts = [Review]()
	private var filteredPosts = [Review]()
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchBar.delegate = self
		collectionView.dataSource = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		loadReviews()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let reviewVC = segue.destination as? ViewReviewVC {
			guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
			reviewVC.review = posts[indexPath.item]
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func loadReviews() {
		NetworkManager.shared.getAllReviews { (reviews, error) in
			if let error = error {
				NSLog(error)
			}
			
			guard let reviews = reviews else { return }
			self.posts = reviews
			self.filteredPosts = reviews
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
}

//MARK: - SearchBar Delegate

extension SearchVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			filteredPosts = posts
		} else {
			let searchText = searchText.lowercased()
			
			filteredPosts = posts.filter({$0.restaurantName.lowercased().contains(searchText) || $0.restaurantType.lowercased().contains(searchText) || $0.itemName.lowercased().contains(searchText)})
		}
		
		collectionView.reloadData()
	}
}

//MARK: - CollectionView Datasource

extension SearchVC: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return filteredPosts.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UICollectionViewCell() }
		
		cell.review = filteredPosts[indexPath.item]
		return cell
	}
	
}
