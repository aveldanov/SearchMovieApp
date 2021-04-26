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
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            
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


struct Movie{
    
    
    
}


