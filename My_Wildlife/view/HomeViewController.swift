import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories : [Koleksiyonlar] = [
        (Koleksiyonlar(name: "Memeliler", cover_image_url: UIImage(named: "deer"), description: "Deneme", created_at: "12.12.2332")),
        (Koleksiyonlar(name: "Kuşlar", cover_image_url: UIImage(named: "add"), description: "Deneme", created_at: "12.12.2332"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated:true)

        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCellCollectionViewCell
        let category = categories[indexPath.row]
        cell.categoryImage.image = category.cover_image_url
        cell.categoryName.text = category.name
        cell.backgroundColor = .systemGray5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
        let widthPerItem = collectionView.frame.width / 2 - gridLayout.minimumInteritemSpacing*2
            return CGSize(width:widthPerItem, height:300)
    }//satıra kaç tane cell geleceğini belirten fonksiyon burada formül kullandık
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    

}
