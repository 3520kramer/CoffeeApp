//
//  AnnotationView.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 16/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import MapKit
/*
 The code below is necessary to track the touch click on the custom callout views since you will no longer use the default annotation view callout, but instead a custom UIView
 */

class AnnotationView: MKAnnotationView{
    
override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubviewToFront(self)
        }
        return hitView
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside: Bool = rect.contains(point)
        if(!isInside)
        {
            for view in self.subviews
            {
                isInside = view.frame.contains(point)
                if isInside
                {
                    break
                }
            }
        }
        return isInside
    }
}
