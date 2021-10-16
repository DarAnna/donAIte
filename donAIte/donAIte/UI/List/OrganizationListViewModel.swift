import RxSwift
import RxCocoa
public class OrganizationListViewModel {
    private let list = BehaviorRelay<[Organization]>(value: [Organization]())
    private let disposedBag = DisposeBag()
    private let dataSource: DataSourceProtocol
    
    public func getList() -> Observable<[Organization]> {
        list.asObservable()
    }
    
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    public func loadList() {
        print("loading list")
        disposedBag.insert(
            self.dataSource.getRecommendations()
                .bind(to: list)
        )
    }
}
