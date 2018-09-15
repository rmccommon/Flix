//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Sierra Klix on 9/10/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var loadingCircle: UIActivityIndicatorView!
    
    var movies: [[String: Any]] = []
    var refreshController:UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(NowPlayingViewController.didPullDown(_:)), for: .valueChanged)
        tableView.insertSubview(refreshController, at: 0)
        
        
        fetchMovies()
        
        
    }
    @objc func didPullDown(_ refreshController: UIRefreshControl){
        fetchMovies()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = self.movies[indexPath.row]
        let title  = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.title.text = title
        cell.overview.text = overview
        let posterPath = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let posterURL = URL(string: baseURL + posterPath)!
        cell.movieImage.af_setImage(withURL: posterURL)
        
        
        
        return cell
    }
    func fetchMovies(){
        loadingCircle.startAnimating()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){
            (data,response,error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let data=data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
        task.resume()
        loadingCircle.stopAnimating()
        
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
