//
//  EditProfileViewController.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

/// Allows the user to edit details about their profile
final class EditProfileViewController: UIViewController {
    
    
    // The models that will edit each field of our profile
    private var models = [[EditProfileFormModel]]()
    

    // MARK: TableView
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        
        return "Private information"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        
    
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
    }
    
    private func configureModels() {
        
        // Section 1: name, username, website, bio
        let sectionOneLabels = ["Name", "Username", "Bio"]
        var sectionOne = [EditProfileFormModel]()
        
        for label in sectionOneLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            sectionOne.append(model)
        }
        
        models.append(sectionOne)
        
        // Section 2: email, phone, gender
        
        let sectionTwoLabels = ["Email", "Phone", "Gender"]
        var sectionTwo = [EditProfileFormModel]()
        
        for label in sectionTwoLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            sectionTwo.append(model)
        }
        
        models.append(sectionTwo)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }
   
    // Setting a profile info section at the header of the table
    private func createTableHeaderView() -> UIView {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size)/2,
                                                        y: (header.height - size)/2,
                                                        width: size,
                                                        height: size))
        
        header.addSubview(profilePhotoButton)
        
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        
        // default
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    @objc private func didTapProfilePhotoButton() {
        
    }
    
    @objc private func didTapSave() {
        // save data
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        
        // Show action sheet to ask to take a picture or select existing
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        // iPad specific code
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension EditProfileViewController: UITableViewDataSource, FormTableViewCellDelegate {
    
    // MARK: Extension methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Accessing the model at each index
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    // Called whenever the Return key is hit after editing any of the fields
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        
        print("\(updatedModel.label) was updated")
    }
}
