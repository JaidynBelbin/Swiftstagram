//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 21/2/21.
//

import UIKit

/// Header Collection view
class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
