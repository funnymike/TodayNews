//
//  MyTabBarController.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/18.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        //添加子控制器
        addChildViewControllers()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked(notifaction:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    
    /// 添加子控制器
    private func addChildViewControllers(){
        setChildViewController(HomeViewController(), title: "首页", imageName: "home")
        setChildViewController(VideoViewController(), title: "西瓜视频", imageName: "video")
        setChildViewController(RedPackageViewController(), title: "", imageName: "redpackage")
        setChildViewController(WeitoutiaoViewController(), title: "微头条", imageName: "weitoutiao")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan")
    }
    
    /// 初始化子控制器
    ///
    /// - Parameters:
    ///   - childController: 子控制器
    ///   - title: 标题
    ///   - imageName: 图片名称
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(childController, imageName: imageName)
        }else{
            setDayChildController(childController, imageName: imageName)
        }
        childController.title = title
        addChild(MyNavigationController(rootViewController: childController))
    }
    
    /// 接收到了按钮点击的通知
    ///
    /// - Parameter notifaction: 通知
    @objc func receiveDayOrNightButtonClicked(notifaction: Notification) {
        let selected = notifaction.object as! Bool
        if selected {//设置为夜间
            for childController in children {
                switch childController.title! {
                case "首页":
                    setNightChildController(childController, imageName: "home")
                case "西瓜视频":
                    setNightChildController(childController, imageName: "video")
                case "小视频":
                    setNightChildController(childController, imageName: "huoshan")
                case "微头条":
                    setNightChildController(childController, imageName: "weitoutiao")
                case "":
                    setNightChildController(childController, imageName: "redpackage")
                default:
                    break
                }
            }
        }else{// 设置为日间
            for childController in children {
                switch childController.title! {
                case "首页":
                    setDayChildController(childController, imageName: "home")
                case "西瓜视频":
                    setDayChildController(childController, imageName: "video")
                case "小视频":
                    setDayChildController(childController, imageName: "huoshan")
                case "微头条":
                    setDayChildController(childController, imageName: "weitoutiao")
                case "":
                    setDayChildController(childController, imageName: "redpackage")
                default:
                    break
                }
            }
        }
    }
    
    /// 设置日间控制器
    private func setDayChildController(_ controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    /// 设置夜间控制器
    private func setNightChildController(_ controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
