//
//  BRPhotoLibraryCell.swift
//  Bird
//
//  Created by Justin Wells on 6/14/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BRPhotoLibraryCell :UICollectionViewCell{
    
    var imageView = UIImageView()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BRColor.faintGray
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
    }
}
