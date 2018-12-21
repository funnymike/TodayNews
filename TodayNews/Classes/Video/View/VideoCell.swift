//
//  VideoCell.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/20.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit
import IBAnimatable

class VideoCell: UITableViewCell, RegisterCellFromNib {
    
    /// 标题 label
    @IBOutlet weak var titleLabel: UILabel!
    /// 广告
    @IBOutlet weak var adLabel: AnimatableLabel!
    /// 播放数量
    @IBOutlet weak var playCountLabel: UILabel!
    /// 时间 label
    @IBOutlet weak var timeLabel: UILabel!
    /// 用户头像
    @IBOutlet weak var avaterButton: AnimatableButton!
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户昵称
    @IBOutlet weak var nameLabel: UILabel!
     /// 描述
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    /// 分享到 stackView
    @IBOutlet weak var shareStackView: UIStackView!
    @IBOutlet weak var shareLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var concernButton: UIButton!
    
    @IBOutlet weak var bgImageButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        bgImageButton.setImage(UIImage(named: "video_play_icon_44x44_"), for: .normal)
        shareLabel.theme_textColor = "colors.black"
        titleLabel.theme_textColor = "colors.moreLoginTextColor"
        nameLabel.theme_textColor = "colors.black"
        playCountLabel.theme_textColor = "colors.moreLoginTextColor"
        concernButton.theme_setImage("images.video_add_24x24_", forState: .normal)
        concernButton.setImage(nil, for: .selected)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.black", forState: .normal)
        concernButton.theme_setTitleColor("colors.grayColor210", forState: .selected)
        moreButton.theme_setImage("images.More_24x24_", forState: .normal)
//        adButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
//        adButton.theme_setImage("images.view detail_ad_feed_15x13_", forState: .normal)
    }
    
    /// 视频数据
    var video = NewsModel() {
        didSet {
            titleLabel.text = video.title
            playCountLabel.text = video.video_detail_info.videoWatchCount + "次播放"
            avaterButton.kf.setImage(with: URL(string: video.user_info.avatar_url), for: .normal)
            vImageView.isHidden = !video.user_info.user_verified
            concernButton.isSelected = video.user_info.follow
            bgImageButton.kf.setBackgroundImage(with: URL(string: video.video_detail_info.detail_video_large_image.urlString)!, for: .normal)
            timeLabel.text = video.videoDuration
            commentButton.setTitle(video.commentCount, for: .normal)
            commentButton.theme_setTitleColor("colors.black", forState: .normal)
            commentButton.theme_setImage("images.comment_24x24_", forState: .normal)
            concernButton.isHidden = video.label_style == .ad
            commentButton.isHidden = video.label_style == .ad
//            adButton.setTitle((video.ad_button.button_text == "" ? "查看详情" : video.ad_button.button_text), for: .normal)
            nameLabel.text = video.user_info.name
            if video.label_style == .ad {
                nameLabel.text = video.app_name != "" ? video.app_name : video.ad_button.app_name
                descriptionLabel.text = video.ad_button.description == "" ? video.sub_title : video.ad_button.description
                descriptionLabelHeight.constant = 20
                layoutIfNeeded()
            }
//            adButton.isHidden = video.label_style != .ad
//            adLabel.isHidden = video.label_style != .ad
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
