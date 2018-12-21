//
//  VideoTableViewController.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/19.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BMPlayer
import SnapKit
import SVProgressHUD

class VideoTableViewController: HomeTableViewController {
    
    private lazy var disposeBag = DisposeBag()
    /// 上一次播放的 cell
    private var priorCell: VideoCell?
    /// 视频真实地址
    private var realVideo = RealVideo()
    /// 当前播放的时间
    private var currentTime: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self as? BMPlayerDelegate
        tableView.rowHeight = kScreenWidth * 0.67
        tableView.ym_registerCell(cell: VideoCell.self)
    }

    
}

extension VideoTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as VideoCell
        cell.video = news[indexPath.row]
        return cell
    }
    
}
