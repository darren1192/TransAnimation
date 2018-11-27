//
//  PushAnimation.swift
//  TransAnimation
//
//  Created by share2glory on 2018/11/27.
//  Copyright © 2018年 WH. All rights reserved.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1.获取动画的源控制器和目标控制器
        let toVC = transitionContext.viewController(forKey: .to) as! DetailViewController
        let fromVC = transitionContext.viewController(forKey: .from) as! ViewController
        let containerView = transitionContext.containerView
        
        //2.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
        let selectCell = fromVC.selectedCell!
        let snapshotView = selectCell.imageV.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert(selectCell.imageV.frame, from: selectCell)
        let selectImageV = selectCell.imageV
        selectImageV.isHidden = true
        
        //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        
        //4.都添加到 container 中。注意顺序不能错了
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView!)
        
        //5.执行动画
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            snapshotView?.frame = toVC.imageV.frame
            toVC.view.alpha = 1
        }) { (_) in
            selectCell.imageV.isHidden = false
            snapshotView?.removeFromSuperview()
            //一定要记得动画完成后执行此方法，让系统管理 navigation
            transitionContext.completeTransition(true)
        }
        
    }
    
}
