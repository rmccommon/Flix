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
    var movie: [String:Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
             movieTitle.text = movie["title"] as? String
            movieOverview.text = movie["overview"] as? String
            releaseDate.text = movie["release_date"] as? String
            let backdropPath = movie[MovieKeys.backDrop] as! String
            let posterPath = movie["poster_path"] as! String
            let baseURLpath =  "https://image.tmdb.org/t/p/w500"
            let backDropURL = URL(string: baseURLpath + backdropPath)!
            let posterURL = URL(string: baseURLpath + posterPath)!
            moviePoster.af_setImage(withURL: posterURL)
            movieBackDrop.af_setImage(withURL: backDropURL)
            
            
            
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
