//
//  TODOListScreenVC.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import UIKit

class RepositoryListScreenVC: UIViewController, ConfigurableVCProtocol, ModelConfigurableProtocol {
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var innerFrameView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    func configureWith(model: any ViewModelProtocol) {
        guard let viewModel = model as? RepositoryListScreenVMType else { return }
        self.viewModel = viewModel
    }
    
    var viewModel: RepositoryListScreenVMType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    deinit {
        print("RepositoryListScreenVC - deinit")
    }
    
    //MARK: Actions
    @IBAction func logoutButtonAction(_ sender: Any) {
        viewModel.logout()
    }
    
    //MARK: Configure UI
    internal func configureViews() {
        frameView.setBorder(width: 1, color: .yellow)
        innerFrameView.setBorder(width: 1, color: .yellow)
    }
    
    internal func configureLabels() {
        captionLabel.textColor = .yellow
        captionLabel.text = viewModel.getCaption()
    }
    
    internal func configureTableView() {
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(cellType: RepositoryTableViewCell.self)
    }
}

//MARK:  UITableViewDelegate, UITableViewDataSource
extension RepositoryListScreenVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositoriesCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellModel = viewModel.getCellModel(for: indexPath.section, row: indexPath.row) {
            let identifier = cellModel.cellType.identifier()
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as? BaseCell {
                cell.configure(with: cellModel)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCell(row: indexPath.row) {
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Title"
    }
}
