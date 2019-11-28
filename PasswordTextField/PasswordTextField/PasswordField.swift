//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    enum PasswordStrength: String {
        case weak = "Too weak         "
        case medium = "Could be stronger"
        case strong = "Strong password  "
    }
    
// MARK: - Properties
    // Variable
    private (set) var password: String = ""
    
    // Colors
    private let bgColor = UIColor(hue: 0,
                                  saturation: 0,
                                  brightness: 97/100.0,
                                  alpha: 1)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0,
                                        saturation: 16/100.0,
                                        brightness: 41/100.0,
                                        alpha: 1)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0,
                                               saturation: 80/100.0,
                                               brightness: 94/100.0,
                                               alpha: 1)
    
    private let unusedColor = UIColor(hue: 210/360.0,
                                      saturation: 5/100.0,
                                      brightness: 86/100.0,
                                      alpha: 1)
    
    private let weakColor = UIColor(hue: 0/360,
                                    saturation: 60/100.0,
                                    brightness: 90/100.0,
                                    alpha: 1)
    
    private let mediumColor = UIColor(hue: 39/360.0,
                                      saturation: 60/100.0,
                                      brightness: 90/100.0,
                                      alpha: 1)
    
    private let strongColor = UIColor(hue: 132/360.0,
                                      saturation: 60/100.0,
                                      brightness: 75/100.0,
                                      alpha: 1)
    
    // Sizes
    private let standardMargin: CGFloat = 8.0
    private let textFieldMargin: CGFloat = 6.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    // Font
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    // Instantiation
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var textFieldContainerView: UIView = UIView()
    private var allElementsStackView: UIStackView = UIStackView()
    private var strengthBarsStackView: UIStackView = UIStackView()
    
    // MARK: - Methods
    // Show/Hide Button Functionality
    @objc func hideText() {
        if showHideButton.currentImage!.isEqual(UIImage(named: "eyes-closed")) {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    // Setup Views
    func setup() {
        backgroundColor = bgColor
    // Set Up Stack Views
        
        // Strength Bar Stack View
        [weakView, mediumView, strongView, strengthDescriptionLabel].forEach {
            strengthBarsStackView.addArrangedSubview($0)
        }
        
        strengthBarsStackView.alignment = .leading
        strengthBarsStackView.distribution = .fill
        strengthBarsStackView.spacing = 3
        
        // All Elements Stack View
        [titleLabel, textField, strengthBarsStackView].forEach {
            allElementsStackView.addArrangedSubview($0) }
        allElementsStackView.spacing = standardMargin
        [allElementsStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        allElementsStackView.alignment = .fill
        allElementsStackView.distribution = .fill
        allElementsStackView.axis = .vertical
        
        // Activate Stack Views
        NSLayoutConstraint.activate([
            allElementsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
            
            allElementsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -standardMargin),
            
            allElementsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
            
            allElementsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin),
            
            strengthBarsStackView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
    // Set Up Subviews
        
        // Title Label
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        // Text Field
        textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: textFieldMargin,
                                                  height: textFieldContainerHeight))
        
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.rightView = showHideButton
        
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        
        // Show/Hide Button
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0,
                                      y: 0,
                                      width: 50,
                                      height: 38)
        
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                      left: 0,
                                                      bottom: 0,
                                                      right: 12)
        
        showHideButton.addTarget(self, action: #selector(hideText), for: .touchUpInside)
        
        // Weak View
        weakView.backgroundColor = unusedColor
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.layer.cornerRadius = colorViewSize.height / 2
        
        // Medium View
        mediumView.backgroundColor = unusedColor
        
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        
        // Strong View
        strongView.backgroundColor = unusedColor
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.layer.cornerRadius = colorViewSize.height / 2
        
        // Strength Description
        strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
    }
    
    // Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
}

// MARK: - Text Field Delegate
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        self.password = newText
        
        let animationWidth: CGFloat = 1.2
        let animationHeight: CGFloat = 1.6
        
        switch newText.count {
        case 1:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = unusedColor
            strongView.backgroundColor    = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
            weakView.transform = CGAffineTransform(scaleX: animationWidth, y: animationHeight)
            UIView.animate(withDuration: 1) {
                self.weakView.transform = .identity
            }
        case 2...6:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = unusedColor
            strongView.backgroundColor    = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        case 7:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
            mediumView.transform = CGAffineTransform(scaleX: animationWidth, y: animationHeight)
            UIView.animate(withDuration: 1) {
                self.mediumView.transform = .identity
            }
        case 8...15:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
        case 16:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = strongColor
            strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
            strongView.transform = CGAffineTransform(scaleX: animationWidth, y: animationHeight)
            UIView.animate(withDuration: 1) {
                self.strongView.transform = .identity
            }
        case 17...Int.max:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = strongColor
            strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
        default:
            weakView.backgroundColor   = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        }
        
        return true
    }
    
    func resetControl() {
        weakView.backgroundColor   = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .valueChanged)
        resetControl()
        textField.text = ""
        return true
    }
}
