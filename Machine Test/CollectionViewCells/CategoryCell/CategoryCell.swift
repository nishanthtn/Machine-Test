//
//  CategoryCell.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    var name: String?
    var categoryData: ValueData?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContents() {
        self.showImage()
        let attributedText = NSMutableAttributedString(string: self.categoryData?.name ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor : UIColor.black])
        self.lblName.attributedText = attributedText
    }
    func showImage() {
        let url = URL(string: self.categoryData?.image_url ?? "")!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.imgView.image = image
        }
        self.imgView.contentMode = UIView.ContentMode.scaleAspectFill
        self.imgView.clipsToBounds = true
        self.imgView.layer.cornerRadius = self.imgView.frame.width/2
    }

}
