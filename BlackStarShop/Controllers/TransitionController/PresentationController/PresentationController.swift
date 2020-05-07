//
//  PresentationController.swift
//  Transition
//
//  Created by Maxim Alekseev on 06.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    override var shouldPresentInFullscreen: Bool {
           return false
       }
       
       override var frameOfPresentedViewInContainerView: CGRect {
           let bounds = containerView!.bounds
           let halfHeight = bounds.height / 2
           return CGRect(x: 0,
                         y: halfHeight,
                         width: bounds.width,
                         height: halfHeight)
       }
       
       override func presentationTransitionWillBegin() {
           super.presentationTransitionWillBegin()
           
           containerView?.addSubview(presentedView!)
           
       }
       
       override func containerViewDidLayoutSubviews() {
           super.containerViewDidLayoutSubviews()
           
           presentedView?.frame = frameOfPresentedViewInContainerView
       }
       
       var driver: TransitionDriver!
       override func presentationTransitionDidEnd(_ completed: Bool) {
           super.presentationTransitionDidEnd(completed)
           
           if completed {
               driver.direction = .dismiss
           }
       }

}
