import RxCocoa
import RxSwift
import SnapKit

public class OrganizationListVC: UIViewController, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    private var collectionViewModel: OrganizationListViewModel!
    
    private var topContainer = UIView()
    public var collectionView: UICollectionView!
    private var intermediateTopContainer = UIView()
    private var userButton = UIButton()
    private var titleContainer = UILabel()
    
    private let refreshControl = UIRefreshControl()
    
    let topContainerHeight = 100
    let reuseIdentifier = "cell"
    // variable to save the last position visited, default to zero
    private var lastContentOffset: CGFloat = 0
    
    private let disposedBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(collectionViewModel: OrganizationListViewModel) {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        self.collectionViewModel = collectionViewModel
        setupBindings()
        self.collectionViewModel.loadList()
        print("setting up")
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViews() {
        view.backgroundColor = .clear
        
        setupBlurBackground()
        setupTopContainer()
        setupCollectionView()
    }
    
    func setupBlurBackground() {
        var blurEffect = UIBlurEffect(style: .dark)
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemThinMaterial)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func setupTopContainer() {
        view.addSubview(topContainer)
//        intermediateTopContainer.backgroundColor = .systemPink
        topContainer.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
            make.height.equalTo(topContainerHeight)
        }
        
//        intermediateTopContainer.backgroundColor = .purple
        view.addSubview(intermediateTopContainer)
        intermediateTopContainer.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(10)
        }
        
        // User Button
//        userButton.backgroundColor = .blue
        topContainer.addSubview(userButton)
        
        userButton.snp.makeConstraints { make in
            make.width.equalTo(topContainer.snp.width).dividedBy(7)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(40)
            //make.bottom.equalToSuperview()
        }
        userButton = makeTopContainerButton(title: "User", imageName: "user", view: userButton)


        
        // App Title
//        titleContainer.backgroundColor = .orange
        topContainer.addSubview(titleContainer)
        titleContainer.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-150)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        titleContainer.text = "donAIte"
        titleContainer.font = UIFont.italicSystemFont(ofSize: 30.0)
        titleContainer.textColor = .white
        //makeTopContainerTitle(imageName: "app_title", view: titleContainer)
    }
    
    func makeTopContainerButton(title: String, imageName: String, view: UIView) -> UIButton {
        let button = UIButton()
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }

        return button
    }
        
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.register(OrganizationCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        collectionView.delegate = self
        
        if collectionView != nil {
            view.addSubview(collectionView)
            
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(intermediateTopContainer.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
        }
    }
    
    func setupBindings() {
        disposedBag.insert(
            collectionViewModel
                .getList()
                .bind(to: collectionView.rx.items(cellIdentifier: reuseIdentifier,
                                         cellType: OrganizationCell.self))
                                            { index, organization, cell in
                                                cell.bind(organization: organization)
                                            }
        )
        disposedBag.insert(
            
            collectionView.rx.modelSelected(Organization.self)
                .subscribe(onNext: { Organization in
                    let organizationPage: OrganizationPageVC = OrganizationPageVC()
                    self.navigationController?.pushViewController(organizationPage, animated: true)
                }),
        
            refreshControl.rx.controlEvent(UIControl.Event.valueChanged)
                .subscribe(onNext: { [weak self] in
                    self?.collectionViewModel.loadList()
                    self?.refreshControl.endRefreshing()
                }),
        
            userButton.rx.tap.subscribe(onNext:{ [weak self] _ in
                let vc = UserPageVC()
                print("tap user")
                self?.navigationController?.pushViewController(vc, animated: true)
            })
        )
    }
    
}

// MARK: - Collection View Styling

extension OrganizationListVC: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width - 40
        let cellSize = CGSize(width: size, height: size)
        return cellSize
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return sectionInset
    }
    
}

