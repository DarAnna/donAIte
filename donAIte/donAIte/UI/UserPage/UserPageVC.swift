import UIKit
import RxCocoa
import RxSwift
import SnapKit

//TODO
public class UserPageVC: UIViewController {
    private var viewModel = UserPageVM()
    private let disposedBag = DisposeBag()
    
    let scrollView = UIScrollView()
    let introduction = UILabel()
    let updateButton = ITButton(title: "Update", background: .blue, size: .medium)
            
    var sliders = [String:UISlider]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        introduction.numberOfLines = 3
        introduction.text = "Please choose how important those aspects are for you in a charity"
        introduction.font = .systemFont(ofSize: 20, weight: .medium)
        view.addSubview(introduction)
        introduction.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }
        var i = 0
        for (key, slider) in sliders {
            let subview = UIView()
            view.addSubview(subview)
            subview.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(i*90 + 110)
                make.height.equalTo(90)
                make.left.equalToSuperview()
            }
            
            let label = UILabel()
            subview.addSubview(label)
            label.text = key
            label.textColor = .black
            label.snp.makeConstraints{ make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(20)
            }
            
            
            subview.addSubview(slider)
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.tintColor = .blue
            slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
            slider.isContinuous = true
            slider.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(10)
                make.width.equalTo(300)
                make.left.equalToSuperview().offset(40)
            }
            slider.isSelected = true
            
            i += 1
        }
        
            view.addSubview(updateButton)
            updateButton.snp.makeConstraints { make in
                //make.center.equalToSuperview()
                make.bottom.equalToSuperview().offset(-20)
                make.left.equalToSuperview().offset(140)
                //make.height.equalTo(30)
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
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
        {
            print("Slider value changed")

           
        }
}
