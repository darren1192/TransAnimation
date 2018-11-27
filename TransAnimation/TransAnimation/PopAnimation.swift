//
//  PopAnimation.swift
//  TransAnimation
//
//  Created by share2glory on 2018/11/27.
//  Copyright © 2018年 WH. All rights reserved.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to) as! ViewController
        let fromVC = transitionContext.viewController(forKey: .from) as! DetailViewController
        let containerView = transitionContext.containerView
        
        let snapshotView = fromVC.imageV.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert(fromVC.imageV.frame, from: fromVC.view)
        fromVC.imageV.isHidden = true
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)

        let selectCell = toVC.selectedCell!
        selectCell.imageV.isHidden = true
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapshotView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            snapshotView?.frame = containerView.convert(selectCell.imageV.frame, from: selectCell)
            fromVC.view.alpha = 0
        }) { (_) in
            selectCell.imageV.isHidden = false
            snapshotView?.removeFromSuperview()
            fromVC.imageV.isHidden = false
            
            transitionContext.completeTransition(true)
        }
        
    }
}
