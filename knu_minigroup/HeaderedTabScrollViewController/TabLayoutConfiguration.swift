//
//  TabLayoutConfiguration.swift
//  knu_minigroup
//
//  Created by 홍희표 on 2020/12/01.
//  Copyright © 2020 홍희표. All rights reserved.
//

import UIKit

public class TabLayoutConfiguration {
    open var menuHeight: CGFloat = 34.0
    
    open var menuMargin: CGFloat = 15.0
    
    open var menuItemWidth: CGFloat = 111.0
    
    open var selectionIndicatorHeight: CGFloat = 3.0
    
    open var scrollAnimationDurationOnMenuItemTap: Int = 500 // Millisecons
    
    open var selectionIndicatorColor: UIColor = UIColor.white
    
    open var selectedMenuItemLabelColor: UIColor = UIColor.white
    
    open var unselectedMenuItemLabelColor: UIColor = UIColor.lightGray
    
    open var scrollMenuBackgroundColor: UIColor = UIColor.black
    
    open var viewBackgroundColor: UIColor = UIColor.white
    
    open var bottomMenuHairlineColor: UIColor = UIColor.white
    
    open var menuItemSeparatorColor: UIColor = UIColor.lightGray
    
    open var menuItemFont: UIFont = UIFont.systemFont(ofSize: 15.0)
    
    open var menuItemSeparatorPercentageHeight: CGFloat = 0.2
    
    open var menuItemSeparatorWidth: CGFloat = 0.5
    
    open var menuItemSeparatorRoundEdges: Bool = false
    
    open var addBottomMenuHairline: Bool = true
    
    open var menuItemWidthBasedOnTitleTextWidth: Bool = false
    
    open var titleTextSizeBasedOnMenuItemWidth: Bool = false
    
    open var useMenuLikeSegmentedControl: Bool = false
    
    open var centerMenuItems: Bool = false
    
    open var enableHorizontalBounce: Bool = true
    
    open var hideTopMenuBar: Bool = false
    
    public init() {
    }
}
