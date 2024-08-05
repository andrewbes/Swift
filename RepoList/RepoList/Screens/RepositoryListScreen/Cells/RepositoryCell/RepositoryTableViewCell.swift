//
//  DateTableViewCell.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/14/24.
//

import UIKit


protocol RepositoryTableViewCellDelegate {
    
}

class RepositoryTableViewCell: UITableViewCell, BaseCell  {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var toDoTevtView: UITextView!
    
    var viewModel: RepositoryCellModel?
    
    func configure(with viewModel: any BaseCellModelProtocol) {
        self.viewModel = viewModel as? RepositoryCellModel
        if let model = self.viewModel {
            borderView.setBorder(width: 1, color:model.bgColor)
        }
        backgroundColor = .clear
        borderView.backgroundColor = .clear
        dateLabel.text = self.viewModel?.text
        toDoTevtView.text = "TODO's\n"
        if let lines = self.viewModel?.toDos {
            for line in lines {
                toDoTevtView.text.append(line+"\n")
            }
        }
        dateLabel.textColor = .lightGray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard let viewModel else { return }
        let width = viewModel.selected ? 2.5 : 0.5
        borderView.setBorder(width: width, color: viewModel.bgColor )
        toDoTevtView.isHidden = !viewModel.selected
    }
    
}
