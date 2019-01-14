//
//  LoginViewController.swift
//  AppSwiftTemplate-tvOS
//
//  Created by Benoit BRIATTE on 13/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import Roadblock
import Monet
import SessionKit

public class LoginViewController: BaseViewController {

    public enum Field {
        public static let email = "email"
        public static let lastName = "last_name"
        public static let firstName = "first_name"
    }

    public fileprivate(set) var form: Form!
    public fileprivate(set) var formTextFieldChainable: FormTextFieldDelegateChainable!

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var closeButton: UIButton!

    open class func newInstance() -> LoginViewController {
        return LoginViewController()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.createForm()
    }

    open override func setupUI(theme: Theme) {
        super.setupUI(theme: theme)
        self.title = "login.title".localized()
        self.emailTextField.setAppearance(theme.input)
        self.emailTextField.setPlaceholderAppearance(theme.placeholder,
                                                     placeholder: "login.email.placeholder".localized())
        self.lastNameTextField.setAppearance(theme.input)
        self.lastNameTextField.setPlaceholderAppearance(theme.placeholder,
                                                     placeholder: "login.last_name.placeholder".localized())
        self.firstNameTextField.setAppearance(theme.input)
        self.firstNameTextField.setPlaceholderAppearance(theme.placeholder,
                                                     placeholder: "login.first_name.placeholder".localized())

        self.submitButton.setAppearance(theme.action)
        self.submitButton.setTitle("login.submit".localized(), for: .normal)

        self.closeButton.setAppearance(theme.action)
    }

    open func createForm() {
        let form = Form(fields: [
            .init(identifier: Field.email,
                target: self.emailTextField,
                name: "login.email".localized(),
                validator: FieldValidators.group(
                    FieldValidators.required(),
                    FieldValidators.email()
                ),
                transformer: FieldTransformers.group(
                    FieldTransformers.trim(),
                    FieldTransformers.emptyIsNil()
                )
            ),
            .init(identifier: Field.lastName,
                  target: self.lastNameTextField,
                  name: "login.last_name".localized(),
                  validator: FieldValidators.group(
                    FieldValidators.min(length: 2),
                    FieldValidators.max(length: 30)
                ),
                  transformer: FieldTransformers.group(
                    FieldTransformers.trim(),
                    FieldTransformers.emptyIsNil()
                )
            ),
            .init(identifier: Field.firstName,
                  target: self.firstNameTextField,
                  name: "login.first_name".localized(),
                  validator: FieldValidators.group(
                    FieldValidators.min(length: 2),
                    FieldValidators.max(length: 30)
                ),
                  transformer: FieldTransformers.group(
                    FieldTransformers.trim(),
                    FieldTransformers.emptyIsNil()
                )
            )
        ], delegate: self)
        let formTextFieldChainable = FormTextFieldDelegateChainable(form: form)
        self.emailTextField.delegate = formTextFieldChainable
        self.lastNameTextField.delegate = formTextFieldChainable
        self.firstNameTextField.delegate = formTextFieldChainable
        self.form = form
        self.formTextFieldChainable = formTextFieldChainable
    }

    @IBAction func touchClose() {
        self.dismiss(animated: true)
    }

    @IBAction func touchSubmit() {
        self.view.endEditing(true)
        do {
            try self.form.validate()
        } catch {
            print(error.localizedDescription)
            return
        }
        Session.start()
        self.touchClose()
    }
}

extension LoginViewController: FormDelegate {

    public func formDidSubmit(_ form: Form) {
        self.touchSubmit()
    }
}
