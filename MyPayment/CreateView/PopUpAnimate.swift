//
//  PopUpAnimate.swift
//  MyPayment
//
//  Created by Антон Дубино on 13.12.2021.
//

import Foundation
import UIKit

protocol AnimatePopUp {
    func animateIn(view: UIView, popUp: UIView)
    func animateInMini(view: UIView, popUp: UIView)
    func animateInSettings(view: UIView, popUp: UIView)
    func animateOut(popUp: UIView)
}

class PopUp: AnimatePopUp {
    func animateIn(view: UIView, popUp: UIView) {
        view.addSubview(popUp)
        popUp.translatesAutoresizingMaskIntoConstraints = false
        popUp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 95/100).isActive = true
        popUp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 70/100).isActive = true
        popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUp.layer.cornerRadius = 10
        popUp.center = view.center
        popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUp.alpha = 0
        UIView.animate(withDuration: 0.1) {
            popUp.alpha = 1
            popUp.transform = CGAffineTransform.identity
        }
    }
    
    func animateInMini(view: UIView, popUp: UIView) {
        view.addSubview(popUp)
        popUp.translatesAutoresizingMaskIntoConstraints = false
        popUp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 70/100).isActive = true
        popUp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 38/100).isActive = true
        popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUp.layer.cornerRadius = 10
        popUp.center = view.center
        popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUp.alpha = 0
        UIView.animate(withDuration: 0.1) {
            popUp.alpha = 1
            popUp.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(popUp: UIView) {
        UIView.animate(withDuration: 0.1) {
            popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            popUp.alpha = 0
        } completion: { (success: Bool) in
            popUp.removeFromSuperview()
        }
    }
    
    func animateInSettings(view: UIView, popUp: UIView) {
        view.addSubview(popUp)
        popUp.translatesAutoresizingMaskIntoConstraints = false
        popUp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 90/100).isActive = true
        popUp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 48/100).isActive = true
        popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUp.layer.cornerRadius = 10
        popUp.center = view.center
        popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUp.alpha = 0
        UIView.animate(withDuration: 0.1) {
            popUp.alpha = 1
            popUp.transform = CGAffineTransform.identity
        }
    }
}
