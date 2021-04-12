import Foundation

enum DataError: Error {
    case noData
}

struct Top100Model {
    
    static func fetchAlbums(completion: @escaping (Result<Feed, DataError>) -> Void) {
        
        // We could add this URL into a Plist file but for simplicity, here it is...
        let albumsURL = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-songs/all/100/explicit.json"
        
        Requests().fetch(url: albumsURL, dataModel: Feed()) { dataResult, error in
            
            if error == .noError {
                
                if let albumsResult = dataResult {
                    completion(.success(albumsResult))
                } else {
                    completion(.failure(.noData))
                }
            } else {
                print("Error getting Top 100 Albums : \(error)")
                completion(.failure(.noData))
            }
            
            
        }
    }
    
}


/*
 
    The data model have a lot of data that we are not using on this exercise,
    so I have decided to keep only the data we are using!
 
    I've saved a copy of the JSON file here for reference only!
 
 */


struct Feed: Decodable {
    
    let feed: TopAlbums
    
    init() {
        self.feed = TopAlbums()
    }
}

struct TopAlbums: Decodable {
    
    let title: String
    let results: [AlbumResults]?

    init() {
        self.title = ""
        self.results = [AlbumResults]()
    }
    
}

struct AlbumResults: Decodable {
    
    let artistName: String
    let releaseDate: String?
    let collectionName: String
    let copyright: String
    let artworkUrl100: String
    let genres: [Genres]?
    let url: String
    
}

struct Genres: Decodable {
    let genreid: String?
    let name: String?
    let url: String?
}
