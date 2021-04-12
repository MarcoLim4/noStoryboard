import Foundation

enum ServiceError: Error {
    case noError
    case decodeFailed
    case downloadFailed
}

class Requests: ObservableObject {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func fetch<T:Decodable>(url: String, dataModel: T, completion: @escaping (T?, ServiceError) -> Void) {
        
        dataTask?.cancel()

        guard let url = URL(string: url) else {
            return
        }

        dataTask = defaultSession.dataTask(with: url) { data, response, error in

            // response to be used only if we need to treat any HTTP Response individually... just an example
            
            defer {
                self.dataTask = nil
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, .downloadFailed)
                }
                
            } else if let data = data {

                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedData, .noError)
                    }

                } catch {
                    debugPrint("Error decoding APOD Data : \(error)")
                    DispatchQueue.main.async {
                        completion(nil, .decodeFailed)
                    }
                }
            }
        }

        dataTask?.resume()
    }

    
}
