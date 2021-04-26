//
//  MovieTableViewCell.swift
//  SearchMovieApp
//
//  Created by Veldanov, Anton on 4/25/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitleLabel:UILabel!
    @IBOutlet weak var movieYearLabel:UILabel!
    @IBOutlet weak var moviePosterImage:UIImageView!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "MovieTableViewCell"
    
    // nib returns cell -> MovieTableViewCell
    static func nib() -> UINib{
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
        
    }
    
    func configure(with model: Movie){
        movieTitleLabel.text = model.Title
        movieYearLabel.text = model.Year
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!){
            self.moviePosterImage.image = UIImage(data: data)

        }
        
        
    }
}
