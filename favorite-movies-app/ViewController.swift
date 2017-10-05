//
//  ViewController.swift
//  favorite-movies-app
//
//  Created by Leon on 10/1/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        let idx:Int = indexPath.row
        movieCell.movieTitle?.text = favoriteMovies[idx].title;
        movieCell.movieYear?.text = favoriteMovies[idx].year;
        displayMovieImage(idx, movieCell:movieCell)
        
        return movieCell;
    }
    
    func displayMovieImage(_ row: Int, movieCell: CustomTableViewCell){
        let url: String = (URL(string: favoriteMovies[row].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler:{
            (data, response, error) -> Void in
            if error != nil{
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute:{
                let image = UIImage(data: data!)
                movieCell.movieImageView?.image = image
            })
        }).resume()
        
    }
    
    var favoriteMovies:[Movie] = []
    
    @IBOutlet var mainTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "searchMovieSegue"{
            let controller = segue.destination as! SearchViewController
            controller.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
        if favoriteMovies.count == 0 {
            favoriteMovies.append(Movie(id:"tt0372784", title:"Batman Begins", year: "2005", imageUrl:"https://cameronmoviesandtv.files.wordpress.com/2016/04/batman-begins-poster.jpg"))
        }
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

