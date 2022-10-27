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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(userInfo: Person) {
        self.init()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let showDate = dateFormatter.string(from: userInfo.dateOfBirth ?? Date())
        textView.text = """
            First Name: \(userInfo.firstName)
            Last Name: \(userInfo.lastName)
            Date of Birth: \(showDate)
            Phone No: \(userInfo.phoneNo ?? 0)
            Email: \(userInfo.email)
            Password: \(userInfo.password)
        """
        imageView.image = userInfo.image
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        configImageView()
        configTextView()
    }
    
    func configImageView() {
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
    
    func configTextView() {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
