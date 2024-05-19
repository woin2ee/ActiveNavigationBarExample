//
//  DetailView.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/17/24.
//

import PinLayout
import SnapKit
import Then
import UIKit
import UIKitPlus

final class DetailView: UIView {
    
    let topImageView: UIImageView
    let containerScrollView: UIScrollView
    let topTransparentView: UIView
    let titleLabel: UILabel
    let anyContentView: UIView
    
    init() {
        topImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        containerScrollView = UIScrollView().then {
            $0.backgroundColor = .clear
        }
        topTransparentView = UIView().then {
            $0.backgroundColor = .clear
        }
        titleLabel = UILabel().then {
            $0.font = .preferredFont(forTextStyle: .title2)
        }
        anyContentView = UIView().then {
            $0.backgroundColor = .systemBackground
        }
        
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        
        self.addSubview(topImageView)
        self.addSubview(containerScrollView)
        containerScrollView.addSubview(topTransparentView)
        containerScrollView.addSubview(anyContentView)
        anyContentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var isCalculatedHeight: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topImageView.pin.top().horizontally()
        if !isCalculatedHeight {
            isCalculatedHeight = true
            topImageView.pin.height(topImageView.contentClippingRect.height)
        }
        
        let transparentViewHeight: CGFloat = min(self.frame.height * 0.4, topImageView.contentClippingRect.height)
        let contentViewHeight: CGFloat = 1200
        
        containerScrollView.pin.all()
        topTransparentView.pin.top(-self.safeAreaInsets.top).horizontally().height(transparentViewHeight)
        anyContentView.pin.below(of: topTransparentView).horizontally().height(contentViewHeight)
        titleLabel.pin.horizontally().bottom().sizeToFit(.width)
        
        containerScrollView.contentSize = CGSize(
            width: containerScrollView.bounds.width,
            height: transparentViewHeight + contentViewHeight - self.safeAreaInsets.top
        )
    }
}
