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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var color: UIColor!
    weak var delegate: ComposeColorViewControllerDelegate?
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = color
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        
        setViewColor()
    }

    @IBAction func doneButtonTapped() {
        delegate?.setBackgroundColor(colorView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func showAlert(widthTitle: String, andMessage: String, textField: UITextField ) {
        let alert = UIAlertController(title: widthTitle, message: andMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = "0.5"
            textField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
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
    
    func setValue(for colorSlider: UISlider...) {
        let ciColor = CIColor(color: color)
        
        colorSlider.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(ciColor.red)
            case greenSlider:
                greenSlider.value = Float(ciColor.green)
            default:
                blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    func setValue(for textField: UITextField...) {
        
        textField.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = String(format: "%.2f", redSlider.value)
            case greenTextField:
                textField.text = String(format: "%.2f", greenSlider.value)
            default:
                textField.text = String(format: "%.2f", blueSlider.value)
            }
        }
    }
    
    func setValue(for label: UILabel...) {
        
        label.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = String(format: "%.2f", redSlider.value)
            case greenLabel:
                greenLabel.text = String(format: "%.2f", greenSlider.value)
            default:
                blueLabel.text = String(format: "%.2f", blueSlider.value)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension ComposeColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let pattern = "^0(\\.\\d{0,2})?$|^1(\\.0{0,2})?$"
        let isValueValid = NSPredicate(format: "SELF MATCHES %@", pattern)
            .evaluate(with: textField.text)
        
        if !isValueValid {
            showAlert(
                widthTitle: "Wrong format",
                andMessage: "Plese enter correct volue",
                textField: textField
            )
            
        } else {
            
            let value = Float(textField.text ?? "") ?? 0
            
            switch textField {
            case redTextField:
                redSlider.setValue(value, animated: true)
                setValue(for: redLabel)
            case greenTextField:
                greenSlider.setValue(value, animated: true)
                setValue(for: greenLabel)
            default:
                blueSlider.setValue(value, animated: true)
                setValue(for: blueLabel)
            }
            
            setViewColor()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
