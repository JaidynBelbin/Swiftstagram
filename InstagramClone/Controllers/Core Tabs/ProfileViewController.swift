//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import UIKit



/// Profile view controller
class ProfileViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        // Defining the layout of the root CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let imageCellSize = (view.width - 4)/3
        layout.itemSize = CGSize(width: imageCellSize, height: imageCellSize)
        // The root CollectionView that will hold our profile header, tab section, and profile photos
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Registering each part of our CollectionView for our Profile page
        
        // Cells to hold our photos
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        // Headers for the profile section and the tabs to switch between our posts and posts we are tagged in
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView?.register(ProfileTabsCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // Need to guard because we defined the view as optional
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
    }
    
    // Adding gear icon to nav bar to access Settings Page
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        
        let vc = SettingsViewController()
        vc.title = "Settings"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Extension methods
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 0
        }
        
        return 30
    }
    
    // Dequeues or creates a new cell based on the reuse identifier we set in .register()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // For now, just displaying 30 photo cells
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.configure(debug: "test")
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            let tabHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            
            return tabHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        
       
        
        // Size of the profile header (in the first section)
        if section == 0 {
            
            let imageCellSize = (view.width - 4)/3
            let profileHeaderHeight = 3*imageCellSize - 14
            
            return CGSize(width: collectionView.width, height: profileHeaderHeight)
        }
        
        // Size of the tabs header (in the second section)
        return CGSize(width: collectionView.width, height: 40)
    }
}
