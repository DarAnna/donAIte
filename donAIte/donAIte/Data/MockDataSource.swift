import Foundation
import RxSwift
import RxCocoa

public class MockDataSource: DataSourceProtocol {
    public func getRecommendations() -> Observable<[Organization]> {
        let organization1 = Organization(name: "Doctors Without Borders", link: "https://www.msf.org", category: "health", imageLink: "https://unsplash.com/photos/hIgeoQjS_iE/download?force=true&w=640", description: "We provide medical assistance to people affected by conflict, epidemics, disasters, or exclusion from healthcare.")
        let organization2 = Organization(name: "Greenpeace", link: "https://www.greenpeace.org/international/", category: "environment", imageLink: "https://unsplash.com/photos/dkGjswObGPY/download?force=true&w=640", description: "Greenpeace uses non-violent creative action to pave the way towards a greener, more peaceful world, and to confront the systems that threaten our planet")
        let organization3 = Organization(name: "Service Civil International", link: "https://www.sci-d.de/english", category: "peace", imageLink: "https://unsplash.com/photos/xy0JBTQlRuY/download?force=true&w=640", description: "SCI is a volunteer organization dedicated to promoting a culture of peace by organizing international voluntary projects for people of all ages and backgrounds.")
        let organization4 = Organization(name: "UN Refugee Aid", link: "https://www.uno-fluechtlingshilfe.de/", category: "refugees", imageLink: "https://unsplash.com/photos/rTXKkhHgoVM/download?force=true&w=640", description: "More than 1.2 million refugees and asylum seekers live in Germany as of 2020, and this nonprofit was set up to provide help to individuals who need support and protection.")
        let organization5 = Organization(name: "Amnesty International", link: "https://www.amnesty.org/en/", category: "human rights", imageLink: "https://unsplash.com/photos/P0JL8np1N6k/download?force=true&w=640", description: "Amnesty International is a global movement of more than 10 million people in over 150 countries and territories who campaign to end abuses of human rights.")
        
        return Observable.just([organization1, organization2, organization3, organization4, organization5])
    }

}
