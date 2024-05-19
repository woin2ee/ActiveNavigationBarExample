//
//  DetailViewController.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/15/24.
//

import PinLayout
import SnapKit
import Then
import UIKit
import UIKitPlus

final class DetailViewController: UIViewController {

    private lazy var ownView = DetailView().then {
        $0.containerScrollView.delegate = self
    }
    let ownNavigationItem = DetailNavigationItem()
    
    override var navigationItem: UINavigationItem {
        ownNavigationItem
    }
    
    var state: State
    
    init(state: State) {
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
        
        ownView.titleLabel.text = state.title
        ownView.topImageView.image = state.topImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ownView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ownNavigationItem.backButton.target = self.navigationController
        ownNavigationItem.backButton.action = #selector(self.navigationController?.popViewController(animated:))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ownView.topImageView.contentMode = .scaleAspectFill
    }
}

extension DetailViewController {
    
    struct State {
        var topImage: UIImage
        var title: String
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let initialSpacingTopOfContentToBottomOfBar = ownView.topTransparentView.frame.height - ownView.safeAreaInsets.top
        let initialOffsetY = -ownView.safeAreaInsets.top
        let limitOffsetY = initialOffsetY + initialSpacingTopOfContentToBottomOfBar
        
        if scrollView.contentOffset.y >= limitOffsetY {
            ownNavigationItem.scrollEdgeAppearance = UINavigationBarAppearance().then {
                $0.configureWithOpaqueBackground()
            }
            ownNavigationItem.title = "Detail"
        } else {
            ownNavigationItem.scrollEdgeAppearance = UINavigationBarAppearance().then {
                $0.configureWithTransparentBackground()
            }
            ownNavigationItem.title = ""
        }
    }
}
