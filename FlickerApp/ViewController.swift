import UIKit

/*
 api_key : b61ae7a29725bf8c55e94e28c5a8e3b9
 
 url_sample : https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg

 https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\()&text=\()&format=json&nojsoncallback=1
 
 */




class ViewController: UIViewController
{
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var photos : [Photo] = []
    
    @IBAction func doSearch()
    {
        let searchTerm = searchTextField.text!
        
        FlickerApi.searchFlicker(for: searchTerm)
        { data in
            if let mData = data
            {
                self.photos = FlickerApi.convertJsonToPhotos(data: mData)!
                
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MyCell
        
        cell.photo = photos[indexPath.row]
        
        FlickerApi.getSingleImage(for: cell.photo)
        { img in
            DispatchQueue.main.async
            {
                cell.imgView.image = img
            }
        }
        return cell
    }
    

    

}
