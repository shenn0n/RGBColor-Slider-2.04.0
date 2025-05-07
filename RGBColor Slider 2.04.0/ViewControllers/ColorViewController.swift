//
//  ColorViewController.swift
//  RGBColor Slider 2.04.0
//
//  Created by Александр Манжосов on 07.05.2025.
//

import UIKit

protocol ComposeColorViewControllerDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

final class ColorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeColorVC = segue.destination as? ComposeColorViewController
        composeColorVC?.color = view.backgroundColor
        composeColorVC?.delegate = self
    }
}

extension ColorViewController: ComposeColorViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
