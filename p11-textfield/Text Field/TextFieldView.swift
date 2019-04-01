//
//  TextFieldView.swift
//  p11-textfield
//
//  Created by Arjin Reyes on 3/28/19.
//  Copyright © 2019 Arjin Reyes. All rights reserved.
//

import Foundation
import SnapKit

public class TextFieldView: UIView {
    
    let label: String = "Label"
    var helpText: String = "Please use active email address"
    var errorLabel: String = ""
//    var errorIcon: UIImage = UIImage("")
    // clear button
    // validation icon
    // line view
    private var activeLabelColor = UIColor(red: 0.17, green: 0, blue: 0.88, alpha: 1)
    private var bottomBorderColor: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
    var helpTextColor = UIColor(red: 0.51, green: 0.6, blue: 0.63, alpha: 1)
    var inputValidIcon = UIImage(named: "icon-green-check")
    var errorIcon = UIImage(named: "icon-error")
    var clearButtonLabel = "CLEAR"
    var clearButtonColor = UIColor(red: 0.51, green: 0.6, blue: 0.63, alpha: 1)
    var errorMessage = ""
    
    private let viewContainer: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(
            ofSize: 16.0,
            weight: UIFont.Weight.bold
        )
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    private let textField: UITextField = {
        let textField: UITextField = UITextField()
       textField.borderStyle = .none
        return textField
    }()
    
    private lazy var horizontalLineView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = self.bottomBorderColor
        return view
    }()
    
    private lazy var helpTextLabel: UILabel = {
        let label: UILabel = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        label.attributedText = NSMutableAttributedString(string: self.helpText,
                                                      attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.font = UIFont.systemFont(
            ofSize: 14.0,
            weight: UIFont.Weight.bold
        )
        label.textColor = self.helpTextColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var validationStatusIcon: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = self.inputValidIcon
        return imageView
    }()
    
    private lazy var errorView: UIView = UIView()

    private lazy var errorIconImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = self.errorIcon
        return imageView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label: UILabel = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        label.attributedText = NSMutableAttributedString(string: self.helpText,
                                                         attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.font = UIFont.systemFont(
            ofSize: 14.0
        )
        label.textColor = UIColor.red
        label.textAlignment = .left
        return label
    }()
    

    
    private lazy var clearButton: UIButton = {
        let button: UIButton = UIButton()
        
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 14.0,
            weight: UIFont.Weight.bold
        )
        button.setTitle(self.clearButtonLabel, for: .normal)
        button.setTitleColor(self.clearButtonColor, for: .normal)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textField.delegate = self
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.addSubview(self.titleLabel)
        self.addSubview(self.textField)
        self.addSubview(self.horizontalLineView)
        self.addSubview(self.validationStatusIcon)
        self.addSubview(self.helpTextLabel)
        self.addSubview(self.clearButton)

        self.errorView.addSubview(self.errorIconImageView)
        self.errorView.addSubview(self.errorMessageLabel)
        self.addSubview(self.errorView)

        self.titleLabel.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.height.equalTo(23.0)
            
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(35.0)
            } else {
                make.top.equalToSuperview().offset(35.0)
            }
            make.leading.equalToSuperview().offset(35.0)
            make.trailing.equalToSuperview().inset(35.0)
        }
        
        self.textField.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(40.0)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().offset(35.0)
            make.trailing.equalToSuperview().inset(35.0)
        }
        
        self.validationStatusIcon.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(20.0)
            make.width.equalTo(20.0)
            make.bottom.equalTo(self.textField.snp.bottom).inset(10.0)
            make.trailing.equalTo(self.textField.snp.trailing).inset(0.0)
        }
        
        self.horizontalLineView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(1)
            make.top.equalTo(self.textField.snp.bottom)
            make.leading.equalTo(self.textField)
            make.trailing.equalTo(self.textField)
        }
        
        self.helpTextLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(17)
            make.top.equalTo(self.textField.snp.bottom).offset(11.0)
            make.leading.equalTo(self.textField)
            make.trailing.equalTo(self.textField)
        }
        
        self.clearButton.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(17.0)
            make.width.equalTo(50.0)
            make.bottom.equalTo(self.textField.snp.bottom).inset(10.0)
            make.trailing.equalTo(self.textField.snp.trailing).inset(0.0)
        }
        
        //  Error View
        self.errorView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(20)
            make.top.equalTo(self.textField.snp.bottom).offset(11.0)
            make.leading.equalTo(self.textField)
            make.trailing.equalTo(self.textField)
        }
        self.errorIconImageView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(18)
            make.width.equalTo(18)

            make.top.equalToSuperview()
            make.leading.equalTo(self.errorView)
        }
        
        self.errorMessageLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(18)
            make.top.equalToSuperview()
            make.leading.equalTo( self.errorIconImageView.snp.trailing).offset(6.0)
            make.trailing.equalToSuperview()
        }
        
        helpTextLabel.isHidden = true
        validationStatusIcon.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension TextFieldView: UITextFieldDelegate {
    
}


