//
//  DetailViewController.swift
//  TransAnimation
//
//  Created by share2glory on 2018/11/27.
//  Copyright © 2018年 WH. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    public var imageV = UIImageView()
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        imageV.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        imageV.center = self.view.center
        imageV.image = UIImage.init(named: "erha")
        self.view.addSubview(imageV)
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
        
        let edgePan = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgePanGesture(edgePan:)))
        edgePan.edges = .left
        self.view.addGestureRecognizer(edgePan)
    }
    
    @objc func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {
        
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
        
        if edgePan.state == .began{
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        }else if edgePan.state == .changed{
            self.percentDrivenTransition?.update(progress)
        }else if edgePan.state == .cancelled || edgePan.state == .ended{
            if progress > 0.5 {
                self.percentDrivenTransition?.finish()
            }else {
                self.percentDrivenTransition?.cancel()
            }
            self.percentDrivenTransition = nil
        }
        
    }

}

extension DetailViewController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop{
            return PopAnimation()
        }else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is PopAnimation{
            return self.percentDrivenTransition
        }else {
            return nil
        }
    }
}
