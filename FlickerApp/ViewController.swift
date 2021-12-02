import UIKit

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

