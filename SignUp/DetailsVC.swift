//
//  DetailsVC.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 20/10/22.
//

import UIKit

class DetailsVC: UIViewController {

    var firstView = Label_TextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = false
        firstView.config(labelText: "First Name")
        view.addSubview(firstView)
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
