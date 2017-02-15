//
//  TrendingCell.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/15/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.shared.fetchTrendingFeed(completion: {
            (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        })
    }
}
