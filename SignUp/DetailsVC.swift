//
//  DetailsVC.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 20/10/22.
//

import UIKit

class DetailsVC: UIViewController {
    
    let textView = UITextView()
    let imageView = UIImageView()
    
    init(userInfo: Person) {
        super.init(nibName: nil, bundle: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let showDate = dateFormatter.string(from: userInfo.dateOfBirth ?? Date())
        textView.text = """
            First Name: \(userInfo.firstName ?? "")
            Last Name: \(userInfo.lastName ?? "")
            Date of Birth: \(showDate)
            Phone No: \(userInfo.phoneNo)
            Email: \(userInfo.email)
            Password: \(userInfo.password)
        """
        imageView.image = userInfo.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        setupImageView()
        setupTextView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 125),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        imageView.layer.masksToBounds = true
    }
    
    func setupTextView() {
        textView.layer.cornerRadius = 10
        textView.backgroundColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
}
