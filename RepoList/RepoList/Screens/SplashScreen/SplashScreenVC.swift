//
//  SplashScreenVC.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

class SplashScreenVC: UIViewController, ConfigurableVCProtocol {
 
    var viewModel: SplashScreenVMType!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var innerFrameView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = "Welcome!"
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
             self.viewModel.showNextScreen()
         }
        configureUI()
        print("SplashScreenVC - viewDidLoad")
    }
    
    init() {
            super.init(nibName: nil, bundle: nil)
            print("SplashScreenVC - init")
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            print("SplashScreenVC - init(coder:)")
        }
    
    deinit {
        print("SplashScreenVC - deinit")
    }

    //MARK: Configure UI
    internal func configureViews() {
        frameView.setBorder(width: 1, color: .yellow)
        innerFrameView.setBorder(width: 1, color: .yellow)
    }
    
    internal func configureLabels() {
        welcomeLabel.textColor = .white
        captionLabel.textColor = .yellow
        captionLabel.text = viewModel.getCaption()
    }
}
