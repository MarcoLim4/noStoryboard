import UIKit
import Foundation

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var safeArea = UILayoutGuide()

    var top100Albums: Feed?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Top 100 Albums"
        safeArea = view.layoutMarginsGuide
        
        tableView.isHidden = true
        
        designTableView()
        fetchData()
        
    }

    @objc
    func fetchData() {
        
        Top100Model.fetchAlbums { result in

            switch result {
            case .success(let albumsInfo):
                self.top100Albums = albumsInfo
                print(albumsInfo.feed.title)
                self.tableView.isHidden = false
                self.tableView.reloadData()
            case.failure(_ ):
                self.showErrorScreen()
            }
            
        }

    }
    
    func designTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(AlbumCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    private func showErrorScreen() {
        
        view.backgroundColor = .systemBackground
        
        let errorLabel = UIObjects.label(fontWeigth: .bold, fontSize: 18)
        view.addSubview(errorLabel)
        
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.text = "Sorry, error loading Top 100 Records!"
        
        
        let buttonRefresh: UIButton = {
           
            let button: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 70))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .blue
            button.setTitle("Reload Data", for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action:#selector(self.fetchData), for: .touchUpInside)
            return button
            
        }()
        
        self.view.addSubview(buttonRefresh)
        
        buttonRefresh.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonRefresh.widthAnchor.constraint(equalToConstant: 250).isActive = true
        buttonRefresh.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20).isActive = true
        

    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top100Albums?.feed.results?.count ?? 0
   }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumCell

        if let theDetails = top100Albums?.feed.results?[indexPath.row] {
            
            cell.albumNameLabel.text = theDetails.collectionName
            cell.albumArtistLabel.text = theDetails.artistName
            cell.albumThumbnail.image = UIImage(named: "album-thumbnail") // Instead of adding a spinner
            
            ImageHelper.loadImageUsingCache(withUrl: theDetails.artworkUrl100) { image in

                if image != nil {
                    cell.albumThumbnail.image = image
                }
                
            }
            
        }
        
       return cell
       
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let albumResults = top100Albums?.feed.results?[indexPath.row] {
            let detailsViewController = AlbumDetailsViewController()
            detailsViewController.theDetails = albumResults
            
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
        
    }
    
}
