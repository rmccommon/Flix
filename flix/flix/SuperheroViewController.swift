//
//  SuperheroViewController.swift
//  flix
//
//  Created by Sierra Klix on 9/21/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperheroViewController: UIViewController,UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var movieSearch: UISearchBar!
    
    var movies: [Movie] = []
    var allMovies: [Movie] = []
    
    var refreshController:UIRefreshControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        movieSearch.delegate = self
        MovieApiManager().nowPlayingMovies {(movies, error) in
            if let moives = movies {
                self.movies = movies!
                self.allMovies = movies!
                self.collectionView.reloadData()
            }
        }
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(SuperheroViewController.didPullDown(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshController, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didPullDown(_ refreshController: UIRefreshControl){
        MovieApiManager().nowPlayingMovies {(movies, error) in
            if let moives = movies {
                self.movies = movies!
                self.allMovies = movies!
                self.collectionView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        cell.movie = movie
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let vc =  segue.destination as! movieCellViewViewController
            vc.movie = movie
            
        }
    }
    func searchBar(_ movieSearch: UISearchBar, textDidChange searchText: String){
        let data = allMovies
        
        
        movies = searchText.isEmpty ? data : data.filter{(item:Movie) -> Bool in
            return String(item.title).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
       collectionView.reloadData()
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
