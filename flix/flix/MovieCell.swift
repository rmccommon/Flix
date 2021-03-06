//
//  MovieCell.swift
//  flix
//
//  Created by Sierra Klix on 9/14/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    var movie: Movie?{
        didSet{
            title.text = movie?.title
            overview.text = movie?.description
            if let pic = movie?.mainImageUrl{
                movieImage.af_setImage(withURL: pic)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
