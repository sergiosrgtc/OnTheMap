//
//  UserData.swift
//  OntheMap
//
//  Created by Sergio Costa on 07/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
}

struct User: Codable {
    let lastName: String?
    let socialAccounts: [Any?]?
    let mailingAddress: NSNull?
    let cohortKeys: [Any?]?
    let signature: NSNull?
    let stripeCustomerID: NSNull?
    let userGuard: Guard?
    let facebookID: NSNull?
    let timezone: NSNull?
    let sitePreferences: NSNull?
    let occupation: NSNull?
    let image: NSNull?
    let firstName: String?
    let jabberID: NSNull?
    let languages: NSNull?
    let badges: [Any?]?
    let location: NSNull?
    let externalServicePassword: NSNull?
    let principals: [String]?
    let enrollments: [Any?]?
    let email: Email?
    let websiteURL: NSNull?
    let externalAccounts: [Any?]?
    let bio: NSNull?
    let coachingData: NSNull?
    let tags: [Any?]?
    let affiliateProfiles: [Any?]?
    let hasPassword: Bool?
    let emailPreferences: EmailPreferences?
    let resume: NSNull?
    let key: String?
    let nickname: String?
    let employerSharing: Bool?
    let zendeskID: NSNull?
    let registered: Bool?
    let linkedinURL: NSNull?
    let googleID: NSNull?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case socialAccounts = "social_accounts"
        case mailingAddress = "mailing_address"
        case cohortKeys = "_cohort_keys"
        case signature = "_signature"
        case stripeCustomerID = "_stripe_customer_id"
        case userGuard = "guard"
        case facebookID = "_facebook_id"
        case timezone = "timezone"
        case sitePreferences = "site_preferences"
        case occupation = "occupation"
        case image = "_image"
        case firstName = "first_name"
        case jabberID = "jabber_id"
        case languages = "languages"
        case badges = "_badges"
        case location = "location"
        case externalServicePassword = "external_service_password"
        case principals = "_principals"
        case enrollments = "_enrollments"
        case email = "email"
        case websiteURL = "website_url"
        case externalAccounts = "external_accounts"
        case bio = "bio"
        case coachingData = "coaching_data"
        case tags = "tags"
        case affiliateProfiles = "_affiliate_profiles"
        case hasPassword = "_has_password"
        case emailPreferences = "email_preferences"
        case resume = "_resume"
        case key = "key"
        case nickname = "nickname"
        case employerSharing = "employer_sharing"
        case memberships = "_memberships"
        case zendeskID = "zendesk_id"
        case registered = "_registered"
        case linkedinURL = "linkedin_url"
        case googleID = "_google_id"
        case imageURL = "_image_url"
    }
}

struct Email: Codable {
    let verificationCodeSent: Bool?
    let verified: Bool?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case verificationCodeSent = "_verification_code_sent"
        case verified = "_verified"
        case address = "address"
    }
}

struct EmailPreferences: Codable {
    let okUserResearch: Bool?
    let masterOk: Bool?
    let okCourse: Bool?
    
    enum CodingKeys: String, CodingKey {
        case okUserResearch = "ok_user_research"
        case masterOk = "master_ok"
        case okCourse = "ok_course"
    }
}

struct Ref: Codable {
    let ref: RefEnum?
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case ref = "ref"
        case key = "key"
    }
}

enum RefEnum: String, Codable {
    case account = "Account"
    case scopedRole = "ScopedRole"
}

struct Guard: Codable {
    let canEdit: Bool?
    let permissions: [Permission]?
    let allowedBehaviors: [String]?
    let subjectKind: String?
    
    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case permissions = "permissions"
        case allowedBehaviors = "allowed_behaviors"
        case subjectKind = "subject_kind"
    }
}

struct Permission: Codable {
    let derivation: [Derivation]?
    let behavior: String?
    let principalRef: Ref?
    
    enum CodingKeys: String, CodingKey {
        case derivation = "derivation"
        case behavior = "behavior"
        case principalRef = "principal_ref"
    }
}

enum Derivation: String, Codable {
    case synthetic = "synthetic"
}
