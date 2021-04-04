//
//  NotificationsViewController.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}


class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.isHidden = false
        
        // Registering our two kinds of notification cells we can receive, either a follow event, or a like event.
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    // Will not be instantiated unless we actually call for it
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    
    private func fetchNotifications() {
        for x in 0...100 {
            // dummy post
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImageURL: URL(string: "https://www.google.com")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likes: [],
                                comments: [],
                                createdAt: Date(),
                                taggedUsers: [])
            // dummy notification model
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello notification",
                                         user: User(username: "Joe",
                                         bio: "",
                                         name: (first: "", last: ""),
                                         profilePhoto: URL(string: "https://www.google.com")!,
                                         birthDate: Date(),
                                         gender: .male,
                                         counts: UserCount(followers: 1, following: 1, posts: 1),
                                         joinDate: Date()))
            models.append(model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        
        view.addSubview(spinner)
        //spinner.startAnimating()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        view.addSubview(noNotificationsView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        switch model.type {
        case .like(_):
            
            // like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier,
                                                 for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
            
        case .follow:
            
            // follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier,
                                                 for: indexPath) as! NotificationFollowEventTableViewCell
            //cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("Tapped post")
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped follow/unfollow")
    }
}
