//
//  CommonClass.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit

class CommonClass: NSObject {

    class func initialiseCollectionView(collectionView: UICollectionView){
        let cellNib = UINib(nibName: "CategoryCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCell")
        let cellNib1 = UINib(nibName: "BannerCell", bundle: nil)
        collectionView.register(cellNib1, forCellWithReuseIdentifier: "BannerCell")
        let cellNib2 = UINib(nibName: "ProductCell", bundle: nil)
        collectionView.register(cellNib2, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(UINib(nibName: "CollectionViewHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"CollectionViewHeaderReusableView")
        

    }
    class func createTypeArr(data: DataModel)->([String], [sections] ){
        
        let typeArr = data.homeData?.compactMap { $0.type}
        let enumArr = self.createEnumArr(typeArr: typeArr ?? [])
        return (typeArr ?? [], enumArr)
    }
    class func createEnumArr(typeArr: [String])-> [sections]{
        var enumArr = [sections]()
        for i in 0..<typeArr.count{
            if typeArr[i] == "category" {
                enumArr.append(sections.category)
            }
            if typeArr[i] == "banners" {
                enumArr.append(sections.banners)
            }
            if typeArr[i] == "products" {
                enumArr.append(sections.products)
            }
        }
        return enumArr
    }
}

