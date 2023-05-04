//
//  ViewController.swift
//  ARFoodMenu
//
//  Created by Steve Sopoci on 1/5/21.
//

import UIKit
import QuickLook

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QLPreviewControllerDelegate, QLPreviewControllerDataSource{
    
    @IBOutlet var collectionView: UICollectionView!
    
    let models = ["Pizza", "Burger", "Hot Dog", "Fries"]
    
    var thumbnails = [UIImage]()
    var modelsIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for model in models {
            if let thumbnail = UIImage(named: "\(model).jpg") {
                thumbnails.append(thumbnail)
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.thumbnailImage.image = thumbnails[indexPath.section]
        cell.thumbnailLabel.text = models[indexPath.section]
        cell.arGlyph.image = UIImage(named: "ARGlyph")
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        modelsIndex = indexPath.section
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        
        present(previewController, animated: false)
    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        guard let url = Bundle.main.url(forResource: models[modelsIndex], withExtension: "usdz") else { fatalError() }
        
        return url as QLPreviewItem
    }
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var thumbnailLabel: UILabel!
    @IBOutlet var arGlyph: UIImageView!
}

