//
//  SplashScreenVC.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

class LoginScreenVC: UIViewController, ConfigurableVCProtocol {
 
    var viewModel: LoginScreenVMType!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var innerFrameView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    
    @IBOutlet weak var githubNameTextField: UITextField!
    @IBOutlet weak var tokenTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTapToDismissKeyboard()
        print("LoginScreenVC - viewDidLoad")
    }
    
    init() {
            super.init(nibName: nil, bundle: nil)
            print("LoginScreenVC - init")
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            print("LoginScreenVC - init(coder:)")
        }
    
    deinit {
        print("LoginScreenVC - deinit")
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        view.endEditing(true)
        viewModel.login()
    }

    @IBAction func nameTextFieldAction(_ sender: Any) {
        print(githubNameTextField.text ?? "")
        viewModel.githubName = githubNameTextField.text
    }
    
    @IBAction func tokenTextFieldAction(_ sender: Any) {
        print(tokenTextField.text ?? "")
        viewModel.githubToken = tokenTextField.text
    }
    
    //MARK: Configure UI
    internal func configureViews() {
        frameView.setBorder(width: 1, color: .yellow)
        innerFrameView.setBorder(width: 1, color: .yellow)
    }
    
    internal func configureLabels() {
        captionLabel.textColor = .yellow
        captionLabel.text = viewModel.getCaption()
        loginLabel.text = "GitHub login"
        loginLabel.textColor = .yellow
        tokenLabel.text = "GitHub token"
        tokenLabel.textColor = .yellow
        loginButton.setTitle("Login", for: .normal)
    }
    
    internal func configureButtons() {
        loginButton.layer.cornerRadius = 4
    }
}
