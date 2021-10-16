import RxCocoa
import RxSwift

public protocol DataSourceProtocol {
    func getRecommendations() -> Observable<[Organization]>
}
