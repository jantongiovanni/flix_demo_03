//
//  NowPlayingViewController.swift
//  flix_demo_03
//
//  Created by Joe Antongiovanni on 2/4/18.
//  Copyright © 2018 Joseph Antongiovanni. All rights reserved.
//

import UIKit
import AlamofireImage



class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        tableView.dataSource = self
        fetchMovies()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        
        fetchMovies()
    }
    
    func fetchMovies(){
        
        MovieApiManager().popularMovies{ (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()

            }
            self.activityIndicator.stopAnimating()

        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get the index path of the cell that was selected
//        let detailViewController = segue.destination as! DetailViewController
//
//        let cell = sender as! MovieCell
//        if let indexPath = tableView.indexPath(for: cell){
//            //gets the cell
//           // let movie = movies[indexPath.row]
//            //gets the movie
//            detailViewController.movie = movies[indexPath.row]
//        }
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
