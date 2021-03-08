//
//  Font+Extension.swift
//  CanCook
//
//  Created by haiphan on 2/4/21.
//

import UIKit

extension UIFont {
    class func droidSans(size: CGFloat) -> UIFont {
        return UIFont(name: "DroidSans", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
