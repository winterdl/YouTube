//
//  ApiService.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/14/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let shared = ApiService()
    
    func fetchVideos (completion: @escaping ([Video]) -> ()) {
        fetchFeedForURLString(urlString: .home, completion: completion)

    }
    
    func fetchTrendingFeed (completion: @escaping ([Video]) -> ()) {
        fetchFeedForURLString(urlString: .trending, completion: completion)
        
    }
    
    func fetchSubscriptionFeed (completion: @escaping ([Video]) -> ()) {
        fetchFeedForURLString(urlString: .subscriptions, completion: completion)
        
    }
   
    private enum URLFeed: String {
        case home = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        case trending = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        case subscriptions = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
    }
    
   private func fetchFeedForURLString(urlString: URLFeed, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString.rawValue)
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print (error ?? "error")
                return
            }
            do {
                if let unwrapedData = data, let jsonDictionary = try JSONSerialization.jsonObject(with: unwrapedData, options: .mutableContainers) as? [[String: AnyObject]] {
                    
                        DispatchQueue.main.async {
                            completion(jsonDictionary.map({return Video(dictionary: $0)}))
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }

}

// 

//let json = try JSONSerialization.jsonObject(with: data!,
//                                            options: .mutableContainers)
//var videos = [Video]()
//for dictionary in json as! [[String: AnyObject]] {
//    
//    let video = Video()
//    video.title = dictionary["title"] as! String?
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as! String?
//    video.numberOfViews = dictionary["number_of_views"] as! NSNumber?
//    
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as! String?
//    channel.profileImageName = channelDictionary["profile_image_name"] as! String?
//    video.channel = channel
//    
//    videos.append(video)
//}
//
//DispatchQueue.main.async {
//    completion(videos)
//}

