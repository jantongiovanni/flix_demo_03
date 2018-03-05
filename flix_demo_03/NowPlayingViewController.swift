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
        activityIndicator.stopAnimating()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        
        fetchMovies()
    }
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {(data, response, error) in
            //this will run when the network request returns
            if let error = error{
                print(error.localizedDescription)}
            else if let data = data{
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                //print(dataDictionary)
//                //casting as swift dictionary
//                let movies = dataDictionary["results"] as! [[String: Any]]
//                self.movies = movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = []
                for dictionary in movieDictionaries {
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
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
        
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            //gets the cell
            let movie = movies[indexPath.row]
            //gets the movie
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
