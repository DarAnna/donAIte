import RxSwift
import RxCocoa

public class UserPageVM {
    private let user = BehaviorRelay<User>(value: User())
    
    public func getUser() -> Observable<User> {
        user.asObservable()
    }
  
    public func update() {
        let defaults = UserDefaults.standard
        for (key, value) in user.value.preferences {
            defaults.set(value, forKey: key)
        }
    }
}
