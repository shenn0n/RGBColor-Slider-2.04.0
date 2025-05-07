//
//  ComposeColorViewControllerViewController.swift
//  RGBColor Slider 2.04.0
//
//  Created by Александр Манжосов on 01.05.2025.
//

import UIKit

final class ComposeColorViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    // MARK: - Public Properties
    var color: UIColor!
    weak var delegate: ComposeColorViewControllerDelegate?
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlidersFromColor(from: color)
        setViewColor()
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        if sender == redSlider {
            redLabel.text = String(format: "%.2f", redSlider.value)
        } else if sender == greenSlider {
            greenLabel.text = String(format: "%.2f", greenSlider.value)
        } else if sender == blueSlider {
            blueLabel.text = String(format: "%.2f", blueSlider.value)
        }
        setViewColor()
    }

    @IBAction func doneButtonTapped() {
        delegate?.setBackgroundColor(colorView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
}

// MARK: - setupInitialValues
private extension ComposeColorViewController {
    
    func setViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    func setupSlidersFromColor(from color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            redSlider.value = Float(red)
            greenSlider.value = Float(green)
            blueSlider.value = Float(blue)
        } else {
            print("Не удалось получить RGB-компоненты из переданного цвета")
        }
    }
    
}
