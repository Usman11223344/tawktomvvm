import Foundation
import UIKit

public protocol UsersViewModelType {

    var viewDelegate: UsersViewModelViewDelegate? { get set }
    var page: Int { get set }
    var isSearching: Bool { get set }
    var isCalling: Bool { get set }
    var users: [User] { get set }
    var searchUsers: [User] { get set }

    func nextPage()
    func refresh()
    func numberOfItems() -> Int
    func itemFor(row: Int) -> User
    func start()
    func searchFor(text: String)
    func enableSearch()
    func clearSearch()
    func didSelectRow(_ row: Int, from controller: UIViewController)
}

public protocol UsersViewModelCoordinatorDelegate: AnyObject {
    func didSelect(user: User, from controller: UIViewController)
}

public protocol UsersViewModelViewDelegate: AnyObject {
    func updateScreen()
    func showError(error: String)
    func showIndicator()
    func hideIndicator()
}

class UsersViewModel {

    // MARK: - Delegates
    weak var coordinatorDelegate: UsersViewModelCoordinatorDelegate?

    weak var viewDelegate: UsersViewModelViewDelegate?

    // MARK: - Properties
    fileprivate let service: UsersAPIServiceProtocol
    fileprivate let coordinator: UsersCoordinatorProtocol
    internal var users: [User] = []
    internal var searchUsers: [User] = []
    
    internal var page: Int = 0
    internal var isSearching: Bool = false
    internal var isCalling: Bool = false

    // MARK: - Init
    init(service: UsersAPIServiceProtocol, coordinator: UsersCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }

    func start() {
        
        guard Reachability.isConnected else {
            let userEntity = User.fetchRequest()
            guard let result = try? CoreDataManager.shared.mainContext.fetch(userEntity) else { return }
            self.users = result
            return
        }
        
        getUsers()
    }
    
    // MARK: - Network
    
    func getUsers() {
        
        Task {
            DispatchQueue.main.async { self.viewDelegate?.showIndicator() }
            let result = await service.getUser(page: page)
            switch result {
            case .success(let list):
                self.users = list
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.updateScreen()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.showError(error: error)
                }
            }
        }
        
    }
    
    func nextPage() {
        
        guard Reachability.isConnected else {
            self.viewDelegate?.showError(error: "Internet not available")
            return
        }
        
        guard !isSearching else { return }
        
        guard !isCalling else { return }
        
        Task {
            DispatchQueue.main.async { self.viewDelegate?.showIndicator() }
            
            self.page = self.page + 1
            self.isCalling.toggle()
            
            let result = await service.getUser(page: page)
            switch result {
            case .success(let newUsers):
                self.users.append(contentsOf: newUsers)
                self.isCalling.toggle()
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.updateScreen()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.showError(error: error)
                }
            }
        }
        
    }
    
    func refresh() {
        
        guard Reachability.isConnected else {
            self.viewDelegate?.showError(error: "Internet not available")
            return
        }
        
        
        
        Task {
            DispatchQueue.main.async {
                self.viewDelegate?.showIndicator()
            }
            self.page = 0
            self.isCalling = false
            self.isSearching = false
            
            
            let result = await service.getUser(page: page)
            switch result {
            case .success(let newUsers):
                self.users.append(contentsOf: newUsers)
                self.isCalling.toggle()
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.updateScreen()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.showError(error: error)
                }
            }
        }
        
    }
    
    func updateUserNote(note: String, user: User) {
        user.notes = note
        CoreDataManager.shared.saveContext()
    }
}

extension UsersViewModel: UsersViewModelType {
    
    // MARK: - Data Source
    
    func numberOfItems() -> Int {
        if isSearching {
            return searchUsers.count
        }
        return users.count
    }
    
    func itemFor(row: Int) -> User {
        if isSearching {
            return searchUsers[row]
        }
        return users[row]
    }
    
    // MARK: - Events
    func searchFor(text: String) {
        
        let userEntity = User.fetchRequest()
        let loginContainPredicate = NSPredicate(format: "login contains[cd] %@", text)
        let noteContainPredicate = NSPredicate(format: "notes contains[cd] %@", text)
        
        let loginPrecisePredicate = NSPredicate(format: "login = %@", text)
        let notePreciseContainPredicate = NSPredicate(format: "notes = %@", text)
        
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [loginContainPredicate, noteContainPredicate, loginPrecisePredicate, notePreciseContainPredicate])
        userEntity.predicate = compoundPredicate
        
        do {
            let result = try CoreDataManager.shared.mainContext.fetch(userEntity)
            searchUsers = result
            self.viewDelegate?.updateScreen()
        } catch {
            
        }
    }
    
    func enableSearch() {
        isSearching = true
    }
    
    func clearSearch() {
        isSearching = false
        searchUsers = []
        self.viewDelegate?.updateScreen()
    }

    func didSelectRow(_ row: Int, from controller: UIViewController) {
        let user = itemFor(row:  row)
        coordinator.showUserDetailViewConroller(from: controller, detail: user)
    }

}
