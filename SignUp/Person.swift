//
//  UserInfo.swift
//  SignUp
//
//  Created by Saurabh Agarwal on 27/10/22.
//

import Foundation
import UIKit

class Person {
    var image: UIImage?
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var phoneNo: Int
    var email: String
    var password: String
    
    init(image: UIImage? = UIImage(systemName: "person.circle"),
         firstName: String? = nil,
         lastName: String? = nil,
         dateOfBirth: Date? = nil,
         phoneNo: Int,
         email: String,
         password: String) {
        self.image = image
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.phoneNo = phoneNo
        self.email = email
        self.password = password
    }
}
