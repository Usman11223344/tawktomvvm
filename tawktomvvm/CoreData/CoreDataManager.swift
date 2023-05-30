import Foundation
import CoreData

enum CoreDataError: Error {
    case notFound
}

class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    private let coreDataStack = CoreDataStack(modelName: "tawktomvvm")
    
    private init() {
    }
    
    var mainContext: NSManagedObjectContext {
        coreDataStack.mainManagedObjectContext
    }
    
    var childContext: NSManagedObjectContext {
        coreDataStack.privateManagedObjectContext
    }

    // MARK: - Core Data Saving support
    
    

    func saveContext () {
        saveMainContext()
        saveChildContext()
    }

}

//MARK: - Save Context
extension CoreDataManager {
    
    fileprivate func saveMainContext() {
        mainContext.performAndWait {
            do {
                print("Child context")
                if self.mainContext.hasChanges {
                    print("Data save in Main context")
                    try self.mainContext.save()
                }
            } catch {
                print("Unable to Save Changes of Main Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func saveChildContext() {
        childContext.perform {
            do {
                print("Child context")
                if self.childContext.hasChanges {
                    print("Data save in Child context")
                    try self.childContext.save()
                }
            } catch {
                print("Unable to Save Changes of Private Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
    
    
}

//MARK: - Fetch Request
extension CoreDataManager {
    
    fileprivate func fetchRequest<T: NSManagedObject>(request: NSFetchRequest<T>, on context: NSManagedObjectContext) throws -> [T] {
        
        do {
            let data = try context.fetch(request)
            return data
        } catch {
            throw CoreDataError.notFound
            
        }
    }
}

