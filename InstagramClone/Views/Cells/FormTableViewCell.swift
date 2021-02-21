//
//  FormTableViewCell.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 21/2/21.
//

import UIKit
 
// Custom delegate that the root ViewController must conform to that will be used to send the updated
// model back to the View so we can gather all the new information and save it.

protocol FormTableViewCellDelegate: AnyObject {
    
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

/// Custom view for each cell in Edit Profile, we want a text field and a label
class FormTableViewCell: UITableViewCell {

    static let identifier = "FormTableViewCell"
    
    private var model: EditProfileFormModel?
    
    public weak var delegate: FormTableViewCellDelegate?
    
    
    // MARK: UI Elements
    private let formLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        
        return label
    }()
    
    private let field: UITextField = {
        
        let field = UITextField()
        field.returnKeyType = .done
        return field
        
    }()
    
    // MARK: Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        
        // Will want a custom delegate to send the information back to the root vc
        field.delegate = self
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuring our custom cell with the info from the model in that cell
    public func configure(with model: EditProfileFormModel) {
        
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // assign frames
        formLabel.frame = CGRect(x: 20,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        
        field.frame = CGRect(x: formLabel.right + 20,
                             y: 0,
                             width: contentView.width - formLabel.width - 10,
                             height: contentView.height)
    }
    
}

extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        // Checking for non-empty text-field
        
        guard !textField.text!.isEmpty else {
            return false
        }
        
        // Updating the model value and assigning to an actual const
        model?.value = textField.text
        
        guard let model = model else {
            return false
        }
        
        // Calling the didUpdateField callback to let the EditProfileViewController know that we updated
        // the model
        
        delegate?.formTableViewCell(self, didUpdateField: model)
        
        return true
    }
}
