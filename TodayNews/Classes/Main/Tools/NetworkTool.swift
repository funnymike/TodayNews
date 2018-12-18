//
//  NetworkTool.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/18.
//  Copyright © 2018 Hi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    // MARK: 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    // MARK: 点击首页加号按钮，获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitle]) -> ())
    // MARK: 首页顶部导航栏搜索推荐标题内容
    static func loadHomeSearchSuggestInfo(_ completionHandler: @escaping (_ searchSuggest: String) -> ())
//    // MARK: 获取首页、视频、小视频的新闻列表数据
//    static func loadApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ())
//    // MARK: 获取首页、视频、小视频的新闻列表数据,加载更多
//    static func loadMoreApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ())
//    // MARK: 获取一般新闻详情数据
//    static func loadCommenNewsDetail(articleURL: String, completionHandler:@escaping (_ htmlString: String, _ images: [NewsDetailImage], _ abstracts: [String])->())
//    // MARK: 获取图片新闻详情数据
//    static func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->())
//
//    // MARK: - --------------------------------- 视频 video  ---------------------------------
//    // MARK: 视频顶部新闻标题的数据
//    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
//    // MARK: 解析头条的视频真实播放地址
//    static func parseVideoRealURL(video_id: String, completionHandler: @escaping (_ realVideo: RealVideo) -> ())
//    // MARK: 视频详情数据
//    static func loadArticleInformation(from: String, itemId: Int, groupId: Int, completionHandler: @escaping (_ videoDetail: VideoDetail) -> ())
//
//    // MARK: - --------------------------------- 我的 mine  ---------------------------------
//    // MARK: 我的界面 cell 的数据
//    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
//    // MARK: 我的关注数据
//    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
//    // MARK: 获取用户详情数据
//    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> ())
//    // MARK: 已关注用户，取消关注
//    static func loadRelationUnfollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> ())
//    // MARK: 点击关注按钮，关注用户
//    static func loadRelationFollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> ())
//    // MARK: 点击了关注按钮，就会出现相关推荐数据
//    static func loadRelationUserRecommend(userId: Int, completionHandler: @escaping (_ concerns: [UserCard]) -> ())
//    // MARK: 获取用户详情的动态列表数据
//    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int,_ dongtais: [UserDetailDongtai]) -> ())
//    // MARK: 获取用户详情的文章列表数据
//    static func loadUserDetailArticleList(userId: Int, completionHandler: @escaping (_ dongtais: [UserDetailDongtai]) -> ())
//    // MARK: 获取用户详情的问答列表数据
//    static func loadUserDetailWendaList(userId: Int, cursor: String, completionHandler: @escaping (_ cursor: String,_ wendas: [UserDetailWenda]) -> ())
//    // MARK: 获取用户详情的动态详细内容 **暂未使用本方法**
//    static func loadUserDetailDongTaiDetailContent(threadId: String, completionHandler: @escaping (_ detailContent: UserDetailDongtai) -> ())
//    // MARK: 获取用户详情的动态转发或引用内容 **暂未使用本方法**
//    static func loadUserDetailDongTaiDetailCommentOrQuote(commentId: Int, completionHandler: @escaping (_ detailComment: UserDetailDongtai) -> ())
//    // MARK: 获取用户详情一般的详情的评论数据
//    static func loadUserDetailNormalDongtaiComents(groupId: Int, offset: Int, count: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())
//    // MARK: 获取用户详情其他类型的详情的评论数据
//    static func loadUserDetailQuoteDongtaiComents(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())
//    // MARK: 获取动态详情的用户点赞列表数据
//    static func loadDongtaiDetailUserDiggList(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiUserDigg]) -> ())
//    // MARK: 获取问答的列表数据（提出了问题）
//    static func loadProposeQuestionBrow(qid: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())
//    // MARK: 获取问答的列表数据（提出了问题），加载更多
//    static func loadMoreProposeQuestionBrow(qid: Int, offset: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())
//
//    // MARK: - --------------------------------- 小视频  ---------------------------------
//    // MARK: 小视频导航栏标题的数据
//    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
//    // MARK: - --------------------------------- 新年活动 ---------------------------------
//    // MARK: 获取新年活动数据
//    static func loadNewYearActivities(completionHandler: @escaping (_ newYear: NewYear) -> ())
//    // MARK: 增加抽卡次数
//    static func loadFestivalActivityTasks(completionHandler: @escaping (_ tasks: [NewYearTask]) -> ())
}

extension NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    
    /// 首页顶部新闻标题的数据
    ///
    /// - Parameter completionHandler: 返回标题数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()){
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let dataDict = json["data"].dictionary {
                    if let datas = dataDict["data"]?.arrayObject {
                        var titles = [HomeNewsTitle]()
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                        titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
    /// 点击首页加号按钮，获取频道推荐数据
    ///
    /// - Parameter completionHandler: 返回标题数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitle]) -> ()){
        let url = BASE_URL + "/article/category/get_extra/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    completionHandler(data.compactMap({
                        HomeNewsTitle.deserialize(from: ($0 as! [String: Any]))
                    }))
                }
            }
        }
    }
    
    /// 首页顶部导航栏搜索推荐标题内容
    ///
    /// - Parameter completionHandler: 返回搜索建议数据
    static func loadHomeSearchSuggestInfo(_ completionHandler: @escaping (_ searchSuggest: String) -> ()){
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let data = json["data"].dictionary {
                    completionHandler(data["homepage_search_suggest"]!.string!)
                }
            }
        }
    }
}

struct NetworkTool: NetworkToolProtocol {}
