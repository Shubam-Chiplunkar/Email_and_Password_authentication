//
//  ViewController.swift
//  EmailPasswordLogin
//
//  Created by mayank ranka on 08/05/23.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {
    
    var logoImageView       : UIImageView!
    var emailLabel          : UILabel!
    var emailTextField      : UITextField!
    var passwordLabel       : UILabel!
    var passwordTextField   : UITextField!
    var facebookButton      : UIButton!
    var signInButton        : UIButton!
    var otherSignUp         : UILabel!
    var signOutButton       : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPage()
        //        googleLoad()
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
            emailLabel.isHidden = true
            passwordLabel.isHidden = true
            signInButton.isHidden = true
            otherSignUp.isHidden = true
            facebookButton.isHidden = true
            
            if signOutButton == nil{
                signOutButton = UIButton()
                signOutButton.translatesAutoresizingMaskIntoConstraints = false
                signOutButton.setTitle("Sign Out", for: .normal)
                signOutButton.backgroundColor = .black
                signOutButton.addTarget(self, action: #selector(signOutButtonClicked), for: .touchUpInside)
                view.addSubview(signOutButton)
                
                NSLayoutConstraint.activate([
                    signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    signOutButton.heightAnchor.constraint(equalToConstant: 40),
                    signOutButton.widthAnchor.constraint(equalToConstant: 100),
                ])
            }
            
        }
    }
    
    @objc func signOutButtonClicked(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            print("User is Signed out")
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            emailLabel.isHidden = false
            passwordLabel.isHidden = false
            signInButton.isHidden = false
            otherSignUp.isHidden = false
            facebookButton.isHidden = false
            
            signOutButton.removeFromSuperview()
        }catch{
            print("An error occured")
        }
    }
    
    
    @objc func googleButtonClick(){
        //        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    @objc func signInButtonClicked(){
        guard let email = emailTextField.text , !email.isEmpty, let password = passwordTextField.text , !password.isEmpty else{
            print("Missing data")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else {
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            print("You have been signed in")
            strongSelf.emailTextField.isHidden = true
            strongSelf.passwordTextField.isHidden = true
            strongSelf.signInButton.isHidden = true
            strongSelf.facebookButton.isHidden = true
            strongSelf.otherSignUp.isHidden = true
            strongSelf.emailLabel.text = "Hello"
            strongSelf.passwordLabel.text = "You have been signed in"
            
            strongSelf.emailTextField.resignFirstResponder()
            strongSelf.passwordTextField.resignFirstResponder()
        })
        
    }
    
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title:"Create Account", message: "Your account doesn't exist, would you like to create an acconut", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else{
                    return
                }
                guard error == nil else {
                    print("Account creation failed \(error?.localizedDescription)")
                    return
                }
                print("You have been signed in")
                strongSelf.emailTextField.isHidden = true
                strongSelf.passwordTextField.isHidden = true
                strongSelf.signInButton.isHidden = true
                strongSelf.facebookButton.isHidden = true
                strongSelf.otherSignUp.isHidden = true
                strongSelf.emailLabel.text = "Hello"
                strongSelf.passwordLabel.text = "You have been signed in"
                
                strongSelf.signOutButton.isHidden = false
                
                strongSelf.emailTextField.resignFirstResponder()
                strongSelf.passwordTextField.resignFirstResponder()
                
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
                        
    }
                        
        func loadPage(){
            if logoImageView == nil{
                logoImageView = UIImageView()
                logoImageView.translatesAutoresizingMaskIntoConstraints = false
                logoImageView.image = UIImage(named: "profile")
                logoImageView.layer.cornerRadius = 50
                view.addSubview(logoImageView)
                
                NSLayoutConstraint.activate([
                    logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    logoImageView.heightAnchor.constraint(equalToConstant: 100),
                    logoImageView.widthAnchor.constraint(equalToConstant: 100)
                ])
            }
            if emailLabel == nil{
                emailLabel = UILabel()
                emailLabel.translatesAutoresizingMaskIntoConstraints = false
                emailLabel.text = "Email"
                emailLabel.font = UIFont(name: "Arial", size: 15)
                view.addSubview(emailLabel)
                
                NSLayoutConstraint.activate([
                    emailLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
                    emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    emailLabel.heightAnchor.constraint(equalToConstant: 30)
                ])
            }
            if emailTextField == nil{
                
                emailTextField = UITextField()
                emailTextField.translatesAutoresizingMaskIntoConstraints = false
                emailTextField.placeholder = "Email"
                emailTextField.autocapitalizationType = .none
                emailTextField.leftViewMode = .always
                emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
                //        emailTextField.textAlignment = .center
                view.addSubview(emailTextField)
                
                NSLayoutConstraint.activate([
                    emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
                    emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    emailTextField.heightAnchor.constraint(equalToConstant: 20)
                ])
            }
            if passwordLabel == nil{
                passwordLabel = UILabel()
                passwordLabel.translatesAutoresizingMaskIntoConstraints = false
                passwordLabel.text = "Password"
                passwordLabel.font = UIFont(name: "Arial", size: 15)
                view.addSubview(passwordLabel)
                
                NSLayoutConstraint.activate([
                    passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
                    passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    passwordLabel.heightAnchor.constraint(equalToConstant: 30)
                ])
            }
            
            if passwordTextField == nil{
                passwordTextField = UITextField()
                passwordTextField.translatesAutoresizingMaskIntoConstraints = false
                passwordTextField.placeholder = "Password"
                //       passwordTextField.textAlignment = .center
                view.addSubview(passwordTextField)
                
                NSLayoutConstraint.activate([
                    passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
                    passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    passwordTextField.heightAnchor.constraint(equalToConstant: 20)
                ])
            }
            
            if signInButton == nil{
                signInButton = UIButton()
                signInButton.translatesAutoresizingMaskIntoConstraints = false
                signInButton.setTitle("Sign-In", for: .normal)
                signInButton.backgroundColor = .black
                signInButton.layer.cornerRadius = 10
                signInButton.clipsToBounds = true
                signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
                view.addSubview(signInButton)
                
                NSLayoutConstraint.activate([
                    signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
                    signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    signInButton.heightAnchor.constraint(equalToConstant: 40)
                ])
                
                
            }
            if otherSignUp == nil{
                otherSignUp = UILabel()
                otherSignUp.translatesAutoresizingMaskIntoConstraints = false
                otherSignUp.text = "-------Other Sign Up--------"
                otherSignUp.textAlignment = .center
                otherSignUp.textColor = .gray
                otherSignUp.font = UIFont(name: "Arial", size: 12)
                view.addSubview(otherSignUp)
                
                NSLayoutConstraint.activate([
                    otherSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    otherSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    otherSignUp.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
                ])
            }
            
            if facebookButton == nil{
                facebookButton = UIButton()
                facebookButton.translatesAutoresizingMaskIntoConstraints = false
                facebookButton.setTitle("Google", for: .normal)
                //            facebookButton.setImage(UIImage(named: "google"), for: .normal)
                facebookButton.imageView?.contentMode = .scaleToFill
                facebookButton.setTitleColor(UIColor.black, for: .normal)
                facebookButton.semanticContentAttribute = .forceLeftToRight
                facebookButton.backgroundColor = .init(red: 235/255, green: 242/255, blue: 240/255, alpha: 1)
                facebookButton.layer.cornerRadius = 10
                facebookButton.addTarget(self, action: #selector(googleButtonClick), for: .touchUpInside)
                view.addSubview(facebookButton)
                
                NSLayoutConstraint.activate([
                    facebookButton.topAnchor.constraint(equalTo: otherSignUp.bottomAnchor, constant: 30),
                    facebookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    facebookButton.heightAnchor.constraint(equalToConstant: 50),
                    facebookButton.widthAnchor.constraint(equalToConstant: 150)
                ])
            }
            
        }
                        
                        
                        
                        
                        }
                        
