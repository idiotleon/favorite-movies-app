//
//  SearchViewController.swift
//  favorite-movies-app
//
//  Created by Leon on 10/1/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    
    weak var delegate: ViewController!
    
    @IBAction func addFav(sender: UIButton){
        print("Item #\(sender.tag) was selected as a favorite")
        self.delegate.favoriteMovies.append(searchResults[sender.tag])
    }
    
    var searchResults: [Movie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Result"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        let idx:Int = indexPath.row
        movieCell.favButton.tag = idx
        
        // title
        let title = searchResults[idx].title
        print("title, tableView(,): " + title)
        movieCell.movieTitle?.text = title
        // year
        movieCell.movieYear?.text = searchResults[idx].year
        // image
        displayMovieImage(idx, movieCell: movieCell)
        
        return movieCell
    }
    
    func displayMovieImage(_ idx: Int, movieCell: CustomTableViewCell){
        let url: String = (URL(string: searchResults[idx].imageUrl)?.absoluteString)!
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
    
    @IBAction func search(sender: UIButton){
        print("Searching...")
        var searchTerm = searchText.text!
        if searchTerm.characters.count > 0 {
            retrieveMoviesByTerm(searchTerm: searchTerm)
        }
    }
    
    func retrieveMoviesByTerm(searchTerm: String){
        let urlPre = "https://api.themoviedb.org/3/movie/76341"
        let api_key = "?api_key="
        let url = urlPre + api_key
        
        HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoMovies)
    }
    
    func parseDataIntoMovies(data: Data?) -> Void{
        print("parseDataIntoMovies() got called")
        if let data = data{
            let object = JSONParser.parse(data: data)
            print("JSONParser.parse() got called, parseDataIntoMovies()")
            if let object = object{
                self.searchResults = MovieDataProcessor.mapJsonToMovies(object: object, moviesKey: "Search")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
