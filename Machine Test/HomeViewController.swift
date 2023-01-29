//
//  HomeViewController.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit
enum sections {
    case category
    case banners
    case products
}

class HomeViewController: UIViewController {

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    var categories = ["Groceries", "Home", "Mobile", "Fashion", "Electronics", "Groceries", "Home", "Mobile", "Fashion", "Electronics"]
    
    var viewModel = HomeViewModel()
    var homeData: DataModel?
    var cateGoryData: HomeData?
    var bannerData: HomeData?
    var productData: HomeData?
    var types = [String]()
    var enumArr = [sections]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.apiToGetData { [weak self] in
            self?.homeData = self?.viewModel.homeData
                   DispatchQueue.main.async {
                       
                       let (typeArr, enumAr) = /*["products","category", "banners"]*/CommonClass.createTypeArr(data: self?.homeData ?? DataModel())
                       self?.types = typeArr
                       self?.enumArr = enumAr
                       CommonClass.initialiseCollectionView(collectionView: (self?.collectionViewCategory)!)
                       self?.collectionViewCategory.dataSource = self
                       self?.collectionViewCategory.delegate = self
                    
                       self?.cateGoryData = self?.homeData?.homeData?.filter {$0.type == "category"}.first
                       self?.bannerData = self?.homeData?.homeData?.filter {$0.type == "banners"}.first
                       self?.productData = self?.homeData?.homeData?.filter {$0.type == "products"}.first
                       self?.collectionViewCategory.collectionViewLayout = (self?.createLayout())!
                       self?.collectionViewCategory.reloadData()
                   }
                   
               }
        
        print("HomeViewController")
        // Do any additional setup after loading the view.
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.enumArr[sectionIndex]
            switch section {
            case .category:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(120)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 10, bottom: 30, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .banners:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(280), heightDimension: .absolute(180)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 30, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
                
            case .products:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(170), heightDimension: .absolute(250)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            }
        }
    }
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.types.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        switch self.enumArr[section]{
        case .category:
            return self.cateGoryData?.values?.count ?? 0
        case .banners:
            return self.bannerData?.values?.count ?? 0
        case .products:
            return self.productData?.values?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.enumArr.count > 0{
            switch self.enumArr[indexPath.section]{
            case .category:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
                    cell.name = self.categories[indexPath.item]
                    cell.categoryData = self.cateGoryData?.values?[indexPath.item]
                    cell.setContents()
                    return cell
                }
            case .banners:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell {
                    cell.layer.borderColor = UIColor.lightGray.cgColor
                    cell.layer.cornerRadius = 5
                    cell.layer.shadowColor = UIColor.black.cgColor
                    cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                    cell.layer.shadowRadius = 5.0
                    cell.layer.shadowOpacity = 0.5
                    cell.layer.masksToBounds = false
                    cell.contentView.layer.cornerRadius = 5
                    cell.bannerData = self.bannerData?.values?[indexPath.item]
                    cell.setContents()
                    return cell
                }
            case .products:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
                    cell.layer.borderColor = UIColor.lightGray.cgColor
                    cell.layer.cornerRadius = 5
                    cell.layer.shadowColor = UIColor.black.cgColor
                    cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                    cell.layer.shadowRadius = 5.0
                    cell.layer.shadowOpacity = 0.5
                    cell.layer.masksToBounds = false
                    cell.contentView.layer.cornerRadius = 5
                    cell.productData = self.productData?.values?[indexPath.item]
                    cell.setContents()
                    return cell
                }
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderReusableView", for: indexPath) as! CollectionViewHeaderReusableView
            let title = self.enumArr[indexPath.section]
            header.title = title
            header.setContents()
            return header
        default:
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
