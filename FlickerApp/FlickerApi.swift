import Foundation
import UIKit

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
    
    static func convertJsonToPhotos (data: Data) -> [Photo]?
    {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: [] ) else {return nil}
        
        guard let results = json as? [String : Any] else {return nil}
        
        guard let photos = results["photos"] as? [String : Any],
              let photoDic = photos["photo"] as? [[String : Any]] else {return nil}
        
//            let string = try? JSONSerialization.data(withJSONObject: photoDic, options: .prettyPrinted)
//            let founPghotos : [Photo] = try! JSONDecoder().decode([Photo].self, from: string!)
//this two lines work as for loop that under this comment
        
        var foundPhotos : [Photo] = []
        for any in photoDic
        {
            let string = try? JSONSerialization.data(withJSONObject: any, options: .prettyPrinted)
            
            let photo = try? JSONDecoder().decode(Photo.self, from: string!)
            
            foundPhotos.append(photo!)
            
        }
            
        return foundPhotos
    }
    
    static func getSingleImage (for photo: Photo, completion: @escaping (UIImage) -> Void)
    {
        let urlStr = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_m.jpg"
        
        let url = URL(string: urlStr)!
        
        DispatchQueue.global(qos: .background).async
        {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url))
            { data, res, err in
                if data != nil
                {
                    if let img = UIImage (data: data!)
                    {
                        completion(img)
                    }
                }
            }
            task.resume()
        }
    }
}
