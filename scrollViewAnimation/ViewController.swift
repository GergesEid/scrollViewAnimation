//
//  ViewController.swift
//  scrollViewAnimation
//
//  Created by Gerges on 10/21/20.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var topConstraintOfViewOfTop: NSLayoutConstraint!
    @IBOutlet weak var numbersCV: UICollectionView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    let numberArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",]

    var cellOrder = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.delegate = self
        
        numbersCV.delegate = self
        numbersCV.dataSource = self
        numbersCV.reloadData()
        
        // Do any additional setup after loading the view.
    }

    
    lazy var lastContentOffset: CGFloat = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if lastContentOffset > numbersCV.contentOffset.y && lastContentOffset < numbersCV.contentSize.height - numbersCV.frame.height {
            // move up
            print("move up")
            if topConstraintOfViewOfTop.constant < 320 && cellOrder < 6 {
                self.topConstraintOfViewOfTop.constant += 5
            }
        } else if lastContentOffset < numbersCV.contentOffset.y && numbersCV.contentOffset.y > 0 {
            // move down
            print("move down")
            if topConstraintOfViewOfTop.constant > 5 {
                self.topConstraintOfViewOfTop.constant -= 5
            }
        }
        
        // update the new position acquired
        lastContentOffset = numbersCV.contentOffset.y
    }
    

}

extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : NumbersCollectionViewCell = numbersCV.dequeueReusableCell(withReuseIdentifier: "NumbersCollectionViewCell", for: indexPath) as! NumbersCollectionViewCell
        cell.numberLbl.text = numberArray[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = CGSize(width: (self.numbersCV.frame.size.width), height: 325)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("indexPath.row: \(indexPath.row)")
        cellOrder = indexPath.row
    }


}
