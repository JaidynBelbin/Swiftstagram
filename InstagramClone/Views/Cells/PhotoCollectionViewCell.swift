//
//  PhotoCollectionViewCell.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 21/2/21.
//
import SDWebImage
import UIKit

/// CollectionViewCell that will hold a single photo on our Profile page
class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        accessibilityLabel = "Image of mountain"
        accessibilityHint = "Double tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        let url = model.thumbnailImageURL
        
        photoImageView.sd_setImage(with: url, completed: nil)
    }
    
    public func configure(debug imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}
