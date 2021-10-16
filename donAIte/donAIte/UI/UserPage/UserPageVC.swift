import UIKit
import RxCocoa
import RxSwift
import SnapKit

//TODO
public class UserPageVC: UIViewController {
    private var viewModel = UserPageVM()
    private let disposedBag = DisposeBag()
    
    let scrollView = UIScrollView()
            
    var sliders = [String:UISlider]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                
        setupBindings()
        setupViews()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func setupViews() {
        var i = 0
        for (key, slider) in sliders {
            view.addSubview(slider)
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.tintColor = .blue
            
            let label = UILabel()
            label.text = key
            view.addSubview(label)
            
            label.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(i*30 + 10)
            }
            
            slider.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom)
            }
            
            i += 1
        }
    }
    
    func setupNavigationBar() {
        let backButtonImage = UIImage(named: "back_button_no_shadow")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.topItem?.title = " "
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupBindings() {
        disposedBag.insert(
            viewModel
                .getUser()
                .bind(with: self) {index, user in
                    self.bind(user: user)
                }
        )
    }
    
    func bind(user: User) {
        for (key, value) in user.preferences {
            let slider = UISlider(frame:CGRect(x: 0, y: 0, width: 300, height: 20))
            slider.center = self.view.center
            slider.value = Float(value)
            sliders[key] = slider
        }
    }
}
