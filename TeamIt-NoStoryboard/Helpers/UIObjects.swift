//
//  UIObjects.swift
//  TeamIt-NoStoryboard
//
//  Created by Marco Lima on 2021-04-09.
//

import Foundation
import UIKit

enum FontWeigt {
    case normal
    case bold
    case italic
}

struct UIObjects {
    
    static func label(fontWeigth: FontWeigt, fontSize: CGFloat = 10, fontColor: UIColor = .label) -> UILabel {
        
        let label = UILabel()
        
        switch fontWeigth {
        case .bold:
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        case .normal:
            label.font = UIFont.systemFont(ofSize: fontSize)
        case .italic:
            label.font = UIFont.italicSystemFont(ofSize: fontSize)
        }
        
        label.textColor = fontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }
    
    
    static func image(cornerRadius: CGFloat = 0) -> UIImageView {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = cornerRadius
        img.clipsToBounds = true
        return img
        
    }
    
    
    
}
