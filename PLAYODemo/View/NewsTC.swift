//
//  NewsTC.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import UIKit

class NewsTC: UITableViewCell {

    @IBOutlet weak var imgView: lazyloadingIMg!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDetail(data:NewsArticlesModel){
        if let str = data.urlToImage{
        imgView.downloadImageFrom(link: str)
        }
        titleLbl.text = data.title
        authorLbl.text = data.author
        discriptionLbl.text = data.description
    }
}
