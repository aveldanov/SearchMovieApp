//
//  ViewController.swift
//  SearchMovieApp
//
//  Created by Veldanov, Anton on 4/25/21.
//

import UIKit

//UI
// network request
// tap a cell

// custom cell to show movie


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var movies = [Movie]()
    let url = URL(string: "https://www.omdbapi.com/?apikey=b20345e3&s=speed&type=movie")!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
    }
    
    //Field
    //press Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    func searchMovies(){
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        movies.removeAll() // refresh search results
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else{
                return
                
            }
            
            
            //Convert
            var result: MovieResult?
            do{
                result = try JSONDecoder().decode(MovieResult.self, from: data)
                
                
            }catch{
                print("error")
                
            }
            
            guard let finalResult = result else{
                return
            }
            
            //update movie array
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            print(self.movies)
            
            // refresh table
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
            
        }.resume()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // moview details
        
        
    }

}



struct MovieResult: Codable{
    public private(set) var Search: [Movie]

    
}

struct Movie: Codable{
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey{
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}


