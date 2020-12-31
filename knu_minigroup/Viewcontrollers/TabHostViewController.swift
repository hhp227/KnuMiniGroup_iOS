//
//  TabHostViewController.swift
//  knu_minigroup
//
//  Created by 홍희표 on 2020/10/12.
//  Copyright © 2020 홍희표. All rights reserved.
//

import UIKit

class TabHostViewController: HeaderedCAPSPageMenuViewController {
    let tabsTexts = ["소식", "일정", "맴버", "설정"]
    
    @IBOutlet weak var header: UIView!
    
    //private var navBarOverlay: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView = header
        
        /*var controllers = [
            storyboard?.instantiateViewController(withIdentifier: "Tab1ViewController") as! UIViewController,
            storyboard?.instantiateViewController(withIdentifier: "Tab2ViewController") as! UIViewController,
            storyboard?.instantiateViewController(withIdentifier: "Tab3ViewController") as! UIViewController,
            storyboard?.instantiateViewController(withIdentifier: "Tab4ViewController") as! UIViewController
        ]*/
        var controllers: [UIViewController] = []
        
        for i in 0 ..< tabsTexts.count {
            let vc = PlaceholderViewController()
            vc.placeholderContent = MockupData.subpagesContent[i]
            vc.contentText.backgroundColor = #colorLiteral(red: 0.07159858197, green: 0.09406698495, blue: 0.1027848646, alpha: 1)
            vc.contentText.textColor = .white
            vc.scrollDelegateFunc = { [weak self] in self?.pleaseScroll($0) }
            
            vc.title = tabsTexts[i]
            controllers.append(vc)
        }
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(#colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1019607843, alpha: 0.5)),
            .viewBackgroundColor(#colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1019607843, alpha: 0.5)),
            .bottomMenuHairlineColor(UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 0.1)),
            .selectionIndicatorColor(#colorLiteral(red: 0.8404174447, green: 0.396413058, blue: 0, alpha: 1)),
            .menuMargin(0.0),
            .menuHeight(40.0),
            .selectedMenuItemLabelColor(.white),
            .unselectedMenuItemLabelColor(.white),
            .useMenuLikeSegmentedControl(true),
            .selectionIndicatorHeight(2.0),
            .menuItemFont(UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)),
            .menuItemWidthBasedOnTitleTextWidth(false)
        ]
        
        self.addPageMenu(menu: CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: 0, width: pageMenuContainer.frame.width, height: pageMenuContainer.frame.height), pageMenuOptions: parameters))
        
        self.headerBackgroundColor = #colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1019607843, alpha: 1)
        //self.navBarTransparancy = 0
        self.navBarItemsColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Knu MiniGroup"
        if let navController = self.navigationController {
            let navBar = navController.navigationBar
            navBar.shadowImage = UIImage()
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)]
            
            // navBar 투명하게 해줌
            navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            /*if navBarOverlay == nil {
                navBarOverlay = UIView.init(frame: CGRect.init(x: 0, y: 0, width: navBar.bounds.width, height: self.navBarOffset()))
            }
            navBarOverlay!.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
            navBar.subviews.first?.insertSubview(navBarOverlay!, at: 0)
            navBarOverlay!.backgroundColor = navBarColor.withAlphaComponent(0.0)*/
        }
        
        //self.navBarColor = #colorLiteral(red: 0.07159858197, green: 0.09406698495, blue: 0.1027848646, alpha: 0)
        //UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let navCtrl = self.navigationController {
            let navBar = navCtrl.navigationBar
            navBar.shadowImage = nil
            
            navBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            //navBarOverlay?.removeFromSuperview()
            navCtrl.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:self.navBarItemsColor.withAlphaComponent(1)]
        }
    }
    
    override func headerDidScroll(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        updateNavBarAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
        updateHeaderPositionAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
        updateHeaderAlphaAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
    }
    
    public override func updateNavBarAccordingToScrollPosition(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        let alphaOffset: CGFloat = (minY - maxY) * 0.3 // alpha start changing at 1/3 of the way up
        var alpha = (currentY + alphaOffset - minY) / (maxY + alphaOffset - minY)
        if currentY > minY - alphaOffset {
            alpha = 0
        }
        
        //self.navBarTransparancy = alpha
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct MockupData {
    static let title = "Mockup title of a mockup header"
    static let description = "That's a mockup description for a mockup header"
    static let subpagesContent = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus lectus quis lectus accumsan rhoncus. Nam fermentum nec neque eu rutrum. Aenean vehicula ut erat id scelerisque. Mauris molestie egestas dolor, eget sodales ipsum accumsan ac. Nullam sit amet rutrum massa. Nam quis euismod justo. Nulla elementum, mi sed tempus vulputate, diam lorem hendrerit mauris, vel elementum sem dui eu purus. Fusce lectus enim, tempor id mollis sit amet, sodales sed arcu. Nunc vehicula rhoncus metus in facilisis. Nulla malesuada dui eget ante tempor sagittis. In nisi risus, fringilla sit amet vestibulum eu, euismod at enim. Fusce blandit lectus lacus, eu volutpat magna egestas et. Vestibulum finibus, purus eget eleifend pretium, lacus ipsum vehicula tortor, a porta massa dolor ut leo. Vivamus sit amet augue sed nisi placerat tincidunt tincidunt ac orci.\n\nPraesent faucibus dictum quam eu interdum. Suspendisse non purus at est efficitur porttitor sed posuere tellus. Nam interdum non ante eu molestie. Nunc at commodo dui. Etiam lorem est, aliquam consequat elementum at, cursus vitae augue. Cras dapibus, velit quis interdum tempus, sapien erat posuere elit, eget sagittis libero sapien in risus. Proin viverra rhoncus finibus. Aenean sollicitudin eget neque non malesuada. Duis sollicitudin metus ac mi placerat dapibus. Vivamus efficitur fringilla turpis, vitae imperdiet libero varius non. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin dapibus semper diam, vitae tincidunt odio elementum sed. Pellentesque tortor enim, pulvinar ac erat nec, facilisis venenatis elit. Pellentesque vel est iaculis, ornare risus in, egestas massa. Proin volutpat imperdiet porta. Fusce ac metus at orci euismod tincidunt in nec ante.\n\nNulla posuere lacinia egestas. Donec at urna vitae sem porta tempor. In tincidunt nisl at lectus posuere, in vehicula lectus egestas. Integer pulvinar lacinia elit, ut efficitur nisi. Duis velit dui, tincidunt at eros tristique, congue porta enim. Etiam aliquet nisl sed nunc auctor hendrerit. In sit amet risus feugiat, egestas neque ac, volutpat nulla.\n\nNulla eget cursus massa, eget malesuada tortor. Suspendisse blandit lorem sit amet ipsum convallis, ut feugiat nisi maximus. Maecenas in nisl nec justo semper efficitur. Phasellus vitae lacinia sem. Proin condimentum ultrices lectus quis sollicitudin. Morbi a tortor arcu. Morbi interdum massa venenatis felis malesuada porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "In id feugiat sem. Integer arcu est, ultrices ut ornare et, sodales nec mi. Quisque nec lacus turpis. Curabitur non ante quis velit placerat gravida ut at magna. Nullam convallis non massa in congue. Etiam libero felis, scelerisque sed sapien sit amet, sodales placerat leo. Donec sit amet arcu sed lorem tincidunt vestibulum.\n\nAliquam a lectus vel neque viverra ultrices sit amet non odio. Morbi efficitur malesuada erat, eu sollicitudin turpis tincidunt ac. Morbi ultricies ante at risus efficitur, quis vestibulum lacus volutpat. Praesent sit amet augue at turpis porta interdum vulputate ac diam. Nam aliquet leo odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum posuere commodo gravida. Maecenas venenatis est ut gravida auctor. Cras at urna semper, convallis diam eget, iaculis purus. Nam nunc libero, porttitor quis scelerisque non, mollis sit amet turpis. Duis tempus turpis quis arcu pulvinar, vitae congue eros auctor.\n\nPraesent pulvinar eleifend justo, ac maximus eros luctus ac. Donec vestibulum dignissim convallis. Donec ornare aliquet nibh. Duis vitae lorem congue, consequat nisl id, rutrum orci. Pellentesque dapibus est ac metus interdum ultrices. Etiam egestas mauris a risus facilisis porta. Maecenas bibendum semper aliquam.\n\nUt laoreet est quis gravida scelerisque. Suspendisse posuere, neque quis euismod vulputate, odio massa porttitor ante, a consequat mi erat eget lorem. Nullam massa eros, suscipit eget augue at, tristique vehicula sapien. Nulla at gravida nulla. Proin rhoncus tincidunt nibh et bibendum. Nullam rutrum tortor sapien, posuere ornare mauris mattis ut. Duis congue in ante sed vestibulum. Cras eu porttitor lacus. Phasellus pharetra lacus vel posuere bibendum. Proin interdum dui vel turpis posuere, non vulputate turpis suscipit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Donec et odio quis ante congue consectetur rutrum sed metus. Cras efficitur ac nisl et vestibulum. In enim urna, lacinia non nulla vitae, imperdiet efficitur tortor. Ut odio lectus, tincidunt sodales nunc nec, mollis ultricies dui. Sed commodo, purus et egestas maximus, tortor mauris sollicitudin ligula, quis lacinia urna erat in orci. Morbi mattis nisi mollis urna posuere lacinia. Suspendisse vulputate sit amet magna vel egestas. Morbi gravida tortor eget malesuada accumsan. Proin sed ultricies quam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse vitae nibh vehicula, accumsan sapien at, porta augue. Nullam consequat tellus quis diam ornare hendrerit. In ut scelerisque velit.","Integer maximus varius ex id facilisis. Maecenas et lacus tellus. Sed urna neque, euismod et luctus ac, sodales facilisis turpis. Integer vitae tristique mi, vitae convallis nisi. Morbi tellus tellus, tempor mattis augue at, convallis volutpat tortor. Maecenas sapien dolor, accumsan vel lectus a, tempor facilisis lorem. Duis auctor ligula quis tristique ornare. Etiam consequat fermentum urna, id aliquam ligula hendrerit at. Vivamus ut eros luctus, cursus massa ut, auctor dolor. Proin aliquam nisl urna, eu consequat felis consectetur et. Sed a turpis placerat, tempor risus ut, vehicula eros. Praesent pharetra, mauris id auctor tincidunt, magna elit volutpat risus, sed pellentesque erat purus et tortor. Sed luctus risus sodales enim suscipit, at iaculis arcu molestie. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam molestie augue in est placerat porttitor. Sed vitae libero tempus enim pretium sollicitudin vel vel eros.\n\nInteger eget turpis vitae neque pellentesque suscipit varius sed magna. Suspendisse vel dapibus nisi. Phasellus vel turpis ut tellus congue convallis. Fusce dignissim efficitur pellentesque. Curabitur eget leo et purus dapibus molestie. Ut lorem enim, tempor eget tincidunt ut, tempor a eros. Ut risus mi, consectetur et leo non, congue aliquet est. In mi velit, iaculis nec turpis id, luctus fermentum massa. Vestibulum volutpat augue sit amet nulla elementum, sit amet aliquet sapien facilisis. Suspendisse egestas erat eget eleifend tristique. Suspendisse non tempus tellus. Quisque vitae justo at leo cursus tristique vel id lectus. Fusce ac fringilla leo, vitae convallis nulla. Nunc auctor mockup arcu et molestie. Aenean ut enim mauris.\n\nSed sollicitudin maximus ex, sit amet ultrices lacus mattis sed. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla vel sapien pretium, mollis odio vitae, posuere neque. Duis a nulla velit. Quisque nec metus sed nisi luctus pulvinar eu vitae nunc. Sed tincidunt auctor tellus, tristique sollicitudin libero lobortis eget. Integer sollicitudin quam vel mauris luctus, nec efficitur ex condimentum. Donec tristique ac neque nec posuere. Phasellus dui est, tempor id vulputate in, euismod id libero. Donec ut efficitur quam, vitae eleifend metus. Praesent vulputate eros libero, id posuere ipsum suscipit sed. Fusce ut est non sapien aliquet ultrices in sit amet eros. Curabitur fermentum sapien vel fringilla pretium. Ut hendrerit pellentesque metus id rutrum.\n\nNunc nec lacinia velit. Nam id dolor maximus, congue dolor ut, sagittis quam. Vestibulum suscipit libero non nulla tincidunt bibendum. Nunc lorem urna, faucibus eget blandit non, condimentum eget felis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam non justo ante. Duis metus augue, accumsan imperdiet ligula sed, varius mattis purus.\n\nNunc lacinia libero nec dui faucibus, id eleifend massa feugiat. Fusce non iaculis libero, vel pretium ligula. Nullam non nulla sed urna imperdiet semper. Donec vel lorem quis lorem hendrerit posuere in vitae massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam hendrerit eu elit ac lobortis. Suspendisse diam sem, bibendum sed pellentesque eget, luctus sed metus. Aliquam ac semper enim. Fusce pretium sem ac tincidunt facilisis. Nam tincidunt magna sit amet luctus laoreet.\n\nNunc quis vestibulum ex, id egestas arcu. Phasellus vitae est a sapien egestas dapibus. Phasellus sed lectus arcu. Proin quam nulla, consectetur et mattis non, suscipit in urna. Curabitur non commodo eros. Sed rhoncus, diam sit amet laoreet efficitur, nisl ligula viverra erat, ut vehicula mauris quam non orci. Nullam nec aliquet erat, ac hendrerit erat. Suspendisse potenti. Aenean molestie dolor eu bibendum semper. Vestibulum ut purus ultrices, elementum sem sit amet, luctus nisi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque rutrum eros at ante pulvinar lacinia. Quisque vitae condimentum augue. Etiam viverra, arcu mollis vulputate pulvinar, erat nibh accumsan elit, non facilisis sapien purus vitae ligula. Pellentesque lacinia turpis a metus mollis maximus."]
    static let subpagesTitles = ["Spaghetti", "Guacamole", "Pizzaaa!", "IMayBeHungry"]
}


public enum CAPSPageMenuOption {
    case selectionIndicatorHeight(CGFloat)
    case menuItemSeparatorWidth(CGFloat)
    case scrollMenuBackgroundColor(UIColor)
    case viewBackgroundColor(UIColor)
    case bottomMenuHairlineColor(UIColor)
    case selectionIndicatorColor(UIColor)
    case menuItemSeparatorColor(UIColor)
    case menuMargin(CGFloat)
    case menuItemMargin(CGFloat)
    case menuHeight(CGFloat)
    case selectedMenuItemLabelColor(UIColor)
    case unselectedMenuItemLabelColor(UIColor)
    case useMenuLikeSegmentedControl(Bool)
    case menuItemSeparatorRoundEdges(Bool)
    case menuItemFont(UIFont)
    case menuItemSeparatorPercentageHeight(CGFloat)
    case menuItemWidth(CGFloat)
    case enableHorizontalBounce(Bool)
    case addBottomMenuHairline(Bool)
    case menuItemWidthBasedOnTitleTextWidth(Bool)
    case titleTextSizeBasedOnMenuItemWidth(Bool)
    case scrollAnimationDurationOnMenuItemTap(Int)
    case centerMenuItems(Bool)
    case hideTopMenuBar(Bool)
}
