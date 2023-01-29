//
//  CollectionViewHeaderReusableView.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit
class CollectionViewHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var cellTitleLbl: UILabel!
    var title: sections?
    func setContents() {
        if title == sections.category{
            self.cellTitleLbl.text = "Category"
        }else if title == sections.banners{
            self.cellTitleLbl.text = "Banners"
        }else if title == sections.products{
            self.cellTitleLbl.text = "Products"
        }
        
    }
}
