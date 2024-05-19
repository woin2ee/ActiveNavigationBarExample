//
//  DetailNavigationItem.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/18/24.
//

import SFSafeSymbols
import Then
import UIKit

final class DetailNavigationItem: UINavigationItem {
    
    let backButton: UIBarButtonItem
    let addBarButton: UIBarButtonItem
    
    init() {
        backButton = UIBarButtonItem(image: UIImage(systemSymbol: .chevronLeft))
        addBarButton = UIBarButtonItem(image: UIImage(systemSymbol: .plusApp))
        
        super.init(title: "")
        
        self.leftBarButtonItem = backButton
        self.rightBarButtonItems = [addBarButton]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.scrollEdgeAppearance = appearance
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
