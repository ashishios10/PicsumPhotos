//
//  ProgressHUD.swift
//  
//
//  Created by Ashish Patel on 1/17/23.
//

import UIKit
import Utilities

/// Custom Loading View
public class ProgressHUD {
    
    private static var vSpinner: UIView?
    public class func showSpinner(onView: UIView,
                                  _ text: String? = nil) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        activityIndicator.startAnimating()
        activityIndicator.color = .lightGray
        activityIndicator.frame = CGRect(x: (spinnerView.frame.size.width/2)-20,
                                         y: (spinnerView.frame.size.height/2)-40,
                                         width: 40,
                                         height: 40)
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            if text != nil {
                let lblSpinerText: UILabel = {
                    let label = UILabel()
                    label.font = .systemFont(ofSize: 18)
                    label.textColor = .lightGray
                    label.adjustsFontSizeToFitWidth = true
                    label.minimumScaleFactor = 0.75
                    label.textAlignment = .center
                    return label
                }()
                lblSpinerText.text = text
                lblSpinerText.frame = CGRect(x: 0,
                                             y: (activityIndicator.frame.origin.y)+40,
                                             width: spinnerView.frame.size.width,
                                             height: 20)
                spinnerView.addSubview(lblSpinerText)
            }
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    public class func removeSpinner() {
        Self.vSpinner?.removeFromSuperview()
        Self.vSpinner = nil
    }
}
