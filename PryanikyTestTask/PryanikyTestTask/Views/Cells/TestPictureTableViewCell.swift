//
//  TestPictureTableViewCell.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

class TestPictureTableViewCell: UITableViewCell, TestTableViewCell {
    
    lazy var picture: UIImageView = UIImageView()
    lazy var textInfo: UILabel = UILabel()
    var imageLoadManager: ImageLoadManager?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageLoadManager = ImageLoadManager()
        
        addSubview(picture)
        
        picture.contentMode = .scaleAspectFit
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        print(bounds.width)
        picture.heightAnchor.constraint(equalToConstant: bounds.width).isActive = true
        picture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        picture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        addSubview(textInfo)

        textInfo.translatesAutoresizingMaskIntoConstraints = false
        textInfo.textAlignment = .center
        textInfo.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 20).isActive = true
        textInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        textInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        textInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    func configure(_ data: InfoType) {
        guard case .picture(title: let title, url: let urlString) = data else { return }
        textInfo.text = title
        
        weak var weakImageView = picture
        imageLoadManager?.download(urlString,
                                   placeHolder: UIImage(named: Constants.placeholderImageName),
                                   imageView: weakImageView)
    }
    
    override func prepareForReuse() {
        imageLoadManager?.cancel()
    }
}
