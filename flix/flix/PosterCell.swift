//
//  PosterCell.swift
//  flix
//
//  Created by Sierra Klix on 9/21/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    var movie : Movie?{
        didSet{
            if let mainPic = movie?.mainImageUrl{
                posterImage.af_setImage(withURL: mainPic)
            }
        }
    }
    
}
