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
    // MARK: - Private Properties
    private var delegate: UITextFieldDelegate?
    private var fieldProperties: TextFieldViewProperties?
    
    // MARK: - Subviews
    private let viewContainer: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let fieldLabel: UILabel = {
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
        view.backgroundColor = self.fieldProperties?.bottomBorderColor
        return view
    }()
    
    private lazy var helpTextLabel: UILabel = {
        let label: UILabel = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        label.attributedText = NSMutableAttributedString(string: self.fieldProperties?.helpText ?? "",
                                                      attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.font = UIFont.systemFont(
            ofSize: 14.0,
            weight: UIFont.Weight.bold
        )
        label.textColor = self.fieldProperties?.helpTextColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var validationStatusIcon: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = self.fieldProperties?.inputValidIcon
        return imageView
    }()
    
    private lazy var errorView: UIView = UIView()

    private lazy var errorIconImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = self.fieldProperties?.errorIcon
        return imageView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label: UILabel = UILabel()
   
        label.font = UIFont.systemFont(
            ofSize: 14.0
        )
        label.textColor = UIColor.red
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button: UIButton = UIButton()
        
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 14.0,
            weight: UIFont.Weight.bold
        )
        button.setTitle(self.fieldProperties?.clearButtonLabel, for: .normal)
        button.setTitleColor(self.fieldProperties?.clearButtonColor, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(self.clearText), for: .touchUpInside)

        return button
    }()
    
    init(fieldProperties: TextFieldViewProperties, delegate: UITextFieldDelegate) {
        super.init(frame: CGRect.zero)
        
        self.fieldProperties = fieldProperties
        self.delegate = delegate
        
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.addSubview(self.fieldLabel)
        self.addSubview(self.textField)
        self.addSubview(self.horizontalLineView)
        self.addSubview(self.validationStatusIcon)
        self.addSubview(self.helpTextLabel)
        self.addSubview(self.clearButton)
        
        self.errorView.addSubview(self.errorIconImageView)
        self.errorView.addSubview(self.errorMessageLabel)
        self.addSubview(self.errorView)
        
        self.fieldLabel.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
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
            make.top.equalTo(self.fieldLabel.snp.bottom).offset(10.0)
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
        
        setState(state: .empty)
        self.textField.delegate = delegate
    }
    
    private func setUpErrorDisplay(with message: String?) {
        self.errorMessageLabel.text = message ?? nil
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        self.errorMessageLabel.attributedText = NSMutableAttributedString(string: message ?? "",
        attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.errorView.isHidden = false
        self.clearButton.isHidden = false
        self.helpTextLabel.isHidden = true
    }
    
    @objc func clearText(){
        self.textField.text = nil
        self.textField.becomeFirstResponder()
        self.setState(state: .editing)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: Public APIs

extension TextFieldView {
    
    func setState(state: FieldState) {
        self.errorView.isHidden = true
        self.clearButton.isHidden = true
        self.validationStatusIcon.isHidden = true
        
        switch state {
        case .empty:
            self.fieldLabel.textColor = self.fieldProperties?.defaultLabelColor
            self.helpTextLabel.isHidden = true
            self.validationStatusIcon.isHidden = true
            self.errorView.isHidden = true
            self.clearButton.isHidden = true
            
        case .editing:
            self.fieldLabel.textColor = self.fieldProperties?.activeLabelColor
            self.helpTextLabel.isHidden = false
            
        case .editingError(let error):
            self.fieldLabel.textColor = self.fieldProperties?.activeLabelColor
            self.setUpErrorDisplay(with: error)
            
        case .editingSuccess:
            self.fieldLabel.textColor = self.fieldProperties?.activeLabelColor
            self.validationStatusIcon.isHidden = false
            self.helpTextLabel.isHidden = false
            
        case .filledError(let error):
            self.fieldLabel.textColor = self.fieldProperties?.defaultLabelColor
            self.setUpErrorDisplay(with: error)
            
        case .filledSuccess:
            self.fieldLabel.textColor = self.fieldProperties?.defaultLabelColor
            self.validationStatusIcon.isHidden = false
            self.helpTextLabel.isHidden = true
        }
    }
}




