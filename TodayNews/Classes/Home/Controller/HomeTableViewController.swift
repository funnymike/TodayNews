//
//  HomeTableViewController.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/18.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit
import SVProgressHUD
import BMPlayer

class HomeTableViewController: UITableViewController {
    
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: VideoPlayerCustomView())
    /// 标题
    var newsTitle = HomeNewsTitle()
    /// 新闻数据
    var news = [NewsModel]()
    /// 刷新时间
    var maxBehotTime: TimeInterval = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.configuration()
        tableView.tableFooterView = UIView()
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.theme_separatorColor = "colors.separatorViewColor"
    }
    
    /// 设置刷新控件
    func setupRefresh(with category: NewsTitleCategory = .recommend) {
        let header = RefreshHeader { [weak self] in
            // 获取视频的新闻列表数据
            NetworkTool.loadApiNewsFeeds(category: category, ttFrom: .pull, { (timeInterval, news) in
                if self!.tableView.mj_header.isRefreshing { self!.tableView.mj_header.endRefreshing() }
                self!.player.removeFromSuperview()
                self!.maxBehotTime = timeInterval
                self!.news = news
                self!.tableView.reloadData()
            })
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        // 底部刷新控件
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
            // 获取视频的新闻列表数据，加载更多
            NetworkTool.loadMoreApiNewsFeeds(category: category, ttFrom: .loadMore, maxBehotTime: self!.maxBehotTime, listCount: self!.news.count, {
                if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
                self!.tableView.mj_footer.pullingPercent = 0.0
                self!.player.removeFromSuperview()
                if $0.count == 0 {
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦！")
                    return
                }
                self!.news += $0
                self!.tableView.reloadData()
            })
        })
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
    }
    
}
