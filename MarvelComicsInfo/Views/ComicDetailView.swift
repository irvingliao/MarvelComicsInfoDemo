//
//  ComicDetailView.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/10/21.
//

import UIKit
import SDWebImage

class ComicDetailView: UIView {
    
    var imageView = UIImageView(frame: .zero)
    var titleLabel = UILabel(frame: .zero)
    var descriptionTextView = UITextView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isScrollEnabled = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionTextView)
        
        setupLayout()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    func update(comicData: ComicData) {
        titleLabel.text = comicData.title
        
        if let desc = comicData.description {
            descriptionTextView.attributedText = desc.htmlToAttributedString
        }
        
        if let imageUrl = URL(string: "\(comicData.thumbnail.path).\(comicData.thumbnail.ext)"),
           var urlComponents = URLComponents(url: imageUrl, resolvingAgainstBaseURL: true) {
            urlComponents.scheme = "https"
            imageView.sd_setImage(with: urlComponents.url!) { image, _, _, _ in
                guard let image = image else {
                    return
                }
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFit
                
                let ratio = image.size.width > 1 ? image.size.height/image.size.width : 1
                let width = self.bounds.size.width*0.5 - 20
                
                self.imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
                self.imageView.heightAnchor.constraint(equalToConstant: width*ratio).isActive = true
            }
        }
    }
}
