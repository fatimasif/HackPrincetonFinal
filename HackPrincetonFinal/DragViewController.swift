//
//  DragViewController.swift
//  HackPrincetonFinal
//
//  Created by Owen Yang on 4/2/23.
//

import UIKit

class DragViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var cv: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cv = UICollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
