//
//  ProductCell.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var offerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgViewTruck: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    var productData: ValueData?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.offerViewWidth.constant = self.contentView.frame.size.width/2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            self.setLeftTriangle()
            
        })
        self.offerView.backgroundColor = UIColor.red
    }
    @IBAction func btnActionFav(_ sender: Any) {
//        if self.btnFavourite.currentImage == (UIImage(named: "favourite")){}
        if self.btnFavourite.imageView?.image == UIImage(named: "favourite"){
            self.btnFavourite.setImage(UIImage(named: "favourite-filled"), for: .normal)
//            self.btnFavourite.imageView?.image = UIImage(named: "favourite-filled")
        }else{
            self.btnFavourite.setImage(UIImage(named: "favourite"), for: .normal)
        }
    }
    
    @IBAction func btnActionAdd(_ sender: UIButton) {
    }
    func setContents() {
        if self.productData?.actual_price == self.productData?.offer_price {
            let attributedText = NSMutableAttributedString(string: self.productData?.actual_price ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11),NSAttributedString.Key.foregroundColor : UIColor.black])
            self.lblPrice.attributedText = attributedText
        }else{
        let attributedText = NSMutableAttributedString(string: self.productData?.actual_price ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11),NSAttributedString.Key.foregroundColor : UIColor.lightGray,  NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)])
        attributedText.append(NSAttributedString(string: "\n\(self.productData?.offer_price ?? "")", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.black]))
        self.lblPrice.attributedText = attributedText
        }
        let attributedText1 = NSMutableAttributedString(string: self.productData?.name ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : UIColor.black])
        self.lblName.attributedText = attributedText1
        if self.productData?.offer != nil && self.productData?.offer != 0{
            self.offerView.isHidden = false
        let attributedText2 = NSMutableAttributedString(string: "\(Int(self.productData?.offer ?? 0))% OFF", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : UIColor.white])
        self.offerLabel.attributedText = attributedText2
        }else{
            self.offerView.isHidden = true
        }
        self.btnAdd.layer.cornerRadius = 5
       
        if self.productData?.is_express == true{
            self.imgViewTruck.isHidden = false
        }else{
            self.imgViewTruck.isHidden = true
        }
        
        self.showImage()
    }
    func showImage() {
        let url = URL(string: self.productData?.image ?? "")!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.imgView.image = image
        }
        self.imgView.contentMode = UIView.ContentMode.scaleAspectFill
        self.imgView.clipsToBounds = true
    }
    
    
    func setLeftTriangle(){
        let heightWidth = offerView.frame.size.height//24//offerView.frame.size.width
        let width = offerView.frame.size.width
        print(heightWidth, width)
        let val = Int("\(width)") ?? 0
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x:width - (heightWidth/2), y: heightWidth/2))
        path.addLine(to: CGPoint(x:width, y:heightWidth))
        path.addLine(to: CGPoint(x:width, y:0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.white.cgColor
        
        offerView.layer.insertSublayer(shape, at: 0)
    }
}
