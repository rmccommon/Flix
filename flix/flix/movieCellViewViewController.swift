//
//  movieCellViewViewController.swift
//  flix
//
//  Created by Sierra Klix on 9/17/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit

class movieCellViewViewController: UIViewController {
    enum MovieKeys {
        static let backDrop = "backdrop_path"
        
        
    }
    

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieBackDrop: UIImageView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if movie?.title != nil{
            movieTitle.text = movie?.title
        }
        if movie?.description != nil{
            movieOverview.text = movie?.description
        }
        if movie?.release != nil{
            releaseDate.text = movie?.release
        }
        if let mainPic = movie?.mainImageUrl{
            moviePoster.af_setImage(withURL: mainPic)
        }
        if let backPic = movie?.backgroundURL{
            movieBackDrop.af_setImage(withURL: backPic)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
