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
    
    var movies: [[String:Any]] = []
    var allMovies: [[String:Any]] = []
    
    var refreshController:UIRefreshControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        movieSearch.delegate = self
        fetchMovies()
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(SuperheroViewController.didPullDown(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshController, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didPullDown(_ refreshController: UIRefreshControl){
        fetchMovies()
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
        if let posterPathString = movie["poster_path"] as? String{
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseUrlString + posterPathString)!
            cell.posterImage.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    func fetchMovies(){
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){
            (data,response,error) in
            if error != nil {
                let errorController = UIAlertController(title: "No Internet",message: "The Internet connection appears to be offline", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "try again", style: .default){(action) in
                    self.fetchMovies()
                    
                }
                errorController.addAction(tryAgainAction)
                
                self.present(errorController, animated: true)
            }else if let data=data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = movies
                self.allMovies = movies
                self.collectionView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
        task.resume()
        //loadingCircle.stopAnimating()
        
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
        
        
        movies = searchText.isEmpty ? data : data.filter{(item:[String: Any]) -> Bool in
            return String(item["title"] as! String).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
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
