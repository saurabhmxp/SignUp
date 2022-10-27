//
//  ViewController.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 20/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    let userInfo = Person(firstName: "", lastName: "", email: "", password: "")
    var oldContentInset = UIEdgeInsets.zero
    var oldIndicatorInset = UIEdgeInsets.zero
    var oldOffset = CGPoint.zero
    var keyboardShowing = false
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.image?.withTintColor(.systemBlue)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Submit", for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let firstName = Label_TextField()
    let lastName = Label_TextField()
    let phoneNo = Label_TextField()
    let dateOfBirth = Label_TextField()
    let email = Label_TextField()
    let password = Label_TextField()
    
    let stackView = UIStackView()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello All"
        view.backgroundColor = .systemBackground
        configureScrollView()
        configImageView()
        configureStackView()
        profileImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapImage)
            )
        )
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(hideKeyboard)
            )
        )
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapButton() {
        if email.errorPresent() || password.errorPresent() || phoneNo.errorPresent() {
            let ac = UIAlertController(
                title: "Error",
                message: "Please conform to the data checks",
                preferredStyle: .alert
            )
            ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(ac, animated: true)
        } else {
            userInfo.firstName = firstName.getFieldText() ?? ""
            userInfo.lastName = lastName.getFieldText() ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            userInfo.dateOfBirth = dateFormatter.date(from: dateOfBirth.getFieldText() ?? "")
            
            userInfo.phoneNo = Int(phoneNo.getFieldText() ?? "")
            userInfo.email = email.getFieldText() ?? ""
            userInfo.password = password.getFieldText() ?? ""
            
            let image = profileImageView.image ?? UIImage(systemName: "person.circle")
            userInfo.image = image
            
            let nextVC = DetailsVC(userInfo: userInfo)
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if self.keyboardShowing {
            return
        }
        self.keyboardShowing = true

        self.oldContentInset = self.scrollView.contentInset
        self.oldIndicatorInset = self.scrollView.verticalScrollIndicatorInsets
        self.oldOffset = self.scrollView.contentOffset
        
        let d = notification.userInfo!
        var r = d[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        r = self.scrollView.convert(r, from:nil)
        // no need to scroll, as the scroll view will do it for us
        // so all we have to do is adjust the inset
        self.scrollView.contentInset.bottom = r.size.height
        self.scrollView.verticalScrollIndicatorInsets.bottom = r.size.height
    }

    @objc func keyboardWillHide() {
        if !self.keyboardShowing {
            return
        }
        self.keyboardShowing = false
        self.scrollView.contentOffset = self.oldOffset
        self.scrollView.verticalScrollIndicatorInsets = self.oldIndicatorInset
        self.scrollView.contentInset = self.oldContentInset
    }
    
    func configImageView() {
        scrollView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 125),
            profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
        profileImageView.layer.masksToBounds = true
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func configureStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        firstName.config(labelText: "First Name")
        lastName.config(labelText: "Last Name")
        dateOfBirth.config(labelText: "Date of Birth")
        phoneNo.config(labelText: "Phone No")
        email.config(labelText: "Email")
        password.config(labelText: "Password")
        dateOfBirth.addDatePicker()
        phoneNo.phoneKeyboard()
        email.emailKeyboard()
        password.customizePasswordField()
        
        stackView.addArrangedSubview(firstName)
        stackView.addArrangedSubview(lastName)
        stackView.addArrangedSubview(dateOfBirth)
        stackView.addArrangedSubview(phoneNo)
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(button)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        profileImageView.image = image
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
}

