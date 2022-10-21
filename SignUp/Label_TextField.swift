//
//  Label&TextField.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 20/10/22.
//

import UIKit

class Label_TextField: UIView {

    private let label = UILabel()
    private let field = UITextField()
    private let picker = UIDatePicker()
    private var isVisible = false
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.image = UIImage(systemName: "eye.fill")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(field)
        translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 2
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: field.frame.height))
        field.leftViewMode = UITextField.ViewMode.always
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = bounds.size.width
        label.frame = CGRect(x: 0, y: 0, width: size, height: 30)
        field.frame = CGRect(x: 0, y: 40, width: size, height: 30)
    }
    
    func config(labelText: String) {
        label.text = labelText
        field.placeholder = labelText
    }
    
    func phoneKeyboard() {
        field.keyboardType = .phonePad
        
    }
    
    func emailKeyboard() {
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
    }
    
    func customizePasswordField() {
        let rightView = UIView()
        rightView.addSubview(imageView)
        rightView.frame = CGRect(x: 0, y: 0, width: imageView.image!.size.width, height: imageView.image!.size.height)
        imageView.frame = CGRect(x: -10, y: 0, width: imageView.image!.size.width, height: imageView.image!.size.height)
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapEye(sender:))
            )
        )
        field.rightView = rightView
        field.rightViewMode = .always
        field.isSecureTextEntry = true
    }
    
     @objc func didTapEye(sender: UITapGestureRecognizer) {
        if isVisible {
            field.isSecureTextEntry = true
            imageView.image = UIImage(systemName: "eye.fill")
            isVisible = false
        } else {
            field.isSecureTextEntry = false
            imageView.image = UIImage(systemName: "eye.slash.fill")
            isVisible = true
        }
    }
    
    func addDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        toolbar.setItems([doneBtn], animated: true)
        field.inputAccessoryView = toolbar
        
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.sizeToFit()
        field.inputView = picker
    }
    
    @objc func didTapDone() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd/mm/yyyy"
        formatter.timeStyle = .none
        
        field.text = formatter.string(from: picker.date)
        field.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}