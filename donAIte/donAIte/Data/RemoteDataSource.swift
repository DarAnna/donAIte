import RxSwift
import Foundation

public class RemoteDataSource: DataSourceProtocol {
    public func getRecommendations() -> Observable<[Organization]> {
        return Observable.just([])
    }
}
