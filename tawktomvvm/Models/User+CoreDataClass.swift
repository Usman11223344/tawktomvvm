import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}


enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}


public class User: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case notes
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public required convenience init(from decoder: Decoder) throws {
        
        print(decoder.userInfo)
        guard let managedObjectContext = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
            else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.id = try container.decodeIfPresent(Int32.self, forKey: .id) ?? 0
        self.nodeID = try container.decodeIfPresent(String.self, forKey: .nodeID)
        self.avatarURL = try container.decodeIfPresent(String.self, forKey: .avatarURL)
        self.gravatarID = try container.decodeIfPresent(String.self, forKey: .gravatarID)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.htmlURL = try container.decodeIfPresent(String.self, forKey: .htmlURL)
        self.followersURL = try container.decodeIfPresent(String.self, forKey: .followersURL)
        self.followingURL = try container.decodeIfPresent(String.self, forKey: .followingURL)
        self.gistsURL = try container.decodeIfPresent(String.self, forKey: .gistsURL)
        self.starredURL = try container.decodeIfPresent(String.self, forKey: .starredURL)
        self.subscriptionsURL = try container.decodeIfPresent(String.self, forKey: .subscriptionsURL)
        self.organizationsURL = try container.decodeIfPresent(String.self, forKey: .organizationsURL)
        self.reposURL = try container.decodeIfPresent(String.self, forKey: .reposURL)
        self.eventsURL = try container.decodeIfPresent(String.self, forKey: .eventsURL)
        self.receivedEventsURL = try container.decodeIfPresent(String.self, forKey: .receivedEventsURL)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        
        self.siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
        
        do {
            let userEntity = User.fetchRequest()
            userEntity.predicate = NSPredicate(format: "id = %d", self.id)
            let result = try CoreDataManager.shared.mainContext.fetch(userEntity)
            self.notes = result.first?.notes

        } catch {

        }
//        managedObjectContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(login, forKey: .login)
        try container.encode(id, forKey: .id)
        try container.encode(nodeID, forKey: .nodeID)
        try container.encode(avatarURL, forKey: .avatarURL)
        try container.encode(gravatarID, forKey: .gravatarID)
        try container.encode(url, forKey: .url)
        try container.encode(htmlURL, forKey: .htmlURL)
        try container.encode(followersURL, forKey: .followersURL)
        try container.encode(followingURL, forKey: .followingURL)
        try container.encode(gistsURL, forKey: .gistsURL)
        try container.encode(starredURL, forKey: .starredURL)
        try container.encode(subscriptionsURL, forKey: .subscriptionsURL)
        try container.encode(organizationsURL, forKey: .organizationsURL)
        try container.encode(reposURL, forKey: .reposURL)
        try container.encode(eventsURL, forKey: .eventsURL)
        try container.encode(receivedEventsURL, forKey: .receivedEventsURL)
        try container.encode(type, forKey: .type)
        try container.encode(siteAdmin, forKey: .siteAdmin)
        try container.encode(notes, forKey: .notes)
      }
}
