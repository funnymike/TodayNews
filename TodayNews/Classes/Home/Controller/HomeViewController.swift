//
//  HomeViewController.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/18.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit
import SGPagingView
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentScrollView: SGPageContentScrollView?
    /// 自定义导航栏
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    
    private lazy var addChannelButton: UIButton = {
        let addChannelButton = UIButton(frame: CGRect(x: kScreenWidth - newsTitleHeight, y: 0, width: newsTitleHeight, height: newsTitleHeight))
        addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        let separatorView = UIView(frame: CGRect(x: 0, y: newsTitleHeight - 1, width: newsTitleHeight, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        addChannelButton.addSubview(separatorView)
        return addChannelButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
        // 点击事件
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.theme_backgroundColor = "colors.windowColor"
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)
    }

}

// MARK: - 导航栏按钮点击
extension HomeViewController {
    private func setupUI(){
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        // 设置自定义导航栏
        navigationItem.titleView = navigationBar
        // 添加频道
        view.addSubview(addChannelButton)
        
        NetworkTool.loadHomeNewsTitleData {
            print("titles: \($0)")
            NewsTitlesTable().insert($0)
            
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = UIColor.black
            configuration.titleSelectedColor = UIColor.globalRedColor()
            configuration.indicatorColor = UIColor.clear
            // 标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - newsTitleHeight, height: newsTitleHeight), delegate: self, titleNames: $0.compactMap({ $0.name }), configure: configuration)
            self.pageTitleView!.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            
            var childVCs: Array<UIViewController> = []
            
            //设置子控制器
            _ = $0.compactMap({ (newsTitle) -> () in
                switch newsTitle.category {
                case .video: // 视频
                    let videoTableVC = VideoTableViewController()
                    videoTableVC.setupRefresh(with: .video)
                    childVCs.append(videoTableVC)
                case .essayJoke: // 段子
                    let essayJokeVC = HomeJokeViewController()
                    childVCs.append(essayJokeVC)
                case .imagePPMM: // 街拍
                    let imagePPMMVC = HomeJokeViewController()
                    childVCs.append(imagePPMMVC)
                case .imageFunny: // 趣图
                    let imagePPMMVC = HomeJokeViewController()
                    childVCs.append(imagePPMMVC)
                case .photos: // 图片,组图
                    let homeImageVC = HomeImageViewController()
                    childVCs.append(homeImageVC)
                case .jinritemai: // 特卖
                    let temaiVC = TeMailViewController()
                    childVCs.append(temaiVC)
                default:
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    childVCs.append(homeTableVC)
                }
            })

            // 内容视图
            self.pageContentScrollView = SGPageContentScrollView(frame: CGRect(x: 0, y: newsTitleHeight, width: kScreenWidth, height: self.view.height - newsTitleHeight), parentVC: self, childVCs: childVCs)
            self.pageContentScrollView!.delegatePageContentScrollView = self
            self.view.addSubview(self.pageContentScrollView!)
        }
        
    }
    
    /// 点击事件
    private func clickedAction() {
        // 搜索按钮点击
        navigationBar.didSelectAvatarButton = {
            
        }
        
        
    }
}

// MARK: - SGPageTitleViewDelegate
extension HomeViewController: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentScrollView!.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
}
