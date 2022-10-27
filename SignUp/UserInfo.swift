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
    var firstName: String
    var lastName: String
    var dateOfBirth: Date?
    var phoneNo: Int?
    var email: String
    var password: String
    
    init(image: UIImage? = nil, firstName: String, lastName: String, dateOfBirth: Date? = nil, phoneNo: Int? = nil, email: String, password: String) {
        self.image = image
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.phoneNo = phoneNo
        self.email = email
        self.password = password
    }
}
