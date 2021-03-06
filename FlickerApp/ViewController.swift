import UIKit

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

extension ViewController{
    override func viewDidLoad() {
        self.view.layoutIfNeeded()
        self.myCollectionView.layoutIfNeeded()
        let size = myCollectionView.bounds.width / CGFloat( 3 )
        
        let layout = UICollectionViewFlowLayout ()
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        
        myCollectionView.collectionViewLayout = layout
        myCollectionView.reloadData()
    }
}
