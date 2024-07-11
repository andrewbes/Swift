//
//  TODOListScreenVC.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import UIKit

class TODOListScreenVC: UIViewController, ConfigurableVCProtocol, ModelConfigurableProtocol {
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var innerFrameView: UIView!
    @IBOutlet weak var todoTableView: UITableView!
    
    func configureWith(model: any ViewModelProtocol) {
        guard let viewModel = model as? TODOListScreenVMType else { return }
        self.viewModel = viewModel
    }
    
    var viewModel: TODOListScreenVMType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    deinit {
        print("TODOListScreenVC - deinit")
    }

    //MARK: Configure UI
    internal func configureViews() {
        frameView.setBorder(width: 1, color: .yellow)
        innerFrameView.setBorder(width: 1, color: .yellow)
    }
    
    internal func configureLabels() {
        captionLabel.textColor = .yellow
        captionLabel.text = "[ This week's TODO ]"
    }
    
    internal func configureTableView() {
        todoTableView.backgroundColor = .clear
    }
}
