import UIKit

class AlbumDetailsViewController: UIViewController {

    var safeArea = UILayoutGuide()
    var theDetails: AlbumResults?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        
        viewDesign()

    }
    
    
    private func viewDesign() {
        
// MARK: Image
        
        let albumCoverImage = UIObjects.image(cornerRadius: 10)
        albumCoverImage.image = UIImage(named: "album-thumbnail")
        albumCoverImage.layer.borderWidth = 1.0
        albumCoverImage.layer.borderColor = UIColor.secondaryLabel.cgColor

        ImageHelper.loadImageUsingCache(withUrl: theDetails?.artworkUrl100 ?? "") { image in

            if image != nil {
                albumCoverImage.image = image
            }

        }
        
        view.addSubview(albumCoverImage)

        albumCoverImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        albumCoverImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        albumCoverImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        albumCoverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
// MARK: Album Name
        
        let albumNameLabel = UIObjects.label(fontWeigth: .bold, fontSize: 20, fontColor: .blue)
        view.addSubview(albumNameLabel)
        
        albumNameLabel.numberOfLines = 0
        albumNameLabel.textAlignment = .center
        albumNameLabel.topAnchor.constraint(equalTo: albumCoverImage.bottomAnchor, constant: 10).isActive = true
        albumNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        albumNameLabel.text = theDetails?.collectionName ?? ""
        
// MARK: Artist
        
        let artistNameLabel = UIObjects.label(fontWeigth: .bold, fontSize: 15)
        view.addSubview(artistNameLabel)
        
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 5).isActive = true
        artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistNameLabel.text = theDetails?.artistName ?? ""


// MARK: Album Genre
        
        let albumGenreLabel = UIObjects.label(fontWeigth: .normal, fontSize: 15)
        view.addSubview(albumGenreLabel)
        
        albumGenreLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 5).isActive = true
        albumGenreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumGenreLabel.text = theDetails?.genres?.first?.name ?? ""

        
// MARK: Album Release Date
        
        let albumReleaseDate = UIObjects.label(fontWeigth: .normal, fontSize: 15)
        view.addSubview(albumReleaseDate)
        
        albumReleaseDate.topAnchor.constraint(equalTo: albumGenreLabel.bottomAnchor, constant: 5).isActive = true
        albumReleaseDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let releaseDate = theDetails?.releaseDate  {
            albumReleaseDate.text = "Released on : \(DateHelper.transformDate(dateString: releaseDate))"
        }
        
// MARK: Album Copyright
        
        let albumCopyright = UIObjects.label(fontWeigth: .italic, fontSize: 10)
        view.addSubview(albumCopyright)
        
        albumCopyright.numberOfLines = 0
        albumCopyright.textAlignment = .center
        albumCopyright.topAnchor.constraint(equalTo: albumReleaseDate.bottomAnchor, constant: 5).isActive = true
        albumCopyright.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        albumCopyright.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumCopyright.text = theDetails?.copyright ?? ""


// MARK: Button
        
        let buttonItunes: UIButton = {
           
            let button: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 60))
            button.translatesAutoresizingMaskIntoConstraints = false
            
            
            button.backgroundColor = .blue
            button.setTitle("View on iTunes", for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)

            return button
            
        }()
        
        self.view.addSubview(buttonItunes)
        
        buttonItunes.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonItunes.widthAnchor.constraint(equalToConstant: 200).isActive = true
        // -30 = -20 required + -10 for safe area
        buttonItunes.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
    }
    
    
    @objc func buttonClicked() {
        
        let iTunesView = iTunesViewController()
        iTunesView.url = theDetails?.url
        
        present(iTunesView, animated: true, completion: nil)
        
    }

    
}
