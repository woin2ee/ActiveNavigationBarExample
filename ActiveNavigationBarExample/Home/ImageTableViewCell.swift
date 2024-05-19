//
//  ImageTableViewCell.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/15/24.
//

import SnapKit
import Then
import UIKit
import UIKitPlus

final class ImageTableViewCell: UITableViewCell {

    let primaryImageView: UIImageView
    private let activityIndicatorView: UIActivityIndicatorView
    let nameLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        primaryImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        nameLabel = UILabel().then {
            $0.font = .preferredFont(forTextStyle: .body)
        }
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemGroupedBackground
        
        contentView.addSubview(primaryImageView)
        primaryImageView.addSubview(activityIndicatorView)
        contentView.addSubview(nameLabel)
        
        let defaultSpacing: CGFloat = 14
        
        primaryImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView).inset(defaultSpacing)
            make.width.equalTo(180).priority(999)
            make.height.equalTo(primaryImageView.snp.width).multipliedBy(2/3.0)
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(defaultSpacing)
            make.leading.equalTo(primaryImageView.snp.trailing).offset(defaultSpacing)
            make.trailing.equalTo(contentView).inset(defaultSpacing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(image: UIImage) {
        activityIndicatorView.stopAnimating()
        primaryImageView.image = image
        primaryImageView.backgroundColor = .clear
    }
    
    func update(name: String) {
        nameLabel.text = name
        nameLabel.backgroundColor = .clear
    }
    
    func transitionToSkeletonView() {
        primaryImageView.image = nil
        primaryImageView.backgroundColor = .systemGray5
        activityIndicatorView.startAnimating()
        nameLabel.text = " "
        nameLabel.backgroundColor = .systemGray5
    }
}
