//
//  Label&TextField.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 20/10/22.
//

import UIKit

class Label_TextField: UIView {

    private let label = UILabel()
    private let field: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 2
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: field.frame.height))
        field.leftViewMode = UITextField.ViewMode.always
        return field
    }()
    private var dataCheck: UILabel = {
        let label = UILabel()
        label.text = "Required"
        label.textColor = .systemRed
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
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
        addSubview(dataCheck)
        translatesAutoresizingMaskIntoConstraints = false
        setLabelConstraints()
        setFieldConstraints()
        setDataCheckConstraints()
    }
    
    func setLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func setFieldConstraints() {
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: leadingAnchor),
            field.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            field.heightAnchor.constraint(equalToConstant: 30),
            field.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    func setDataCheckConstraints() {
        dataCheck.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dataCheck.leadingAnchor.constraint(equalTo: leadingAnchor),
            dataCheck.topAnchor.constraint(equalTo: field.bottomAnchor, constant: 5),
            dataCheck.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func config(labelText: String) {
        label.text = labelText
        field.placeholder = labelText
        switch labelText {
        case "Phone No":
            dataCheck.isHidden = false
            field.addTarget(self, action: #selector(numberChanged), for: .editingChanged)
        case "Email":
            dataCheck.isHidden = false
            field.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        case "Password":
            dataCheck.isHidden = false
            field.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        default:
            break
        }
    }
    
    func getFieldText() -> String? {
        return field.text
    }
    
    func errorPresent() -> Bool {
        return !dataCheck.isHidden
    }
    
    func phoneKeyboard() {
        field.keyboardType = .phonePad
        
    }
    
    func emailKeyboard() {
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
    }
    
    @objc func emailChanged() {
        if let email = field.text {
            if let errorMessage = invalidEmail(email) {
                dataCheck.text = errorMessage
                dataCheck.isHidden = false
            } else {
                dataCheck.isHidden = true
            }
        }
    }
    
    @objc func passwordChanged() {
        if let password = field.text {
            if let errorMessage = invalidPassword(password) {
                dataCheck.text = errorMessage
                dataCheck.isHidden = false
            } else {
                dataCheck.isHidden = true
            }
        }
    }
    
    @objc func numberChanged() {
        if let number = field.text {
            if let errorMessage = invalidNumber(number) {
                dataCheck.text = errorMessage
                dataCheck.isHidden = false
            } else {
                dataCheck.isHidden = true
            }
        }
    }
    
    func invalidNumber(_ value: String) -> String? {
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "Phone number should only contain digits"
        }
        if value.count != 10 {
            return "Phone number should contain ten digits"
        }
        return nil
    }
    
    func invalidEmail(_ value: String) -> String? {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: value) {
            return "Invalid Email Address"
        }
        return nil
    }
    
    func invalidPassword(_ value: String) -> String? {
        if value.count < 8 {
            return "Password should be off minimum 8-characters"
        }
        return nil
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
        picker.frame.size = CGSize(width: 0, height: 150)
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(didTapDone(sender:)), for: .editingDidEnd)
        field.inputView = picker
    }
    
    @objc func didTapDone(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        field.text = formatter.string(from: sender.date)
        field.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
