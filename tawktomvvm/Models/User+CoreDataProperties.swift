import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var login: String?
    @NSManaged public var id: Int32
    @NSManaged public var nodeID: String?
    @NSManaged public var avatarURL: String?
    @NSManaged public var gravatarID: String?
    @NSManaged public var url: String?
    @NSManaged public var htmlURL: String?
    @NSManaged public var followersURL: String?
    @NSManaged public var followingURL: String?
    @NSManaged public var gistsURL: String?
    @NSManaged public var starredURL: String?
    @NSManaged public var subscriptionsURL: String?
    @NSManaged public var organizationsURL: String?
    @NSManaged public var reposURL: String?
    @NSManaged public var eventsURL: String?
    @NSManaged public var receivedEventsURL: String?
    @NSManaged public var type: String?
    @NSManaged public var siteAdmin: Bool
    @NSManaged public var notes: String?

}

extension User : Identifiable {

}
