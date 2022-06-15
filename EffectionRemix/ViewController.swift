//
//  ViewController.swift
//  EffectionRemix
//
//  Created by Thân Văn Thanh on 4/26/21.
//

import UIKit

class ViewController: UIViewController {
    var imageViews : [UIImageView] = []
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        creatEffectionRemix(name: "thanos400", count: 100)
        
        print("\(imageViews.count)")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) { [self] in
            animation()
        }
    }

    func animation(){
        for imageview in imageViews {
            UIView.animate(withDuration: 5) {
                imageview.transform = CGAffineTransform(translationX: CGFloat.random(in: -200...200), y: CGFloat.random(in: -200...200))
            } completion: { (_) in
                UIView.animate(withDuration: 5) {
                    imageview.transform = .identity
                } completion: { [self] (_) in
                    count += 1
                    if count >= imageViews.count{
                        count = 0
                        animation()
                    }
                }
            }
        }
    }
    
    func creatEffectionRemix(name : String , count : Int) {
        let Image = UIImage(named: name)
        let imageConvert = Image?.cgImage
        let width = imageConvert?.width
        let height = imageConvert?.height
        let x = self.view.frame.width/2 - CGFloat(width!/2) //Center x
        let y = self.view.frame.height/2 - CGFloat(height!/2) // center y
        
        for column in stride(from: 0, to: height!, by: height!/count) {
            for row in stride(from: 0, to: width!, by: width!/count){
                let image = UIImage(named: name)?.cgImage
                let cropImage = image?.cropping(to: CGRect(x: row, y: column, width: width!/count, height: height!/count))
                let imageView = UIImageView(image: UIImage(cgImage: cropImage! ))
                imageView.frame.origin = CGPoint(x: CGFloat(row) + x, y: CGFloat(column) + y)
                imageViews.append(imageView) //imageViews sẽ chứa các imageView
                view.addSubview(imageView)
            }
        }
    }
}

