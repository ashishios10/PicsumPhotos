//
//  Extensions.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import Foundation
import UIKit
import SDWebImage

/// String extension
public extension String {
    func localized (bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    func localizedWith(_ params: CVarArg...) -> String {
        return String(format: localized(), arguments: params)
    }
}

/// Setup navigation bar apperance
public extension UINavigationController {
    func setupDefaultApperance() {
        let customFont = UIFont.setFont(.kFontOswaldBold, size: .regularFont)
        let navigationBarAppearance = UINavigationBarAppearance()
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBarAppearance.backButtonAppearance = backButtonAppearance
        
        navigationBarAppearance.titleTextAttributes = [.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont), .foregroundColor: AppColor.secondaryColor.value]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = AppColor.secondaryColor.value
        navigationBarAppearance.backgroundColor = AppColor.primaryColor.value
    }
}

// MARK: - UIImageView
extension UIImageView {
    public func downloadImage(urlString: String, placeholderImageName: String) {
        self.sd_setImage(with: URL(string: urlString),
                         placeholderImage: UIImage(named: placeholderImageName),
                         completed: { (image, error, cache, url) in
            guard image != nil else { return }
            if cache == .memory {
                self.image = image
            } else {
                UIView.transition(with: self,
                                  duration: 1.35,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.image = image
                }, completion: nil)
            }
        })
    }
}

public extension UIViewController {
    func showAlert(title: String? = applicationName, message: String?) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "alert.okButton.title".localized(),
                                     style: .default,
                                     handler: { (_) -> Void in
        })
        dialogMessage.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func setSubviewToParent(_ subView: UIView) {
        self.view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
}

public extension NSObject {
    @objc class var className: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellWithReuseIdentifier: nibAndReuse)
    }
}

public extension UIFont {
    static func setFont(_ type: fontType = .kFontOswaldRegular, size: AppFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size.rawValue)!
    }
}

/// MARK:- UIWindow
public extension UIWindow {
    static var isLandscape: Bool {
        return UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
}


