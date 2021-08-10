//
//  ViewController.swift
//  Earth Rotation
//
//  Created by MhMuD SalAh on 10/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewImg: UIView!
    
    @IBOutlet weak var constrainViewContainer: NSLayoutConstraint!
    @IBOutlet weak var imgEarth: UIImageView!
    
    let circularMaskLayer = CAShapeLayer()
    let gradient = CAGradientLayer()
    var imageHeightAfterAspectFit: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageHeightAfterAspectFit = imgEarth.imageSizeAfterAspectFit.height
        constrainViewContainer.constant = imageHeightAfterAspectFit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpMaskAndGradientLayer()
    }
    
    func setUpMaskAndGradientLayer() {
        let circularPath = UIBezierPath(ovalIn: CGRect(x: viewContainer.bounds.width/2 - (imageHeightAfterAspectFit / 2), y: viewContainer.bounds.height/2  - (imageHeightAfterAspectFit / 2), width: imageHeightAfterAspectFit, height: imageHeightAfterAspectFit))
        circularMaskLayer.path = circularPath.cgPath
        viewContainer.layer.mask = circularMaskLayer
        gradient.frame = circularPath.bounds
        gradient.type = .radial
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.5, y: 1.5)
        gradient.colors = [UIColor.clear.cgColor, UIColor(hue: 0.60 , saturation: 1, brightness: 0.90, alpha: 0.5).cgColor]
        gradient.locations = [0, 0.5]
        viewContainer.layer.addSublayer(gradient)
        
        animateEarth()
    }
    
    func animateEarth() {
        UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .curveLinear], animations: { self.viewImg.transform = CGAffineTransform(translationX: 300, y: 0) }, completion: nil)
    }
}

extension UIImageView {

    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat
        guard let image = image else { return frame.size }

        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / (image.size.height)) * newHeight)
            if CGFloat(newWidth) > (frame.size.width) {
                let diff = (frame.size.width) - newWidth
                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                newWidth = frame.size.width
            }
        } else {
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth
            if newHeight > frame.size.height {
                let diff = Float((frame.size.height) - newHeight)
                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                newHeight = frame.size.height
            }
        }
        return .init(width: newWidth, height: newHeight)
    }
}
