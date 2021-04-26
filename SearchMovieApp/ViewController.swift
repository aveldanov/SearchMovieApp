//
//  ViewController.swift
//  SearchMovieApp
//
//  Created by Veldanov, Anton on 4/25/21.
//

import UIKit
import SafariServices

//UI
// network request
// tap a cell

// custom cell to show movie


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
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
        // replace SPACE with %20
        let query = text.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://www.omdbapi.com/?apikey=b20345e3&s=\(query)&type=movie")!
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // moview details
        
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
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


