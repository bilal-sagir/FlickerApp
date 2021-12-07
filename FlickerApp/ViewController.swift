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
    
    @IBAction func doSearch()
    {
        let searchTerm = searchTextField.text!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

}

