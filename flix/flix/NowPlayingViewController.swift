//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Sierra Klix on 9/10/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var movieSearch: UISearchBar!
    
    @IBOutlet weak var loadingCircle: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    var allMovies: [Movie] = []
    var refreshController:UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        loadingCircle.startAnimating()
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        movieSearch.delegate = self
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(NowPlayingViewController.didPullDown(_:)), for: .valueChanged)
        tableView.insertSubview(refreshController, at: 0)
        tableView.rowHeight = 250
        MovieApiManager().nowPlayingMovies {(movies, error) in
            if let moives = movies {
                self.movies = movies!
                self.allMovies = movies!
                self.tableView.reloadData()
                self.loadingCircle.stopAnimating()
            }
        }
        

    }
    @objc func didPullDown(_ refreshController: UIRefreshControl){
        MovieApiManager().nowPlayingMovies {(movies, error) in
            if let moives = movies {
                self.movies = movies!
                self.allMovies = movies!
                self.tableView.reloadData()
                self.loadingCircle.stopAnimating()
            }
        }
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
        
        cell.movie = movie
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let vc =  segue.destination as! movieCellViewViewController
            vc.movie = movie
            
        }
    }
    func searchBar(_ movieSearch: UISearchBar, textDidChange searchText: String){
        let data = allMovies
        
        
        movies = searchText.isEmpty ? data : data.filter{(item:Movie) -> Bool in
            return String(item.title ).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
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
