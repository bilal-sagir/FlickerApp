import Foundation

let apiKey = "b61ae7a29725bf8c55e94e28c5a8e3b9"

class FlickerApi
{
    static func searchFlicker(for keyword: String, complition: @escaping (_ data: Data?) -> Void)
    {
        let urlStr = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(keyword)&format=json&nojsoncallback=1"
        
        let url = URL(string: urlStr)
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: req) { data, response, err in
            guard data != nil else {
                complition(nil)
                return
            }
            complition(data)
        }
        task.resume()
        
    }
}
