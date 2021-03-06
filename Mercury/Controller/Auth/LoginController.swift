//
//  LoginController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 04.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//
import UIKit
import JGProgressHUD
import CommonCrypto

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

class LoginController: UIViewController {
    
    private var viewModel = LoginViewModel()
    private let defaults = UserDefaults.standard
    
    private let iconImage: UIImageView = {
       let iv = UIImageView()
       iv.image = #imageLiteral(resourceName: "mercury_icon_1000px_png")
       iv.tintColor = .white
       return iv
    }()
    
    private lazy var emailContainer: UIView = {
        let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        return containerView
    }()
    
    private lazy var passwordContainer: InputContainerView = {
        let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        return containerView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.4854539633, green: 0.628457427, blue: 0.8009936213, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Login")
    
    private let passwordTextField: CustomTextField = {
       let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
       return tf
    }()
    
    private let dontHaveaccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let login = defaults.string(forKey: Keys.LOGINKEY) {
            if let passhash = defaults.string(forKey: Keys.PASSHASHKEY) {
                DataRepository.shared.authUser(login: login, hash: passhash) { (user) in
                    self.performSegue(withIdentifier: "showMainScreen", sender: nil)
                }
            }
        } else {
            configureUI()
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let login = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        showLoader(true, withText: "Logging in")
        
        DataRepository.shared.authUser(login: login, hash: password.sha1()) { (user) in
            self.defaults.set(login, forKey: Keys.LOGINKEY)
            self.defaults.set(password.sha1(), forKey: Keys.PASSHASHKEY)
            self.performSegue(withIdentifier: "showMainScreen", sender: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        //configureGradientLayer()
        view.backgroundColor = .systemBlue
        
        view.addSubview(iconImage)
//        iconImage.translatesAutoresizingMaskIntoConstraints = false
//        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [emailContainer, passwordContainer, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveaccountButton)
        dontHaveaccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

extension LoginController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.4854539633, green: 0.628457427, blue: 0.8009936213, alpha: 1)
        }
    }
}
