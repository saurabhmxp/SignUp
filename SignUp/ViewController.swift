//
//  ViewController.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 20/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.image?.withTintColor(.systemBlue)
        imageView.isUserInteractionEnabled = true
        return imageView
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
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello All"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Screen", style: .plain, target: self, action: #selector(nextScreen))
        configImageView()
        configureScrollView()
        configureStackView()
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func nextScreen() {
        navigationController?.pushViewController(DetailsVC(), animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func configImageView() {
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 125),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
        profileImageView.layer.masksToBounds = true
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

