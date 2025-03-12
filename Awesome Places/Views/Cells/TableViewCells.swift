//
//  Untitled.swift
//  Awesome Places
//
//  Created by Gaurav Patel on 11/03/25.
//

import UIKit


protocol MainCategoryCellDelegate: AnyObject {
    func didSelectCategory(_ category: Category)
}

// Helper function for setting up the UICollectionView
extension UITableViewCell {
    func setupCollectionView(_ collectionView: UICollectionView, delegate: UICollectionViewDelegate & UICollectionViewDataSource , direction : UICollectionView.ScrollDirection) {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = direction
        }
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        print("Delegate and DataSource Set")
    }
}

//MARK: - Main Screen.
class MainHeaderCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


// MARK: Categoaries
class MainCategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryCollectionViewHeightConstraint: NSLayoutConstraint!
    
    private var categories: [Category] = []
    weak var delegate: MainCategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func configure(with categories: [Category]) {
        self.categories = categories
        categoryCollectionView.reloadData()
        updateCollectionViewHeight()
    }
    
    private func setupCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func updateCollectionViewHeight() {
        DispatchQueue.main.async {
            self.categoryCollectionViewHeightConstraint.constant = self.categoryCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.layoutIfNeeded()
        }
    }
}



// MARK: - UICollectionViewDataSource & Delegate
extension MainCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.configure(with: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2 - 10
        return CGSize(width: size, height: size-20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        delegate?.didSelectCategory(selectedCategory)
    }
}

// MARK: Footer
class MainFooterCell: UITableViewCell {
    
    @IBOutlet weak var btnBookARide: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnBookARidePressed(_ sender: UIButton) {
        print(#function)
    }
}


//MARK: - DetailsVC Cells
class DetailsTableCell: UITableViewCell {
    
    @IBOutlet weak var destinationNameLbl: UILabel!
    @IBOutlet weak var destinationImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
