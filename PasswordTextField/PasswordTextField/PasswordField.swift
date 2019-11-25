//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        // Background
        backgroundColor = bgColor
        frame = CGRect(x: standardMargin, y: standardMargin, width: intrinsicContentSize.width, height: textFieldContainerHeight)
        
        // Enter Password Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.textAlignment = .left
        
        
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: standardMargin).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: standardMargin).isActive = true
       
        // Text Field
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = password
        
        NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: textFieldMargin).isActive = true
        NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: standardMargin).isActive = true
        
        // Show/Hide Button
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(contentsOfFile: "eyes-closed"), for: .normal)
        
        NSLayoutConstraint(item: showHideButton, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: showHideButton, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1.0, constant: 0).isActive =  true
        
        // Weak View
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.sizeThatFits(colorViewSize)
        weakView.backgroundColor = unusedColor
        
        NSLayoutConstraint(item: weakView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1.0, constant: standardMargin).isActive = true
        NSLayoutConstraint(item: weakView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: standardMargin).isActive = true
  
        // Medium View
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.sizeThatFits(colorViewSize)
        mediumView.backgroundColor = unusedColor
        
        NSLayoutConstraint(item: mediumView, attribute: .top, relatedBy: .equal, toItem: weakView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mediumView, attribute: .leading, relatedBy: .equal, toItem: weakView, attribute: .trailing, multiplier: 1, constant: 2).isActive = true
        
        // Strong View
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.sizeThatFits(colorViewSize)
        strongView.backgroundColor = unusedColor
        
        NSLayoutConstraint(item: strongView, attribute: .top, relatedBy: .equal, toItem: weakView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: strongView, attribute: .leading, relatedBy: .equal, toItem: mediumView, attribute: .trailing, multiplier: 1, constant: 2).isActive = true
        
        // Strength Description Label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Enter password to see strength"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: weakView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: strongView, attribute: .trailing, multiplier: 1, constant: 2).isActive = true
    }
    
    // Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
//
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
