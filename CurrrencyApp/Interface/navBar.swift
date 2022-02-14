//
//  navBar.swift
//  CurrrencyApp
//
//  Created by Egor Geronin on 12.02.2022.
//

import Foundation
import UIKit

class navBar: UINavigationBar
{
    convenience init()
    {
        self.init(frame: .zero)
        topItem!.title = "LOL"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
