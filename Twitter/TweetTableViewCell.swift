//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Donald Truong on 2/26/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetBox: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    func setRetweeted(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {self.setRetweeted(true)}, failure: {(Error) in print("Error in retweeting: \(Error)")})
    }
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {self.setFavorite(true)}, failure: {(Error) in print("Favorite did not succeed: \(Error)")})
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {self.setFavorite(false)}, failure: { (Error) in print("Unfavorite did not succeed: \(Error)")})
        }
    }
    
}
