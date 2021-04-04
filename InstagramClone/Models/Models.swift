//
//  Models.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 22/2/21.
//

import Foundation

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}



// Types of the user post
public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImageURL: URL
    let postURL: URL // Either a video link or full-res photo
    let caption: String?
    let likes: [PostLike]
    let comments: [PostComment]
    let createdAt: Date
    let taggedUsers: [User]
}


struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdAt: Date
    let likes: [CommentLike]
}
